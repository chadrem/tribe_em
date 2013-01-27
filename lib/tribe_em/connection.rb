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
    end
  end
end
