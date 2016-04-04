module BB
  module Facebook
    class Creative < BB::Facebook::Model
      attr_accessor :id, :actor_id, :adlabels, :body, :call_to_action_type,
      :image_hash, :image_url, :instagram_actor_id, :instagram_permalink_url,
      :link_og_id, :link_url, :name, :object_id, :object_url, :object_story_spec,
      :object_story_id, :object_type, :product_set_id, :run_status,
      :template_url, :thumbnail_url, :title, :url_tags, :applink_treatment, :errors

      # Get all creatives
      # Return creatives array
      # Return example:
      # [#<BB::Facebook::Creative:0x007fd8c52af8c8
      #  @id="xxxx",
      #  @name="xxxx",
      #  @object_story_id="xxxx",
      #  @object_type="xxxx",
      #  @run_status="xxxx",
      #  @thumbnail_url= "xxxx>]
      def self.all
        request = BB::Facebook::Request.new(graph: BB::Facebook.graph)

        req_creatives = request.list_creatives(BB::Facebook::Account.id, self.fields)

        unless req_creatives['error'].nil?
          raise BB::Errors::NotFound, req_creatives['error']['message']
        end

        creatives = []


        req_creatives['data'].each do |creative|
          attributes = self.symbolize_keys!(creative)

          creative = BB::Facebook::Creative.new(attributes)

          creatives << creative
        end

        creatives
      end

      # Filter creatives
      # Return creatives array
      # Return example:
      # Array: 
      # [#<BB::Facebook::Creative:0x007fd8c52af8c8
      #  @id="xxxx",
      #  @name="xxxx",
      #  @object_story_id="xxxx",
      #  @object_type="xxxx",
      #  @run_status="xxxx",
      #  @thumbnail_url= "xxxx>]
      def self.where(filter = {})
        request = BB::Facebook::Request.new(graph: BB::Facebook.graph)

        req_creatives = request.list_creatives(BB::Facebook::Account.id, self.fields)

        unless req_creatives['error'].nil?
          raise BB::Errors::NotFound, "#{req_creatives['error']['message']}"
        end

        creatives = []


        req_creatives['data'].each do |creative|
          attributes = self.symbolize_keys!(creative)

          creative = BB::Facebook::Creative.new(attributes)

          filter.each do |key, value|
            creatives << creative if creative.to_sym[key] == value
          end
        end

        creatives
      end

      # Find creative by id
      # Return creative object
      # Return example:
      # #<BB::Facebook::Creative:0x007fd8c52af8c8
      # @id="xxxx",
      # @name="xxxx",
      # @object_story_id="xxxx",
      # @object_type="xxxx",
      # @run_status="xxxx",
      # @thumbnail_url= "xxxx">
      def self.find(creative_id)
        request = BB::Facebook::Request.new(graph: BB::Facebook.graph)

        req_creative_details = request.get_creative_details(creative_id, self.fields)

        unless req_creative_details['error'].nil?
          raise BB::Errors::NotFound, req_creative_details['error']['message']
        end

        attributes = self.symbolize_keys!(req_creative_details)

        creative = BB::Facebook::Creative.new(attributes)
      end

      # Save a creative
      # Requires only: object_story_spec, object_story_id, object_url
      # Return new creative object
      # Return example:
      # #<BB::Facebook::Creative:0x007fd8c52af8c8
      # @id="xxxx",
      # @name="xxxx",
      # @object_story_id="xxxx",
      # @object_type="xxxx",
      # @run_status="xxxx",
      # @thumbnail_url= "xxxx">
      def save
        begin
          requires_only :object_story_spec, :object_story_id, :object_url

          unless self.object_url.blank?
            requires :title, :body, :image_hash
          end

          request = BB::Facebook::Request.new(graph: BB::Facebook.graph)

          attributes = self.instance_values

          req_creative_details = request.create_creative(BB::Facebook::Account.id, attributes)

          unless req_creative_details['error'].nil?
            raise BB::Errors::NotFound, "#{req_creative_details['error']['message']}: #{req_creative_details['error']['error_user_msg']}"
          end

          creative = BB::Facebook::Creative.find(req_creative_details['id'])

          creative.instance_values.each do |key, value|
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

      # Create a creative
      # Requires only: object_story_spec, object_story_id, object_url
      # Return new creative object
      # Return example:
      # #<BB::Facebook::Creative:0x007fd8c52af8c8
      # @id="xxxx",
      # @name="xxxx",
      # @object_story_id="xxxx",
      # @object_type="xxxx",
      # @run_status="xxxx",
      # @thumbnail_url= "xxxx">
      def self.create(attributes)
        creative = self.new(attributes)
        if creative.save
          creative
        else
          raise BB::Errors::NotFound, creative.errors
        end
      end

      # Update a creative
      # Fields can update: 
      #  + name
      # Return edited creative object
      # Return example:
      # #<BB::Facebook::Creative:0x007fd8c52af8c8
      # @id="xxxx",
      # @name="xxxx",
      # @object_story_id="xxxx",
      # @object_type="xxxx",
      # @run_status="xxxx",
      # @thumbnail_url= "xxxx">
      def update_attributes(attributes)
        begin
          request = BB::Facebook::Request.new(graph: BB::Facebook.graph)

          req_creative_details = request.update_creative(self.id, attributes)

          unless req_creative_details['error'].nil?
            raise BB::Errors::NotFound, "#{req_creative_details['error']['message']}: #{req_creative_details['error']['error_user_msg']}"
          end

          creative = BB::Facebook::Creative.find(self.id)

          creative.instance_values.each do |key, value|
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

      # Update a creative
      # Return true if success, false if failed
      def destroy
        begin
          request = BB::Facebook::Request.new(graph: BB::Facebook.graph)

          req_creative_details = request.delete_creative(self.id)

          unless req_creative_details['error'].nil?
            raise BB::Errors::NotFound, "#{req_creative_details['error']['message']}: #{req_creative_details['error']['error_user_msg']}"
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
    end
  end
end