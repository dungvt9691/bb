# Get access token example
# https://www.facebook.com/dialog/oauth?
# client_id=493410937487049&redirect_uri=http://bigbom.adtopgo.com/&
# scope=ads_management,ads_read,read_insights

# https://graph.facebook.com/v2.5/oauth/access_token?
# client_id=493410937487049&redirect_uri=http://bigbom.adtopgo.com/&
# client_secret=5f9a3562b7da49169668bc765533ab4d&code=<CODE>

require 'bb'

begin
  auth_code = "CAAXEoAgtbrIBAHhB48lZBxBojmdhJr45gZBCCjUAq6cvw5J75uXLXvIMps7rM5RM07ZAcnEOZCUyPuwbt4ff4ZBTwTbGSbeXaZAOQkVzUyYZCEnJGsaQkgESbVMYC3iZBM4T7FNAcDHbRpcvVYY5xmJnZCDEajfpuW9cq60R4QGNVHbFAAlDkvdy6EzboZCzHcsXt7jsbEy7c4KcBbWFVAPJDV2"
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

  # List all account's adsets
  # Return: adsets array
  adsets = BB::Facebook::Adset.all
  # Array: 
  # [#<BB::Facebook::Adset:0x007ff22b4e3160
  #  @account_id="235851576606480",
  #  @bid_amount=30000,
  #  @bid_info={"ACTIONS"=>30000},
  #  @billing_event="PAGE_LIKES",
  #  @budget_remaining="210000",
  #  @campaign_id="6033074631548",
  #  @configured_status="PAUSED",
  #  @created_time="2015-11-08T15:16:04+0700",
  #  @daily_budget="210000",
  #  @effective_status="PAUSED",
  #  @frequency_cap=0,
  #  @frequency_cap_reset_period=0,
  #  @id="6033120919148",
  #  @is_autobid=false,
  #  @lifetime_budget="0",
  #  @lifetime_frequency_cap=0,
  #  @lifetime_imps=0,
  #  @name="Test ads 2",
  #  @optimization_goal="PAGE_LIKES",
  #  @pacing_type=["standard"],
  #  @product_ad_behavior="REQUIRE_LAST_SEEN_PRODUCTS",
  #  @promoted_object={"page_id"=>"1588195768129698"},
  #  @rtb_flag=false,
  #  @start_time="2015-11-08T15:16:04+0700",
  #  @targeting={"age_max"=>65, "age_min"=>18, "geo_locations"=>{"countries"=>["US"], "location_types"=>["home"]}, "page_types"=>["desktopfeed", "mobilefeed"]},
  #  @updated_time="2015-11-08T15:16:04+0700",
  #  @use_new_app_click=false>]

  # Get a account's adset
  # Return: adset object
  adset = BB::Facebook::Adset.find(adsets.first.id)
  # Adset object:
  # #<BB::Facebook::Adset:0x007fa6ec982f48
  # @account_id="235851576606480",
  # @bid_amount=30000,
  # @bid_info={"ACTIONS"=>30000},
  # @billing_event="PAGE_LIKES",
  # @budget_remaining="210000",
  # @campaign_id="6033074631548",
  # @configured_status="PAUSED",
  # @created_time="2015-11-08T15:16:04+0700",
  # @daily_budget="210000",
  # @effective_status="PAUSED",
  # @frequency_cap=0,
  # @frequency_cap_reset_period=0,
  # @id="6033120919148",
  # @is_autobid=false,
  # @lifetime_budget="0",
  # @lifetime_frequency_cap=0,
  # @lifetime_imps=0,
  # @name="Test ads 2",
  # @optimization_goal="PAGE_LIKES",
  # @pacing_type=["standard"],
  # @product_ad_behavior="REQUIRE_LAST_SEEN_PRODUCTS",
  # @promoted_object={"page_id"=>"1588195768129698"},
  # @rtb_flag=false,
  # @start_time="2015-11-08T15:16:04+0700",
  # @targeting={"age_max"=>65, "age_min"=>18, "geo_locations"=>{"countries"=>["US"], "location_types"=>["home"]}, "page_types"=>["desktopfeed", "mobilefeed"]},
  # @updated_time="2015-11-08T15:16:04+0700",
  # @use_new_app_click=false>
 
  # Create adset
  # Return: adset object
  # Create campaign before:
  campaign_params = {
    name: "Test campaign 1",
    objective: "POST_ENGAGEMENT",
    status: "PAUSED"
  }

  campaign = BB::Facebook::Campaign.create(campaign_params)

  adset_params = {
    name: "Test adset 1",
    campaign_id: campaign.id,
    billing_event: "POST_ENGAGEMENT",
    targeting: {"age_max"=>65, "age_min"=>18, "geo_locations"=>{"countries"=>["US"], "location_types"=>["home"]}, "page_types"=>["desktopfeed", "mobilefeed"]},
    daily_budget: 70000,
    bid_amount: 100,
    optimization_goal: "POST_ENGAGEMENT"
  }

  adset_1 = BB::Facebook::Adset.new(adset_params)
  adset_1.save
  # Adset object:
  # #<BB::Facebook::Adset:0x007ff9139dbe80
  # @account_id="235851576606480",
  # @bid_amount=100,
  # @bid_info={"ACTIONS"=>100},
  # @billing_event="POST_ENGAGEMENT",
  # @budget_remaining="21033",
  # @campaign_id="6033297941348",
  # @configured_status="ACTIVE",
  # @created_time="2015-11-11T16:47:19+0700",
  # @daily_budget="70000",
  # @effective_status="CAMPAIGN_PAUSED",
  # @frequency_cap=0,
  # @frequency_cap_reset_period=0,
  # @id="6033297942548",
  # @is_autobid=false,
  # @lifetime_budget="0",
  # @lifetime_frequency_cap=0,
  # @lifetime_imps=0,
  # @name="Test adset 1",
  # @optimization_goal="POST_ENGAGEMENT",
  # @pacing_type=["standard"],
  # @product_ad_behavior="REQUIRE_LAST_SEEN_PRODUCTS",
  # @rtb_flag=false,
  # @start_time="2015-11-11T16:47:19+0700",
  # @targeting={"age_max"=>65, "age_min"=>18, "geo_locations"=>{"countries"=>["US"], "location_types"=>["home"]}, "page_types"=>["desktopfeed", "mobilefeed"]},
  # @updated_time="2015-11-11T16:47:19+0700",
  # @use_new_app_click=false>

  # Or create by create method
  # Return: adset object
  adset_2 = BB::Facebook::Adset.create(adset_params)
  # Adset object:
  # #<BB::Facebook::Adset:0x007ff9139dbe80
  # @account_id="235851576606480",
  # @bid_amount=100,
  # @bid_info={"ACTIONS"=>100},
  # @billing_event="POST_ENGAGEMENT",
  # @budget_remaining="21033",
  # @campaign_id="6033297941348",
  # @configured_status="ACTIVE",
  # @created_time="2015-11-11T16:47:19+0700",
  # @daily_budget="70000",
  # @effective_status="CAMPAIGN_PAUSED",
  # @frequency_cap=0,
  # @frequency_cap_reset_period=0,
  # @id="6033297942548",
  # @is_autobid=false,
  # @lifetime_budget="0",
  # @lifetime_frequency_cap=0,
  # @lifetime_imps=0,
  # @name="Test adset 1",
  # @optimization_goal="POST_ENGAGEMENT",
  # @pacing_type=["standard"],
  # @product_ad_behavior="REQUIRE_LAST_SEEN_PRODUCTS",
  # @rtb_flag=false,
  # @start_time="2015-11-11T16:47:19+0700",
  # @targeting={"age_max"=>65, "age_min"=>18, "geo_locations"=>{"countries"=>["US"], "location_types"=>["home"]}, "page_types"=>["desktopfeed", "mobilefeed"]},
  # @updated_time="2015-11-11T16:47:19+0700",
  # @use_new_app_click=false>

  # Update adset
  # Return: Boolean
  update_adset = adset_1
  updated_params = {
    name: "Adset Updated",
    status: "ACTIVE",
    targeting: {"age_max"=>35, "age_min"=>15, "geo_locations"=>{"countries"=>["VN"], "location_types"=>["home"]}, "page_types"=>["desktopfeed", "mobilefeed"]},
    bid_amount: 150,
    pacing_type: ["day_parting"],
    lifetime_budget: "500000",
    adset_schedule: [{"start_minute" => 720, "end_minute" => 840,"days" => [1,2,3,4,5]}],
    end_time: "2015-11-20T09:03:03+0700"
  }
  update_adset.update_attributes(updated_params)
  # Updated Adset:
  # #<BB::Facebook::Adset:0x007fe833aab4c8
  # @account_id="235851576606480",
  # @bid_amount=100,
  # @bid_info={"ACTIONS"=>100},
  # @billing_event="POST_ENGAGEMENT",
  # @budget_remaining="20752",
  # @campaign_id="6033298123548",
  # @configured_status="ACTIVE",
  # @created_time="2015-11-11T16:53:06+0700",
  # @daily_budget="70000",
  # @effective_status="CAMPAIGN_PAUSED",
  # @frequency_cap=0,
  # @frequency_cap_reset_period=0,
  # @id="6033298124748",
  # @is_autobid=false,
  # @lifetime_budget="0",
  # @lifetime_frequency_cap=0,
  # @lifetime_imps=0,
  # @name="Adset Updated",
  # @optimization_goal="POST_ENGAGEMENT",
  # @pacing_type=["standard"],
  # @product_ad_behavior="REQUIRE_LAST_SEEN_PRODUCTS",
  # @rtb_flag=false,
  # @start_time="2015-11-11T16:53:06+0700",
  # @targeting={"age_max"=>65, "age_min"=>18, "geo_locations"=>{"countries"=>["US"], "location_types"=>["home"]}, "page_types"=>["desktopfeed", "mobilefeed"]},
  # @updated_time="2015-11-11T16:53:10+0700",
  # @use_new_app_click=false>

  # Destroy campaign
  # Return: Boolean
  puts "Destroyed campaign" if campaign.destroy

  # Destroy adset
  # Return: Boolean
  puts "Destroyed adset_1" if adset_1.destroy
  puts "Destroyed adset_2" if adset_2.destroy

rescue Exception => e
  puts e

  # Destroy campaign
  # Return: Boolean
  puts "Destroyed campaign" if campaign.destroy

  # Destroy adset
  # Return: Boolean
  puts "Destroyed adset_1" if adset_1.destroy
  puts "Destroyed adset_2" if adset_2.destroy
end
