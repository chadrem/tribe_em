module Tribe
  module EM
    class TcpServer < Tribe::Actor
      private

      def initialize(ip, port, actor_class, options = {})
        super(options)

        @ip = ip || raise('IP is required.')
        @port = port || raise('Port is required.')
        @actor_class = actor_class || raise('Actor class is required.')

        start_listener
      end

      # Override and call super as necessary.
      def on_start_listener(event)
        start_listener
      end

      # Override and call super as necessary.
      def on_stop_listener(event)
        stop_listener
      end

      # Override and call super as necessary.
      def on_listener_started(event)
        @server_sig = event.data
      end

      # Override and call super as necessary.
      def on_listener_stopped(event)
        @server_sig = nil
      end

      # Override and call super as necessary.
      def shutdown_handler(event)
        super

        stop_listener if @server_sig
      end

      def start_listener
        return if @server_sig

        ::EM.schedule do
          sig = ::EM.start_server(@ip, @port, @actor_class.proxy_class, @actor_class, { :logger => @logger })
          message!(:listener_started, sig)
        end
      end

      def stop_listener
        return unless @server_sig

        sig = @server_sig
        ::EM.schedule do
          ::EM.stop_server(sig)
          message!(:listener_stopped)
        end
      end
    end
  end
end
