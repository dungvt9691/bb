module BB
  module Facebook
    class Image < BB::Facebook::Model
      attr_accessor :id, :hash, :bytes, :url, :account_id, :created_time,
      :updated_time, :errors

      # Get all images
      # Return images array
      # Return example:
      # [#<BB::Facebook::Image:0x007fc9ca7c1730
      #  @buying_type="xxxx",
      #  @can_use_spend_cap=xxxx,
      #  @configured_status="xxxx",
      #  @created_time="xxxx",
      #  @effective_status="xxxx",
      #  @id="xxxx",
      #  @name="xxxx",
      #  @objective="xxxx",
      #  @start_time="xxxx",
      #  @updated_time="xxxx">]
      def self.all
        request = BB::Facebook::Request.new(graph: BB::Facebook.graph)

        req_images = request.list_images(BB::Facebook::Account.id, self.fields)

        unless req_images['error'].nil?
          raise BB::Errors::NotFound, "#{req_images['error']['message']}"
        end

        images = []


        req_images['data'].each do |image|
          attributes = self.symbolize_keys!(image)

          image = BB::Facebook::Image.new(attributes)

          images << image
        end

        images
      end

      # Find image by id
      # Return image object
      # Return example:
      # #<BB::Facebook::Image:0x007fc9ca7c1730
      # @buying_type="xxxx",
      # @can_use_spend_cap=xxxx,
      # @configured_status="xxxx",
      # @created_time="xxxx",
      # @effective_status="xxxx",
      # @id="xxxx",
      # @name="xxxx",
      # @objective="xxxx",
      # @start_time="xxxx",
      # @updated_time="xxxx">
      def self.find(image_id)
        self.all.detect {|image| image.id == image_id}
      end

      # Save a image
      # Requires params: name, status, objective
      # Return new image object
      # Return example:
      # #<BB::Facebook::Image:0x007fc9ca7c1730
      # @buying_type="xxxx",
      # @can_use_spend_cap=xxxx,
      # @configured_status="xxxx",
      # @created_time="xxxx",
      # @effective_status="xxxx",
      # @id="xxxx",
      # @name="xxxx",
      # @objective="xxxx",
      # @start_time="xxxx",
      # @updated_time="xxxx">
      def save
        begin
          requires :bytes

          request = BB::Facebook::Request.new(graph: BB::Facebook.graph)

          attributes = self.instance_values

          req_image_details = request.create_image(BB::Facebook::Account.id, attributes)

          unless req_image_details['error'].nil?
            raise BB::Errors::NotFound, "#{req_image_details['error']['message']}: #{req_image_details['error']['error_user_msg']}"
          end

          begin
            attributes = {
              hash: req_image_details['images']['bytes']['hash'],
              url:  req_image_details['images']['bytes']['url']
            }
          rescue Exception => e
            raise BB::Errors::NotFound, "Convert Image Error"
          end

          image = BB::Facebook::Image.new(attributes)

          image.instance_values.each do |key, value|
            send("#{key.to_s}=", value) rescue false
          end

          true

        rescue BB::Errors::NotFound => e
          self.errors = e
          false
        rescue Exception => e
          self.errors = e
          false   
        end
      end

      # Create a image
      # Requires params: name, status, objective
      # Return new image object
      # Return example:
      # #<BB::Facebook::Image:0x007fc9ca7c1730
      # @buying_type="xxxx",
      # @can_use_spend_cap=xxxx,
      # @configured_status="xxxx",
      # @created_time="xxxx",
      # @effective_status="xxxx",
      # @id="xxxx",
      # @name="xxxx",
      # @objective="xxxx",
      # @start_time="xxxx",
      # @updated_time="xxxx">
      def self.create(attributes)
        image = self.new(attributes)
        if image.save
          image
        else
          raise BB::Errors::NotFound, image.errors
        end
      end
    end
  end
end