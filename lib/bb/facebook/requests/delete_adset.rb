module BB
  module Facebook
    class Request
      # Call to Facebook API to delete an adset
      # End point: https://graph.facebook.com/v2.5/<adset_id>
      # Method: DELETE
      # Example: 
      # + Request: 
      # + Response:
      def delete_adset(adset_id)
        begin
          path = "#{adset_id}"
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
