# Get access token example
https://www.facebook.com/dialog/oauth?client_id=1623566494559922&redirect_uri=http://dungvuthe.com/&scope=ads_management,ads_read,read_insights

https://graph.facebook.com/v2.5/oauth/access_token?
client_id=1623566494559922&redirect_uri=http://dungvuthe.com/&
client_secret=cf9243386a5f6b81b7acba4d75b0c748&code=<CODE>

require 'bb'

begin
  auth_code = "CAAXEoAgtbrIBALQ5kQaW6FiELc0rFXzgQTsQZCE6NVFN150MtSXi7fbCuvicZBy4FZCZAguBCvayUi63wYC7gre8u0I703NQGWMv5zfMM8EY4leTM1JloGM6ZCxe5xZAyHuIe8nAlYFcZCX10IbTV4MWLDbdCqsdKOykT9DGwDSmBQJA6hG7S6mSbqerMnspN32eezCcvZBlT0viZBnU5ZAGSm"
  partner   = "facebook"
  end_point = "https://graph.facebook.com"
  version   = 2.5

  # Set up service
  @service = BB::Service.new(auth_code: auth_code, partner: partner, end_point: end_point, version: version)
  BB::Facebook.graph = @service.facebook

  # Get facebook ad account
  # Return: account object
  @account = BB::Facebook::Account.all.first
  # Account object: 
  # <BB::Facebook::Account:0x007f9a3c089cc8
  # @account_id="xxxx",
  # @account_status=xxxx,
  # @age=xxxx,
  # @amount_spent="xxxx",
  # @balance="xxxx",
  # @business_city="",
  # @business_country_code="xxxx",
  # @business_name="",
  # @business_street="",
  # @business_street2="",
  # @capabilities= xxxx,
  # @created_time="xxxx",
  # @currency="xxxx",
  # @funding_source="xxxx",
  # @funding_source_details=xxxx,
  # @id="act_xxxx",
  # @is_personal=xxxx,
  # @name="xxxx",
  # @offsite_pixels_tos_accepted=xxxx,
  # @spend_cap="xxxx",
  # @tax_id_status=xxxx,
  # @timezone_id=xxxx,
  # @timezone_name="xxxx",
  # @timezone_offset_hours_utc=xxxx,
  # @tos_accepted=xxxx>

  # Set account id
  BB::Facebook::Account.id = @account.id

  # List all account's campaigns
  # Return: campaigns array
  campaigns = BB::Facebook::Campaign.all
  # Array: 
  # [#<BB::Facebook::Campaign:0x007f89bc513310
  #  @buying_type="AUCTION",
  #  @can_use_spend_cap=true,
  #  @configured_status="PAUSED",
  #  @created_time="2015-11-07T11:54:53+0700",
  #  @effective_status="PAUSED",
  #  @id="6033074631548",
  #  @name="test ads",
  #  @objective="PAGE_LIKES",
  #  @start_time="2015-11-08T15:14:44+0700",
  #  @updated_time="2015-11-07T11:54:53+0700">,
  # #<BB::Facebook::Campaign:0x007f89bc512578
  #  @buying_type="AUCTION",
  #  @can_use_spend_cap=true,
  #  @configured_status="ACTIVE",
  #  @created_time="2015-10-30T10:29:36+0700",
  #  @effective_status="ACTIVE",
  #  @id="6032548324148",
  #  @name="Bài viết: \"6 màu mới nhất của son hoa siêu lì, chỉ 90k/ hũ...\"",
  #  @objective="POST_ENGAGEMENT",
  #  @start_time="2015-10-30T10:29:36+0700",
  #  @updated_time="2015-11-07T09:50:39+0700">]
  

  # Get a account's campaign
  # Return: campaign object
  campaign = BB::Facebook::Campaign.find(campaigns.first.id)
  # Campaign object:
  # #<BB::Facebook::Campaign:0x007f89be064498
  # @buying_type="AUCTION",
  # @can_use_spend_cap=true,
  # @configured_status="PAUSED",
  # @created_time="2015-11-07T11:54:53+0700",
  # @effective_status="PAUSED",
  # @id="6033074631548",
  # @name="test ads",
  # @objective="PAGE_LIKES",
  # @start_time="2015-11-08T15:14:44+0700",
  # @updated_time="2015-11-07T11:54:53+0700">
 
  # Create campaign
  # Return: campaign object

  campaign_params = {
    name: "Test campaign 1",
    objective: "PAGE_LIKES",
    status: "PAUSED"
  }

  campaign_1 = BB::Facebook::Campaign.new(campaign_params)
  campaign_1.save
  # Campaign object:
  # #<BB::Facebook::Campaign:0x007f8c7b3c7490
  # @buying_type="AUCTION",
  # @can_use_spend_cap=true,
  # @configured_status="PAUSED",
  # @created_time="2015-11-11T14:56:26+0700",
  # @effective_status="PAUSED",
  # @id="6033292921748",
  # @name="Test campaign 1",
  # @objective="PAGE_LIKES",
  # @start_time="1970-01-01T07:59:59+0800",
  # @status="PAUSED",
  # @updated_time="2015-11-11T14:56:26+0700">
  # Or create by create method

  # Return: campaign object
  campaign_2 = BB::Facebook::Campaign.create(campaign_params)
  # Campaign object:
  # #<BB::Facebook::Campaign:0x007f8c7b3c7490
  # @buying_type="AUCTION",
  # @can_use_spend_cap=true,
  # @configured_status="PAUSED",
  # @created_time="2015-11-11T14:56:26+0700",
  # @effective_status="PAUSED",
  # @id="6033292921748",
  # @name="Test campaign 1",
  # @objective="PAGE_LIKES",
  # @start_time="1970-01-01T07:59:59+0800",
  # @status="PAUSED",
  # @updated_time="2015-11-11T14:56:26+0700">
  # Or create by create method

  # Update campaign
  # Return: Boolean
  update_campaign = campaign_1
  update_campaign.update_attributes(name: "Campaign Updated")
  # Updated Campaign:
  # #<BB::Facebook::Campaign:0x007f8c790798f8
  # @buying_type="AUCTION",
  # @can_use_spend_cap=true,
  # @configured_status="PAUSED",
  # @created_time="2015-11-07T11:54:53+0700",
  # @effective_status="PAUSED",
  # @id="6033074631548",
  # @name="Campaign Updated",
  # @objective="PAGE_LIKES",
  # @start_time="2015-11-08T15:14:44+0700",
  # @updated_time="2015-11-11T14:57:22+0700">

  # Destroy campaign
  # Return: Boolean
  puts "Destroyed campaign_1" if campaign_1.destroy
  puts "Destroyed campaign_2" if campaign_2.destroy

rescue Exception => e
  puts e
end
