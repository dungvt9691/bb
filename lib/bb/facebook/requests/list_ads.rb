module BB
  module Facebook
    class Request
      # Call to Facebook API to get all ads
      # End point: https://graph.facebook.com/v2.5/act_<account_id>/ads
      # Method: Get
      # Example: 
      # + Request: 
      # + Response:
      def list_ads(account_id, fields = "")
        begin
          raise Exception, "Ad account id is required" if account_id.nil?
          
          account_id = account_id.include?("act_") ? account_id : "act_#{account_id}"
          
          fields.delete("status") unless fields.empty?
          fields.delete("errors") unless fields.empty?
          
          unless fields.empty?
            fields << "creative" unless fields.delete("creative_id").nil?
          end
          
          path = "ads"
          uri  = "#{@graph.end_point}/v#{@graph.version}/#{account_id}/#{path}"
          uri += "?access_token=#{@graph.access_token}"
          uri += "&fields=#{fields.join(',')}&limit=5000" unless fields.empty?

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
