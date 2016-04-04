module BB
  module Facebook
    class Request
      # Call to Facebook API to get account details
      # End point: https://graph.facebook.com/v2.5/act_<account_id>/accounts
      # Method: Get
      # Example: 
      # + Request: 
      # + Response:
      def get_account_details(account_id, fields = "")
        begin
          raise Exception, "Ad account id is required" if account_id.nil?

          account_id = account_id.include?("act_") ? account_id : "act_#{account_id}"

          path = "#{account_id}"
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
