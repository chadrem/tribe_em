module Tribe
  module EM
    class Connection < Tribe::Actor
      private

      def initialize(options = {})
        @actor_proxy = options[:actor_proxy] || 'You must provide an actor proxy.'

        super
      end

      def on_post_init(event)
        puts "Actor (#{identifier}) connected to client using thread (#{Thread.current.object_id})."
      end

      def on_receive_data(event)
        puts "Actor (#{identifier}) received data (#{event.data}) using thread (#{Thread.current.object_id})."
        write(event.data)
      end

      def on_unbind(event)
        puts "Actor (#{identifier}) disconnected from client using thread (#{Thread.current.object_id})."
      end

      def exception_handler(e)
        super

        close # Don't forget to call this if you override!
      end

      def shutdown_handler(event)
        super

        close # Don't forget to call this if you override!
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
