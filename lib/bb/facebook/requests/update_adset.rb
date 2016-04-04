module BB
  module Facebook
    class Request
      # Call to Facebook API to update a adset
      # End point: https://graph.facebook.com/v2.5/<adset_id>
      # Method: POST
      # Example: 
      # + Request: 
      # + Response:
      def update_adset(adset_id, params = {})
        begin
          path = "#{adset_id}"
          uri  = "#{@graph.end_point}/v#{@graph.version}/#{path}"
          uri += "?access_token=#{@graph.access_token}"
          req = BB::Req.post(uri, params)
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
