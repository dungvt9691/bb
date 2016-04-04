module BB
  module Facebook
    class Ad < BB::Facebook::Model
      attr_accessor :id, :account_id, :adlabels, :adset_id, :bid_amount,
      :bid_info, :bid_type, :configured_status, :conversion_specs,
      :created_time, :creative_id, :effective_status, :last_updated_by_app_id,
      :name, :tracking_specs, :updated_time, :campaign_id, :status, :errors

      # Get all ads
      # Return ads array
      # Return example:
      # [#<BB::Facebook::Ad:0x007f8a425810c8
      #  @account_id="xxxx",
      #  @adset_id="xxxx",
      #  @bid_amount=xxxx,
      #  @bid_info=xxxx,
      #  @bid_type="xxxx",
      #  @campaign_id="xxxx",
      #  @configured_status="xxxx",
      #  @conversion_specs=xxxx,
      #  @created_time="xxxx",
      #  @effective_status="xxxx",
      #  @id="xxxx",
      #  @last_updated_by_app_id="xxxx",
      #  @name="xxxx",
      #  @updated_time="xxxx">]
      def self.all
        request = BB::Facebook::Request.new(graph: BB::Facebook.graph)

        req_ads = request.list_ads(BB::Facebook::Account.id, self.fields)

        unless req_ads['error'].nil?
          raise BB::Errors::NotFound, req_ads['error']['message']
        end

        ads = []


        req_ads['data'].each do |ad|

          attributes = self.symbolize_keys!(ad)

          unless ad['creative'].nil?
            attributes[:creative_id] = ad['creative']['id'] unless ad['creative']['id'].nil?
            attributes.delete(:creative)
          end

          ad = BB::Facebook::Ad.new(attributes)

          ads << ad
        end

        ads.sort{|a, b| b.created_time <=> a.created_time}

        ads.sort{|a, b| a.effective_status <=> b.effective_status}
      end

      # Filter ads
      # Return ads array
      # Return example:
      # Array: 
      # [#<BB::Facebook::Ad:0x007f8a425810c8
      #  @account_id="xxxx",
      #  @adset_id="xxxx",
      #  @bid_amount=xxxx,
      #  @bid_info=xxxx,
      #  @bid_type="xxxx",
      #  @campaign_id="xxxx",
      #  @configured_status="xxxx",
      #  @conversion_specs=xxxx,
      #  @created_time="xxxx",
      #  @effective_status="xxxx",
      #  @id="xxxx",
      #  @last_updated_by_app_id="xxxx",
      #  @name="xxxx",
      #  @updated_time="xxxx">]
      def self.where(filter = {})
        request = BB::Facebook::Request.new(graph: BB::Facebook.graph)

        req_ads = request.list_ads(BB::Facebook::Account.id, self.fields)

        unless req_ads['error'].nil?
          raise BB::Errors::NotFound, "#{req_ads['error']['message']}"
        end

        ads = []


        req_ads['data'].each do |ad|
          attributes = self.symbolize_keys!(ad)

          unless ad['creative'].nil?
            attributes[:creative_id] = ad['creative']['id'] unless ad['creative']['id'].nil?
            attributes.delete(:creative)
          end

          ad = BB::Facebook::Ad.new(attributes)

          filter.each do |key, value|
            ads << ad if ad.to_sym[key] == value
          end
        end

        ads
      end

      # Find ad by id
      # Return ad object
      # Return example:
      # #<BB::Facebook::Ad:0x007f8a425810c8
      # @account_id="xxxx",
      # @adset_id="xxxx",
      # @bid_amount=xxxx,
      # @bid_info=xxxx,
      # @bid_type="xxxx",
      # @campaign_id="xxxx",
      # @configured_status="xxxx",
      # @conversion_specs=xxxx,
      # @created_time="xxxx",
      # @effective_status="xxxx",
      # @id="xxxx",
      # @last_updated_by_app_id="xxxx",
      # @name="xxxx",
      # @updated_time="xxxx">
      def self.find(ad_id)
        request = BB::Facebook::Request.new(graph: BB::Facebook.graph)

        req_ad_details = request.get_ad_details(ad_id, self.fields)

        unless req_ad_details['error'].nil?
          raise BB::Errors::NotFound, req_ad_details['error']['message']
        end

        attributes = self.symbolize_keys!(req_ad_details)

        unless req_ad_details['creative'].nil?
          unless req_ad_details['creative']['id'].nil?
            attributes[:creative_id] = req_ad_details['creative']['id']
            attributes.delete(:creative)
          end
        end

        ad = BB::Facebook::Ad.new(attributes)

      end

      # Save a ad
      # Requires params: creative, status, name, adset_id
      # Return new ad object
      # Return example:
      # #<BB::Facebook::Ad:0x007f8a425810c8
      # @account_id="xxxx",
      # @adset_id="xxxx",
      # @bid_amount=xxxx,
      # @bid_info=xxxx,
      # @bid_type="xxxx",
      # @campaign_id="xxxx",
      # @configured_status="xxxx",
      # @conversion_specs=xxxx,
      # @created_time="xxxx",
      # @effective_status="xxxx",
      # @id="xxxx",
      # @last_updated_by_app_id="xxxx",
      # @name="xxxx",
      # @updated_time="xxxx">
      def save
        begin
          requires :creative_id, :status, :name, :adset_id

          request = BB::Facebook::Request.new(graph: BB::Facebook.graph)

          attributes = self.instance_values

          attributes.delete("creative_id")

          attributes['creative'] = {"creative_id" => self.creative_id}

          req_ad_details = request.create_ad(BB::Facebook::Account.id, attributes)

          unless req_ad_details['error'].nil?
            raise BB::Errors::NotFound, "#{req_ad_details['error']['message']}: #{req_ad_details['error']['error_user_msg']}"
          end

          ad = BB::Facebook::Ad.find(req_ad_details['id'])

          ad.instance_values.each do |key, value|
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

      # Create a ad
      # Requires params: creative, status, name, adset_id
      # Return new ad object
      # Return example:
      # #<BB::Facebook::Ad:0x007f8a425810c8
      # @account_id="xxxx",
      # @adset_id="xxxx",
      # @bid_amount=xxxx,
      # @bid_info=xxxx,
      # @bid_type="xxxx",
      # @campaign_id="xxxx",
      # @configured_status="xxxx",
      # @conversion_specs=xxxx,
      # @created_time="xxxx",
      # @creative=xxxx,
      # @effective_status="xxxx",
      # @id="xxxx",
      # @last_updated_by_app_id="xxxx",
      # @name="xxxx",
      # @updated_time="xxxx">
      def self.create(attributes)
        ad = self.new(attributes)
        if ad.save
          ad
        else
          raise BB::Errors::NotFound, ad.errors
        end
      end

      # Update a ad
      # Fields can update: 
      #  + name
      # Return edited ad object
      # Return example:
      # #<BB::Facebook::Ad:0x007f8a425810c8
      # @account_id="xxxx",
      # @adset_id="xxxx",
      # @bid_amount=xxxx,
      # @bid_info=xxxx,
      # @bid_type="xxxx",
      # @campaign_id="xxxx",
      # @configured_status="xxxx",
      # @conversion_specs=xxxx,
      # @created_time="xxxx",
      # @creative=xxxx,
      # @effective_status="xxxx",
      # @id="xxxx",
      # @last_updated_by_app_id="xxxx",
      # @name="xxxx",
      # @updated_time="xxxx">
      def update_attributes(attributes)
        begin
          request = BB::Facebook::Request.new(graph: BB::Facebook.graph)

          req_ad_details = request.update_ad(self.id, attributes)

          unless req_ad_details['error'].nil?
            raise BB::Errors::NotFound, "#{req_ad_details['error']['message']}: #{req_ad_details['error']['error_user_msg']}"
          end

          ad = BB::Facebook::Ad.find(self.id)

          ad.instance_values.each do |key, value|
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

      # Update a ad
      # Return true if success, false if failed
      def destroy
        begin
          request = BB::Facebook::Request.new(graph: BB::Facebook.graph)

          req_ad_details = request.delete_ad(self.id)

          unless req_ad_details['error'].nil?
            raise BB::Errors::NotFound, "#{req_ad_details['error']['message']}: #{req_ad_details['error']['error_user_msg']}"
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

      def insights(filter = {})
        BB::Facebook::Insight.source_id = self.id
        BB::Facebook::Insight.all(filter)
      end

      def adset
        BB::Facebook::Adset.find(self.adset_id)
      end

      def campaign
        BB::Facebook::Campaign.find(self.campaign_id)
      end

      def creative
        BB::Facebook::Creative.find(self.creative_id)
      end
    end
  end
end