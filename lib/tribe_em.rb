require 'tribe'
require 'eventmachine'

require 'tribe_em/version'
require 'tribe_em/connection'
require 'tribe_em/tcp_server'

module Tribe
  module EM
    def self.start
      @em_thread = Thread.new do
        ::EM.run do
          ::EM.kqueue = true if ::EM.kqueue?
          ::EM.epoll = true if ::EM.epoll?
        end
      end

      return nil
    end

    def self.stop
      ::EM.stop_event_loop
      @em_thread.join if @em_thread
      @em_thread = nil

      return nil
    end

    def self.running?
      return ::EM.reactor_running?
    end
  end
end

# Force EM to run.
Tribe::EM.start
