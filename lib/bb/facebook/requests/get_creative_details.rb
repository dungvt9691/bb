module BB
  module Facebook
    class Request
      # Call to Facebook API to get creative details
      # End point: https://graph.facebook.com/v2.5/act_<account_id>/creatives
      # Method: Get
      # Example: 
      # + Request: 
      # + Response:
      def get_creative_details(creative_id, fields = "")
        begin
          fields.delete("errors") unless fields.empty?
          
          path = "#{creative_id}"
          uri  = "#{@graph.end_point}/v#{@graph.version}/#{path}"
          uri += "?access_token=#{@graph.access_token}"
          uri += "&fields=#{fields.join(',')}" unless fields.empty?

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
