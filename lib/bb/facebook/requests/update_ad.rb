module BB
  module Facebook
    class Request
      # Call to Facebook API to update a ad
      # End point: https://graph.facebook.com/v2.5/<ad_id>
      # Method: POST
      # Example: 
      # + Request: 
      # + Response:
      def update_ad(ad_id, params = {})
        begin
          path = "#{ad_id}"
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