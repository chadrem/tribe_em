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

      def on_start_listener(event)
        start_listener
      end

      def on_stop_listener(event)
        stop_listener
      end

      def on_listener_started(event)
        @server_sig = event.data
      end

      def on_listener_stopped(event)
        @server_sig = nil
      end

      def shutdown_handler(event)
        stop_listener if @server_sig
      end

      def start_listener
        return if @server_sig

        ::EM.schedule do
          sig = ::EM.start_server(@ip, @port, @conn_class)
          enqueue(:listener_started, sig)
        end
      end

      def stop_listener
        return unless @server_sig

        sig = @server_sig
        ::EM.schedule do
          ::EM.stop_server(sig)
          enqueue(:listener_stopped)
        end
      end
    end
  end
end
