module BB
  module Facebook
    class Request
      # Call to Facebook API to delete a campaign
      # End point: https://graph.facebook.com/v2.5/<campaign_id>
      # Method: DELETE
      # Example: 
      # + Request: 
      # + Response:
      def delete_campaign(campaign_id)
        begin
          path = "#{campaign_id}"
          uri  = "#{@graph.end_point}/v#{@graph.version}/#{path}"
          uri += "?access_token=#{@graph.access_token}"

          req = BB::Req.delete(uri)
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
