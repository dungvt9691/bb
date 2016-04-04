module BB
  module Facebook
    class Campaign < BB::Facebook::Model
      attr_accessor :name, :id, :buying_type, :adlabels,
      :can_use_spend_cap, :configured_status, :created_time,
      :effective_status, :objective, :start_time, :account_id,
      :stop_time, :updated_time, :spend_cap, :status, :errors

      # Get all campaigns
      # Return campaigns array
      # Return example:
      # [#<BB::Facebook::Campaign:0x007fc9ca7c1730
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

        req_campaigns = request.list_campaigns(BB::Facebook::Account.id, self.fields)

        unless req_campaigns['error'].nil?
          raise BB::Errors::NotFound, "#{req_campaigns['error']['message']}"
        end

        campaigns = []


        req_campaigns['data'].each do |campaign|
          attributes = self.symbolize_keys!(campaign)

          campaign = BB::Facebook::Campaign.new(attributes)

          campaigns << campaign
        end

        campaigns.sort{|a, b| a.start_time <=> b.start_time}

        campaigns.sort{|a, b| a.effective_status <=> b.effective_status}
      end

      # Filter campaigns
      # Return campaigns array
      # Return example:
      # [#<BB::Facebook::Campaign:0x007fc9ca7c1730
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
      def self.where(filter = {})
        request = BB::Facebook::Request.new(graph: BB::Facebook.graph)

        req_campaigns = request.list_campaigns(BB::Facebook::Account.id, self.fields)

        unless req_campaigns['error'].nil?
          raise BB::Errors::NotFound, "#{req_campaigns['error']['message']}"
        end

        campaigns = []


        req_campaigns['data'].each do |campaign|
          attributes = self.symbolize_keys!(campaign)

          campaign = BB::Facebook::Campaign.new(attributes)

          filter.each do |key, value|
            campaigns << campaign if campaign.to_sym[key] == value
          end
        end

        campaigns
      end

      # Find campaign by id
      # Return campaign object
      # Return example:
      # #<BB::Facebook::Campaign:0x007fc9ca7c1730
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
      def self.find(campaign_id)
        request = BB::Facebook::Request.new(graph: BB::Facebook.graph)

        req_campaign_details = request.get_campaign_details(campaign_id, self.fields)

        unless req_campaign_details['error'].nil?
          raise BB::Errors::NotFound, "#{req_campaign_details['error']['message']}"
        end

        attributes = self.symbolize_keys!(req_campaign_details)

        campaign = BB::Facebook::Campaign.new(attributes)
      end

      # Save a campaign
      # Requires params: name, status, objective
      # Return new campaign object
      # Return example:
      # #<BB::Facebook::Campaign:0x007fc9ca7c1730
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
          requires :name, :status, :objective

          request = BB::Facebook::Request.new(graph: BB::Facebook.graph)

          attributes = self.instance_values

          req_campaign_details = request.create_campaign(BB::Facebook::Account.id, attributes)

          unless req_campaign_details['error'].nil?
            raise BB::Errors::NotFound, "#{req_campaign_details['error']['message']}: #{req_campaign_details['error']['error_user_msg']}"
          end

          campaign = BB::Facebook::Campaign.find(req_campaign_details['id'])

          campaign.instance_values.each do |key, value|
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

      # Create a campaign
      # Requires params: name, status, objective
      # Return new campaign object
      # Return example:
      # #<BB::Facebook::Campaign:0x007fc9ca7c1730
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
        campaign = self.new(attributes)
        if campaign.save
          campaign
        else
          raise BB::Errors::NotFound, campaign.errors
        end
      end

      # Update a campaign
      # Fields can update: 
      #  + name
      # Return edited campaign object
      # Return example:
      # #<BB::Facebook::Campaign:0x007fc9ca7c1730
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
      def update_attributes(attributes)
        begin
          request = BB::Facebook::Request.new(graph: BB::Facebook.graph)

          req_campaign_details = request.update_campaign(self.id, attributes)

          unless req_campaign_details['error'].nil?
            raise BB::Errors::NotFound, "#{req_campaign_details['error']['message']}: #{req_campaign_details['error']['error_user_msg']}"
          end

          campaign = BB::Facebook::Campaign.find(self.id)

          campaign.instance_values.each do |key, value|
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

      # Update a campaign
      # Return true if success, false if failed
      def destroy
        begin
          request = BB::Facebook::Request.new(graph: BB::Facebook.graph)

          req_campaign_details = request.delete_campaign(self.id)

          unless req_campaign_details['error'].nil?
            raise BB::Errors::NotFound, "#{req_campaign_details['error']['message']}: #{req_campaign_details['error']['error_user_msg']}"
          end

          true

        rescue BB::Errors::NotFound => e
          self.errors = e
          false
        rescue Exception => e
          self.errors = eri
          false   
        end
      end

      def ads
        BB::Facebook::Ad.where(campaign_id: self.id)
      end

      def adsets
        BB::Facebook::Adset.where(campaign_id: self.id)
      end

      def insights(filter = {})
        BB::Facebook::Insight.source_id = self.id
        BB::Facebook::Insight.all(filter)
      end
    end
  end
end