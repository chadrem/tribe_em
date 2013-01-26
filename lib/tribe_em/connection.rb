module Tribe
  module EM
    class Connection < ::EM::Connection
      include Tribe::Actable

      def initialize(options = {})
        init_actable(options)
      end

      def post_init
        enqueue(:post_init, nil)
      end

      def receive_data(data)
        enqueue(:receive_data, data)
      end

      def unbind
        enqueue(:unbind, nil)
      end
    end
  end
end
