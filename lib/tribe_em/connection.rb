module Tribe
  module EM
    class Connection < Tribe::Actor
      # The Proxy class is what separates the EM connection and Tribe actor.
      def self.proxy_class
        return Tribe::EM::ActorProxy
      end

      private

      def initialize(options = {})
        @actor_proxy = options[:actor_proxy] || raise('You must provide an actor proxy.')

        super
      end

      # Override and call super as necessary.
      def on_post_init(event)
      end

      # Override and call super as necessary.
      def on_receive_data(event)
      end

      # Override and call super as necessary.
      def on_unbind(event)
        shutdown!
      end

      # Override and call super as necessary.
      def exception_handler(e)
        super

        close
      end

      # Override and call super as necessary.
      def shutdown_handler(event)
        super

        close(true)
      end

      def write(data)
        @actor_proxy.write(data)
      end

      def close(after_writing = false)
        @actor_proxy.close(after_writing)
      end
    end
  end
end
