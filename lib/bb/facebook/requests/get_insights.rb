module BB
  module Facebook
    class Request
      # Call to Facebook API to get ad insights
      # End point: https://graph.facebook.com/v2.5/me/adinsightss
      # Method: Get
      # Example: 
      # + Request: 
      # + Response:
      def get_insights(source_id, filter = {})
        begin
          path = "#{source_id}/insights"
          uri  = "#{@graph.end_point}/v#{@graph.version}/#{path}"
          uri += "?access_token=#{@graph.access_token}"

          filter.each do |key, value|
            uri += "&#{key}=#{URI.escape(value.to_s)}" if not value.nil?
          end

          req = BB::Req.get(uri)

        rescue Exception => e
          {
            'error' => {
              'message' => e.message,
              "type" => "Exception",
              "code" => 500,
            }
          }
        end
      end
    end
  end
end
