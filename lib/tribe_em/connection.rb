module Tribe
  module EM
    class Connection < Tribe::Actor
      # The Proxy class is what separates the EM connection and Tribe actor.
      def self.proxy_class
        return Tribe::EM::ActorProxy
      end

      private

      def initialize(options = {})
        @_actor_proxy = options[:actor_proxy] || raise('You must provide an actor proxy.')

        super
      end

      def write(data)
        @_actor_proxy.write(data)
      end

      def close(after_writing = false)
        @_actor_proxy.close(after_writing)
      end

      #
      # Command handlers.
      #

      def on_post_init(event)
        post_init_handler
      end

      def on_receive_data(event)
        receive_data_handler(event.data)
      end

      def on_unbind(event)
        shutdown!
        unbind_handler
      end

      #
      # System handlers.
      #

      def exception_handler(e)
        super

        close
      end

      def shutdown_handler(event)
        super

        close(true)
      end

      def post_init_handler
      end

      def receive_data_handler(data)
      end

      def unbind_handler
      end
    end
  end
end
