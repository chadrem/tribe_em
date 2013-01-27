# Tribe EM

Tribe EM is a Ruby gem that adds event-driven network IO to [Tribe] (https://github.com/chadrem/tribe "Tribe").
It is based on [EventMachine] (http://rubyeventmachine.com/ "EventMachine").

## Installation

Add this line to your application's Gemfile:

    gem 'tribe_em'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install tribe_em

## Usage

You can test the below code using a utility such as telnet (telnet localhost 9000), entering some text, and then killing telnet.

    # Create a custom connection actor class.
    class MyConn < Tribe::EM::Connection
      private
      
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
    
    # Create your server actor.
    server = Tribe::EM::TcpServer.new('localhost', 9000, MyConn)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
