module BB
  module Facebook
    class Request
      # Call to Facebook API to create an adset
      # End point: https://graph.facebook.com/v2.5/act_<account_id>/adsets
      # Method: POST
      # Example: 
      # + Request: 
      # + Response:
      def create_adset(account_id, params = {})
        begin
          raise Exception, "Ad account id is required" if account_id.nil?
          
          account_id = account_id.include?("act_") ? account_id : "act_#{account_id}"
          
          path = "adsets"
          uri  = "#{@graph.end_point}/v#{@graph.version}/#{account_id}/#{path}"
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
