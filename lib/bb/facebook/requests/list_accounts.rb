module BB
  module Facebook
    class Request
      # Call to Facebook API to get ad account
      # End point: https://graph.facebook.com/v2.5/me/adaccounts
      # Method: Get
      # Example: 
      # + Request: 
      # + Response:
      def list_accounts(fields = "")
        begin
          path = "me/adaccounts"
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
