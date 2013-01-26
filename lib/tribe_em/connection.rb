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

      def process_event(event)
        case event.command
        when :post_init
          post_init_handler(event)
        when :receive_data
          receive_data_handler(event)
        when :unbind
          unbind_handler(event)
        end
      end

      def post_init_handler(event)
        puts "Actor (#{identifier}) connected to client using thread (#{Thread.current.object_id})."
      end

      def receive_data_handler(event)
        puts "Actor (#{identifier}) received data (#{event.data}) using thread (#{Thread.current.object_id})."
      end

      def unbind_handler(event)
        puts "Actor (#{identifier}) disconnected from client using thread (#{Thread.current.object_id})."
      end
    end
  end
end
