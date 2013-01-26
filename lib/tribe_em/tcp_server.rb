module Tribe
  module EM
    class TcpServer < Tribe::Actor
      private

      def initialize(ip, port, conn_class, options = {})
        super(options)

        @ip = ip
        @port = port
        @conn_class = conn_class

        start_listener
      end

      def process_event(event)
        case event.command
        when :start_listener
          start_listener_handler(event)
        when :stop_listener
          stop_listener_handler(event)
        end
      end

      def start_listener_handler(event)
        start_listener
      end

      def stop_listener_handler(event)
        stop_listener
      end

      def shutdown_handler(event)
        stop_server
      end

      def set_server_sig_handler(event)
        @server_sig = event.data
      end

      def start_listener
        return if @server_sig

        @server_sig = ::EM.start_server(@ip, @port, @conn_class)
      end

      def stop_listener
        return unless @server_sig

        ::EM.stop_server(@server_sig)
        @server_sig = nil
      end
    end
  end
end
