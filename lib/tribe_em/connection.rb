module Tribe
  module EM
    class Connection < Tribe::Actor
      private

      def initialize(options = {})
        @actor_proxy = options[:actor_proxy] || raise('You must provide an actor proxy.')

        super
      end

      def on_post_init(event)
      end

      def on_receive_data(event)
      end

      def on_unbind(event)
        enqueue(:shutdown)
      end

      def exception_handler(e)
        close
      end

      def shutdown_handler(event)
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
