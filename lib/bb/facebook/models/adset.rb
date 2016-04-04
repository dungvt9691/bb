module BB
  module Facebook
    class Adset < BB::Facebook::Model
      attr_accessor :adlabels, :adset_schedule, :id, :account_id, :bid_amount,
      :bid_info, :billing_event, :campaign_id, :configured_status, :created_time,
      :creative_sequence, :effective_status, :end_time, :frequency_cap,
      :frequency_cap_reset_period, :is_autobid, :lifetime_frequency_cap,
      :lifetime_imps, :name, :optimization_goal, :product_ad_behavior,
      :promoted_object, :rf_prediction_id, :rtb_flag, :start_time, :targeting,
      :updated_time, :use_new_app_click, :pacing_type, :budget_remaining,
      :daily_budget, :lifetime_budget, :errors

      # Get all adsets
      # Return adsets array
      # Return example:
      # Array: 
      # [#<BB::Facebook::Adset:0x007ff22b4e3160
      #  @account_id="xxxx",
      #  @bid_amount=xxxx,
      #  @bid_info={"ACTIONS"=>xxxx},
      #  @billing_event="xxxx",
      #  @budget_remaining="xxxx",
      #  @campaign_id="xxxx",
      #  @configured_status="xxxx",
      #  @created_time="xxxx",
      #  @daily_budget="xxxx",
      #  @effective_status="xxxx",
      #  @frequency_cap=xxxx,
      #  @frequency_cap_reset_period=xxxx,
      #  @id="xxxx",
      #  @is_autobid=xxxx,
      #  @lifetime_budget="xxxx",
      #  @lifetime_frequency_cap=xxxx,
      #  @lifetime_imps=xxxxx,
      #  @name="xxxx",
      #  @optimization_goal="xxxx",
      #  @pacing_type=["xxxx"],
      #  @product_ad_behavior="xxxx",
      #  @promoted_object={"page_id"=>"xxxx"},
      #  @rtb_flag=xxxx,
      #  @start_time="xxxx",
      #  @targeting=xxxx,
      #  @updated_time="xxxx",
      #  @use_new_app_click=xxxx>]
      def self.all
        request = BB::Facebook::Request.new(graph: BB::Facebook.graph)

        req_adsets = request.list_adsets(BB::Facebook::Account.id, self.fields)

        unless req_adsets['error'].nil?
          raise BB::Errors::NotFound, req_adsets['error']['message']
        end

        adsets = []


        req_adsets['data'].each do |adset|
          attributes = self.symbolize_keys!(adset)

          adset = BB::Facebook::Adset.new(attributes)

          adsets << adset
        end

        adsets.sort{|a, b| b.start_time <=> a.start_time}

        adsets.sort{|a, b| a.effective_status <=> b.effective_status}
      end

      # Filter adsets
      # Return adsets array
      # Return example:
      # Array: 
      # [#<BB::Facebook::Adset:0x007ff22b4e3160
      # @account_id="xxxx",
      # @bid_amount=xxxx,
      # @bid_info={"ACTIONS"=>xxxx},
      # @billing_event="xxxx",
      # @budget_remaining="xxxx",
      # @campaign_id="xxxx",
      # @configured_status="xxxx",
      # @created_time="xxxx",
      # @daily_budget="xxxx",
      # @effective_status="xxxx",
      # @frequency_cap=xxxx,
      # @frequency_cap_reset_period=xxxx,
      # @id="xxxx",
      # @is_autobid=xxxx,
      # @lifetime_budget="xxxx",
      # @lifetime_frequency_cap=xxxx,
      # @lifetime_imps=xxxxx,
      # @name="xxxx",
      # @optimization_goal="xxxx",
      # @pacing_type=["xxxx"],
      # @product_ad_behavior="xxxx",
      # @promoted_object={"page_id"=>"xxxx"},
      # @rtb_flag=xxxx,
      # @start_time="xxxx",
      # @targeting=xxxx,
      # @updated_time="xxxx",
      # @use_new_app_click=xxxx>]
      def self.where(filter = {})
        request = BB::Facebook::Request.new(graph: BB::Facebook.graph)

        req_adsets = request.list_adsets(BB::Facebook::Account.id, self.fields)

        unless req_adsets['error'].nil?
          raise BB::Errors::NotFound, "#{req_adsets['error']['message']}"
        end

        adsets = []


        req_adsets['data'].each do |adset|
          attributes = self.symbolize_keys!(adset)

          adset = BB::Facebook::Adset.new(attributes)

          filter.each do |key, value|
            adsets << adset if adset.to_sym[key] == value
          end
        end

        adsets
      end

      # Find adset by id
      # Return adset object
      # Return example:
      # #<BB::Facebook::Adset:0x007ff22b4e3160
      # @account_id="xxxx",
      # @bid_amount=xxxx,
      # @bid_info={"ACTIONS"=>xxxx},
      # @billing_event="xxxx",
      # @budget_remaining="xxxx",
      # @campaign_id="xxxx",
      # @configured_status="xxxx",
      # @created_time="xxxx",
      # @daily_budget="xxxx",
      # @effective_status="xxxx",
      # @frequency_cap=xxxx,
      # @frequency_cap_reset_period=xxxx,
      # @id="xxxx",
      # @is_autobid=xxxx,
      # @lifetime_budget="xxxx",
      # @lifetime_frequency_cap=xxxx,
      # @lifetime_imps=xxxxx,
      # @name="xxxx",
      # @optimization_goal="xxxx",
      # @pacing_type=["xxxx"],
      # @product_ad_behavior="xxxx",
      # @promoted_object={"page_id"=>"xxxx"},
      # @rtb_flag=xxxx,
      # @start_time="xxxx",
      # @targeting=xxxx,
      # @updated_time="xxxx",
      # @use_new_app_click=xxxx>
      def self.find(adset_id)
        request = BB::Facebook::Request.new(graph: BB::Facebook.graph)

        req_adset_details = request.get_adset_details(adset_id, self.fields)

        unless req_adset_details['error'].nil?
          raise BB::Errors::NotFound, req_adset_details['error']['message']
        end

        attributes = self.symbolize_keys!(req_adset_details)

        adset = BB::Facebook::Adset.new(attributes)
      end

      # Save a adset
      # Requires params: name, campaign_id, billing_event, targeting, daily_budget, optimization_goal
      # Requires one: bid_amount, is_autobid
      # Return new adset object
      # Return example:
      def save
        begin
          requires :name, :campaign_id, :billing_event, :targeting, :daily_budget, :optimization_goal
          requires_one :bid_amount, :is_autobid

          campaign = BB::Facebook::Campaign.find(self.campaign_id)
          promoted_objects = ["CONVERSIONS", "PAGE_LIKES", "OFFER_CLAIMS",
                              "MOBILE_APP_INSTALLS", "MOBILE_APP_ENGAGEMENT",
                              "CANVAS_APP_INSTALLS", "CANVAS_APP_ENGAGEMENT",
                              "PRODUCT_CATALOG_SALES"]

          requires :promoted_object if promoted_objects.include? campaign.objective.upcase

          request = BB::Facebook::Request.new(graph: BB::Facebook.graph)

          attributes = self.instance_values

          req_adset_details = request.create_adset(BB::Facebook::Account.id, attributes)

          unless req_adset_details['error'].nil?
            raise BB::Errors::NotFound, "#{req_adset_details['error']['message']}: #{req_adset_details['error']['error_user_msg']}"
          end

          adset = BB::Facebook::Adset.find(req_adset_details['id'])

          adset.instance_values.each do |key, value|
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

      # Create a adset
      # Requires params: name, campaign_id, billing_event, targeting, daily_budget, optimization_goal
      # Requires one: bid_amount, is_autobid
      # Return new adset object
      # Return example:
      def self.create(attributes)
        adset = self.new(attributes)
        if adset.save
          adset
        else
          raise BB::Errors::NotFound, adset.errors
        end
      end

      # Update a adset
      # Fields can update:
      #  + billing_event
      #  + optimization_goal
      #  + name
      #  + targeting
      #  + bid_amount
      #  + adset_schedule
      #  + pacing_type
      #  + lifetime_budget
      #  + daily_budget
      #  + status
      #  + start_time
      #  + end_time
      #  + is_autobid
      # Return edited adset object
      # Return example:
      def update_attributes(attributes)
        begin
          request = BB::Facebook::Request.new(graph: BB::Facebook.graph)

          req_adset_details = request.update_adset(self.id, attributes)

          unless req_adset_details['error'].nil?
            raise BB::Errors::NotFound, "#{req_adset_details['error']['message']}: #{req_adset_details['error']['error_user_msg']}"
          end

          adset = BB::Facebook::Adset.find(self.id)

          adset.instance_values.each do |key, value|
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

      # Update a adset
      # Return true if success, false if failed
      def destroy
        begin
          request = BB::Facebook::Request.new(graph: BB::Facebook.graph)

          req_adset_details = request.delete_adset(self.id)

          unless req_adset_details['error'].nil?
            raise BB::Errors::NotFound, "#{req_adset_details['error']['message']}: #{req_adset_details['error']['error_user_msg']}"
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

      def campaign
        BB::Facebook::Campaign.find(self.campaign_id)
      end

      def ads
        BB::Facebook::Ad.where(adset_id: self.id)
      end

      def insights(filter = {})
        BB::Facebook::Insight.source_id = self.id
        BB::Facebook::Insight.all(filter)
      end
    end
  end
end