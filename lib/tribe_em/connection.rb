module Tribe
  module EM
    class Connection < ::EM::Connection
      include Tribe::Actable

      # EM callback.  Don't call directly.
      def post_init
        enqueue(:post_init, nil)
      end

      # EM callback.  Don't call directly.
      def receive_data(data)
        enqueue(:receive_data, data)
      end

      # EM callback.  Don't call directly.
      def unbind
        enqueue(:unbind, nil)
      end

      private

      def initialize(options = {})
        init_actable(options)
      end

      def on_post_init(event)
        puts "Actor (#{identifier}) connected to client using thread (#{Thread.current.object_id})."
      end

      def on_receive_data(event)
        puts "Actor (#{identifier}) received data (#{event.data}) using thread (#{Thread.current.object_id})."
      end

      def on_unbind(event)
        puts "Actor (#{identifier}) disconnected from client using thread (#{Thread.current.object_id})."
      end

      def exception_handler(e)
        super
        close
      end

      def shutdown_handler(event)
        puts "MyActor (#{identifier}) is shutting down.  Put cleanup code here."
        close
      end

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
