module BB
  class Service
    attr_accessor :auth_code, :partner, :end_point, :version

    def initialize(attributes)
      @partner   = attributes[:partner]
      case @partner
      when "facebook"
        @auth_code = attributes[:auth_code]
        @end_point = attributes[:end_point]
        @version   = attributes[:version]
      end
    end

    def request
      BB::Request.new(end_point: end_point)
    end

    def facebook
      validate_facebook(auth_code: @auth_code, end_point: @end_point, version: @version)
      BB::Facebook::Graph.new(access_token: @auth_code, end_point: @end_point, version: @version)
    end

    private
    def validate_facebook(attributes)
      e = "Graph API does not work without an access token"
      raise e if attributes[:auth_code].nil?
      e = "Graph API does not work without end point"
      raise e if attributes[:end_point].nil?
      e = "Graph API does not work without version"
      raise e if attributes[:version].nil?
    end
  end
end