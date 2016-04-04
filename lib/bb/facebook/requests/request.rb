module BB
  module Facebook
    class Request
      attr_accessor :graph

      def initialize(attributes)
        @graph = attributes[:graph]
      end

    end
  end
end
