module BB
  module Facebook
    class Account < BB::Facebook::Model
      attr_accessor :id, :account_groups, :account_status,
      :age, :agency_client_declaration, :amount_spent,
      :balance, :business_city, :business_country_code,
      :business_name, :business_state, :business_street2,
      :business_street, :business_zip, :capabilities,
      :created_time, :currency, :end_advertiser,
      :funding_source, :funding_source_details,
      :account_id, :is_personal, :media_agency, :name,
      :offsite_pixels_tos_accepted, :partner,
      :spend_cap, :timezone_id, :timezone_name,
      :timezone_offset_hours_utc, :tos_accepted, :tax_id_status

      def self.id=(id)
        @id = id
      end

      def self.id
        @id
      end

      # Get all accounts
      # Return accounts array
      # Return example:
      # [<BB::Facebook::Account:0x007f9a3c089cc8
      #  @account_status=xxxx,
      #  @age=xxxx,
      #  @amount_spent="xxxx",
      #  @balance="xxxx",
      #  @business_city="",
      #  @business_country_code="xxxx",
      #  @business_name="",
      #  @business_street="",
      #  @business_street2="",
      #  @capabilities=xxx,
      #  @created_time="xxxx",
      #  @currency="xxxx",
      #  @funding_source="xxxx",
      #  @funding_source_details={:id=>"xxxx", :display_string=>"Visa *xxxx", :type=>xxxx},
      #  @id="act_xxxx",
      #  @is_personal=xxxx,
      #  @name="xxxx",
      #  @offsite_pixels_tos_accepted=true,
      #  @spend_cap="xxxx",
      #  @tax_id_status=xxxx,
      #  @timezone_id=xxxx,
      #  @timezone_name="xxxx",
      #  @timezone_offset_hours_utc=xxxx,
      #  @tos_accepted={:web_custom_audience_tos=>xxxx}>]
      def self.all
        request = BB::Facebook::Request.new(graph: BB::Facebook.graph)

        req_accounts = request.list_accounts(self.fields)

        unless req_accounts['error'].nil?
          raise BB::Errors::NotFound, req_accounts['error']['message']
        end

        accounts = []

        req_accounts['data'].each do |account|
          attributes = self.symbolize_keys!(account)

          account = BB::Facebook::Account.new(attributes)

          accounts << account
        end

        accounts
      end

      # Find account by id
      # Return account object
      # Return example:
      # <BB::Facebook::Account:0x007f9a3c089cc8
      # @account_status=xxxx,
      # @age=xxxx,
      # @amount_spent="xxxx",
      # @balance="xxxx",
      # @business_city="",
      # @business_country_code="xxxx",
      # @business_name="",
      # @business_street="",
      # @business_street2="",
      # @capabilities=xxx,
      # @created_time="xxxx",
      # @currency="xxxx",
      # @funding_source="xxxx",
      # @funding_source_details={:id=>"xxxx", :display_string=>"Visa *xxxx", :type=>xxxx},
      # @id="act_xxxx",
      # @is_personal=xxxx,
      # @name="xxxx",
      # @offsite_pixels_tos_accepted=true,
      # @spend_cap="xxxx",
      # @tax_id_status=xxxx,
      # @timezone_id=xxxx,
      # @timezone_name="xxxx",
      # @timezone_offset_hours_utc=xxxx,
      # @tos_accepted={:web_custom_audience_tos=>xxxx}>
      def self.find(id)
        request = BB::Facebook::Request.new(graph: BB::Facebook.graph)

        req_account_details = request.get_account_details(id, self.fields)

        unless req_account_details['error'].nil?
          raise BB::Errors::NotFound, "#{req_account_details['error']['message']}"
        end

        attributes = self.symbolize_keys!(req_account_details)

        account = BB::Facebook::Account.new(attributes)
      end

      def campaigns
        BB::Facebook::Account.id = self.id
        BB::Facebook::Campaign.all
      end

      def adsets
        BB::Facebook::Account.id = self.id
        BB::Facebook::Adset.all
      end

      def ads
        BB::Facebook::Account.id = self.id
        BB::Facebook::Ad.all
      end

      def creatives
        BB::Facebook::Account.id = self.id
        BB::Facebook::Creative.all
      end

      def insights(filter = {})
        BB::Facebook::Account.id = self.id
        BB::Facebook::Insight.all(filter)
      end
    end
  end
end