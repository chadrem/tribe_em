# Attempt to provide thread-safe communication between EventMachine and Tribe:
# 1. Always use EM.schedule to push work to the reactor thread.
# 2. Always use @actor.message! to push work to the actor's thread pool.

module Tribe
  module EM
    class ActorProxy < ::EM::Connection
      private

      def initialize(actor_class, options = {})
        @actor_class = actor_class || raise('You must provide an actor class.')
        @logger = Workers::LogProxy.new(options[:logger])

        @actor = @actor_class.new({ :actor_proxy => self, :logger => @logger })
      end

      #
      # EM Callbacks.  Don't call these directly.
      #

      public

      def post_init
        @actor.message!(:post_init, nil)
      end

      def receive_data(data)
        @actor.message!(:receive_data, data)
      end

      def unbind
        @actor.message!(:unbind, nil)
      end

      #
      # Public methods.  Call these from the associated actor.
      #

      public

      def close(after_writing = false)
        ::EM.schedule { close_connection(after_writing) }

        return nil
      end

      def write(data)
        ::EM.schedule { send_data(data) }

        return nil
      end
    end
  end
end
