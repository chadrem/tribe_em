module Tribe
  module EM
    class DedicatedConnection < Tribe::EM::Connection
      private

      def initialize(options = {})
        options[:dedicated] = true

        super(options)
      end
    end
  end
end
