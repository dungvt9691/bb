module BB
  module Facebook
    class Graph
      attr_accessor :access_token, :end_point, :version

      def initialize(attributes)
        validate_graph(attributes)
        @access_token = attributes[:access_token]
        @end_point   = attributes[:end_point]
        @version      = attributes[:version]
      end

      private
      def validate_graph(attributes)
        e = "Graph API does not work without an access token"
        raise e if attributes[:access_token].nil?
        e = "Graph API does not work without end point"
        raise e if attributes[:end_point].nil?
        e = "Graph API does not work without version"
        raise e if attributes[:version].nil?
      end
    end
  end
end