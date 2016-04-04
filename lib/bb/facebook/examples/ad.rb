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
  @account = BB::Facebook::Account.find("235851576606480")
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

  # List all account's ads
  # Return: ads array
  ads = BB::Facebook::Ad.all
  # Array: 
  # [#<BB::Facebook::Ad:0x007f8a425810c8
  # @account_id="235851576606480",
  # @adset_id="6032548325348",
  # @bid_amount=179,
  # @bid_info={:ACTIONS=>179},
  # @bid_type="ABSOLUTE_OCPM",
  # @campaign_id="6032548324148",
  # @configured_status="ACTIVE",
  # @conversion_specs=[{:"action.type"=>["post_engagement"], :page=>["1740497286175357"], :post=>["1910961292462288"]}],
  # @created_time="2015-10-30T10:29:36+0700",
  # @creative={:id=>"6032548317148"},
  # @effective_status="ACTIVE",
  # @id="6032548326748",
  # @last_updated_by_app_id="624541620938530",
  # @name="Bài viết: /daudua.tracy/posts/1910961292462288 với đối tượng của quảng cáo của bạn",
  # @updated_time="2015-11-07T11:11:43+0700">]
  

  # Get a account's ad
  # Return: ad object
  ad = BB::Facebook::Ad.find(ads.first.id)
  # <BB::Facebook::Ad:0x007fe37938ed70
  # @account_id="235851576606480",
  # @adset_id="6032548325348",
  # @bid_amount=179,
  # @bid_info={:ACTIONS=>179},
  # @bid_type="ABSOLUTE_OCPM",
  # @campaign_id="6032548324148",
  # @configured_status="ACTIVE",
  # @conversion_specs=[{:"action.type"=>["post_engagement"], :page=>["1740497286175357"], :post=>["1910961292462288"]}],
  # @created_time="2015-10-30T10:29:36+0700",
  # @creative={:id=>"6032548317148"},
  # @effective_status="ACTIVE",
  # @id="6032548326748",
  # @last_updated_by_app_id="624541620938530",
  # @name="Bài viết: /daudua.tracy/posts/1910961292462288 với đối tượng của quảng cáo của bạn",
  # @updated_time="2015-11-07T11:11:43+0700">
 
  # Create post engagement ad
  # Return: ad object
  # Create campaign before:
  campaign_params = {
    name: "Test campaign 1",
    objective: "POST_ENGAGEMENT",
    status: "PAUSED"
  }

  campaign = BB::Facebook::Campaign.create(campaign_params)

  # Create adset then:
  adset_params = {
    name: "Test adset 1",
    campaign_id: campaign.id,
    billing_event: "POST_ENGAGEMENT",
    targeting: {"age_max"=>65, "age_min"=>18, "geo_locations"=>{"countries"=>["US"], "location_types"=>["home"]}, "page_types"=>["desktopfeed", "mobilefeed"]},
    daily_budget: 70000,
    bid_amount: 100,
    optimization_goal: "POST_ENGAGEMENT"
  }

  adset = BB::Facebook::Adset.create(adset_params)

  # Create creative then:
  creative_params = {
    object_story_id: "1740497286175357_1906452529579831",
  }

  creative = BB::Facebook::Creative.create(creative_params)

  ad_params = {
    status: "PAUSED",
    creative_id: creative.id,
    adset_id: adset.id,
    name: "Test ad 1"
  }

  ad = BB::Facebook::Ad.new(ad_params)
  ad.save
  # Ad object:
  # #<BB::Facebook::Ad:0x007fa419be7db8
  # @account_id="235851576606480",
  # @adset_id="6033307914348",
  # @bid_amount=100,
  # @bid_info={"ACTIONS"=>100},
  # @bid_type="CPA",
  # @campaign_id="6033307908548",
  # @configured_status="PAUSED",
  # @conversion_specs=[{"action.type"=>["post_engagement"], "page"=>["1740497286175357"], "post"=>["1906452529579831"]}],
  # @created_time="2015-11-11T20:01:09+0700",
  # @creative={"id"=>"6033281856748"},
  # @effective_status="PENDING_REVIEW",
  # @id="6033307932148",
  # @last_updated_by_app_id="493410937487049",
  # @name="Test ad 1",
  # @status="PAUSED",
  # @updated_time="2015-11-11T20:01:09+0700">

  # Destroy ad
  # Return: Boolean
  puts "Destroyed ad" if ad.destroy
  
  # Destroy adset
  # Return: Boolean
  puts "Destroyed adset" if adset.destroy

  # Destroy campaign
  # Return: Boolean
  puts "Destroyed campaign" if campaign.destroy
  
  # Destroy creative
  # Return: Boolean
  puts "Destroyed creative" if creative.destroy

  # Create page likes ad
  # Return: ad object
  # Create campaign before:
  campaign_params = {
    name: "Test campaign 2",
    objective: "PAGE_LIKES",
    status: "PAUSED"
  }

  campaign = BB::Facebook::Campaign.create(campaign_params)

  # Create adset then:
  adset_params = {
    name: "Test adset 2",
    campaign_id: campaign.id,
    billing_event: "PAGE_LIKES",
    targeting: {
      "age_max"=>65,
      "age_min"=>18,
      "geo_locations"=>{
        "countries"=>["US"],
        "location_types"=>["home"]
      },
      "page_types"=>["desktopfeed", "mobilefeed"],
      "excluded_connections" => [{"id" => "1740497286175357"}]
    },
    daily_budget: 70000,
    bid_amount: 100,
    optimization_goal: "PAGE_LIKES",
    promoted_object: {"page_id" => "1740497286175357"}
  }

  adset = BB::Facebook::Adset.create(adset_params)

  # Create creative then:
  creative_params = {
    object_story_spec: {
      "link_data" => {
        "call_to_action" => {
          "type" => "SIGN_UP",
          "value" => {
            "link" => "http://dungvuthe.com",
            "link_caption" => "Sign up!"
          }
        },
        "caption" => "My caption",
        "link" => "http://dungvuthe.com",
        "message" => "try it out",
        "image_hash" => "12a4601709f145d16b3770132db5e003"
      },
      "page_id" => "1740497286175357"
    }
  }

  creative = BB::Facebook::Creative.create(creative_params)

  ad_params = {
    status: "PAUSED",
    creative_id: creative.id,
    adset_id: adset.id,
    name: "Test ad 2"
  }

  ad = BB::Facebook::Ad.new(ad_params)
  ad.save
  # Ad object:
  # #<BB::Facebook::Ad:0x007fe883e478c0
  # @account_id="235851576606480",
  # @adset_id="6033390373748",
  # @bid_amount=100,
  # @bid_info={"ACTIONS"=>100},
  # @bid_type="CPA",
  # @campaign_id="6033390050148",
  # @configured_status="PAUSED",
  # @conversion_specs=[{"action.type"=>["like"], "page"=>["1740497286175357"]}],
  # @created_time="2015-11-13T00:16:56+0700",
  # @creative_id="6033390397948",
  # @effective_status="PENDING_REVIEW",
  # @id="6033390410548",
  # @last_updated_by_app_id="1623566494559922",
  # @name="Test ad 1",
  # @status="PAUSED",
  # @tracking_specs=[{"action.type"=>["page_engagement"], "page"=>["1740497286175357"]}],
  # @updated_time="2015-11-13T00:16:56+0700">

  # Destroy ad
  # Return: Boolean
  puts "Destroyed ad" if ad.destroy
  
  # Destroy adset
  # Return: Boolean
  puts "Destroyed adset" if adset.destroy

  # Destroy campaign
  # Return: Boolean
  puts "Destroyed campaign" if campaign.destroy
  
  # Destroy creative
  # Return: Boolean
  puts "Destroyed creative" if creative.destroy

  # Create website clicks ad
  # Return: ad object
  # Create campaign before:
  campaign_params = {
    name: "Test campaign 3",
    objective: "LINK_CLICKS",
    status: "PAUSED"
  }

  campaign = BB::Facebook::Campaign.create(campaign_params)

  # Create adset then:
  adset_params = {
    name: "Test adset 3",
    campaign_id: campaign.id,
    billing_event: "LINK_CLICKS",
    targeting: {
      "age_max"=>65,
      "age_min"=>18,
      "geo_locations"=>{
        "countries"=>["US"],
        "location_types"=>["home"]
      },
      "page_types"=>["desktopfeed", "mobilefeed"]
    },
    daily_budget: 70000,
    bid_amount: 100,
    optimization_goal: "LINK_CLICKS",
  }

  adset = BB::Facebook::Adset.create(adset_params)

  # Create creative then:
  creative_params = {
    object_story_spec: {
      "link_data" => {
        "call_to_action" => {
          "type" => "SIGN_UP",
          "value" => {
            "link" => "http://dungvuthe.com",
            "link_caption" => "Sign up!"
          }
        },
        "caption" => "My caption",
        "link" => "http://dungvuthe.com",
        "message" => "try it out"
      },
      "page_id" => "1740497286175357"
    }
  }

  creative = BB::Facebook::Creative.create(creative_params)

  ad_params = {
    status: "PAUSED",
    creative_id: creative.id,
    adset_id: adset.id,
    name: "Test ad 3"
  }

  ad = BB::Facebook::Ad.new(ad_params)
  ad.save
  # Ad object:
  # #<BB::Facebook::Ad:0x007fb47b7d7c88
  # @account_id="235851576606480",
  # @adset_id="6033391498348",
  # @bid_amount=100,
  # @bid_info={"ACTIONS"=>100},
  # @bid_type="CPA",
  # @campaign_id="6033391060748",
  # @configured_status="PAUSED",
  # @conversion_specs=[{"action.type"=>["link_click"], "post"=>["1916241381934279"], "post.wall"=>["1740497286175357"]}],
  # @created_time="2015-11-13T00:40:40+0700",
  # @creative_id="6033391563548",
  # @effective_status="PENDING_REVIEW",
  # @id="6033391567348",
  # @last_updated_by_app_id="1623566494559922",
  # @name="Test ad 3",
  # @status="PAUSED",
  # @tracking_specs=[{"action.type"=>["post_engagement"], "page"=>["1740497286175357"], "post"=>["1916241381934279"]}],
  # @updated_time="2015-11-13T00:40:40+0700">

  # Destroy ad
  # Return: Boolean
  puts "Destroyed ad" if ad.destroy
  
  # Destroy adset
  # Return: Boolean
  puts "Destroyed adset" if adset.destroy

  # Destroy campaign
  # Return: Boolean
  puts "Destroyed campaign" if campaign.destroy
  
  # Destroy creative
  # Return: Boolean
  puts "Destroyed creative" if creative.destroy

  # Create website conversions ad
  # Return: ad object
  # Create campaign before:
  campaign_params = {
    name: "Test campaign 4",
    objective: "CONVERSIONS",
    status: "PAUSED"
  }

  campaign = BB::Facebook::Campaign.create(campaign_params)

  # Create adset then:
  adset_params = {
    name: "Test adset 4",
    campaign_id: campaign.id,
    billing_event: "IMPRESSIONS",
    targeting: {
      "age_max"=>65,
      "age_min"=>18,
      "geo_locations"=>{
        "countries"=>["US"],
        "location_types"=>["home"]
      },
      "page_types"=>["desktopfeed", "mobilefeed"]
    },
    daily_budget: 70000,
    bid_amount: 100,
    optimization_goal: "OFFSITE_CONVERSIONS",
    promoted_object: {
      "pixel_id" => "1705798889653628",
      "custom_event_type" => "COMPLETE_REGISTRATION"
    }
  }

  adset = BB::Facebook::Adset.create(adset_params)

  # Create creative then:
  creative_params = {
    object_story_spec: {
      "link_data" => {
        "call_to_action" => {
          "type" => "SIGN_UP",
          "value" => {
            "link" => "http://dungvuthe.com",
            "link_caption" => "Sign up!"
          }
        },
        "caption" => "My caption",
        "link" => "http://dungvuthe.com",
        "message" => "try it out"
      },
      "page_id" => "1740497286175357"
    }
  }

  creative = BB::Facebook::Creative.create(creative_params)

  ad_params = {
    status: "PAUSED",
    creative_id: creative.id,
    adset_id: adset.id,
    name: "Test ad 4"
  }

  ad = BB::Facebook::Ad.new(ad_params)
  ad.save
  # Ad object:
  # #<BB::Facebook::Ad:0x007f9443cb9718
  # @account_id="235851576606480",
  # @adset_id="6033393854548",
  # @bid_amount=100,
  # @bid_info={"ACTIONS"=>100},
  # @bid_type="ABSOLUTE_OCPM",
  # @campaign_id="6033393301148",
  # @configured_status="PAUSED",
  # @conversion_specs=[{"action.type"=>["offsite_conversion"], "conversion_id"=>["1068034713229775"]}],
  # @created_time="2015-11-13T01:11:59+0700",
  # @creative_id="6033393863148",
  # @effective_status="PENDING_REVIEW",
  # @id="6033393871148",
  # @last_updated_by_app_id="1623566494559922",
  # @name="Test ad 4",
  # @status="PAUSED",
  # @tracking_specs=
  #  [{"action.type"=>["offsite_conversion"], "fb_pixel"=>["1705798889653628"]},
  #   {"action.type"=>["post_engagement"], "page"=>["1740497286175357"], "post"=>["1916248851933532"]}],
  # @updated_time="2015-11-13T01:11:59+0700">

  # Destroy ad
  # Return: Boolean
  puts "Destroyed ad" if ad.destroy
  
  # Destroy adset
  # Return: Boolean
  puts "Destroyed adset" if adset.destroy

  # Destroy campaign
  # Return: Boolean
  puts "Destroyed campaign" if campaign.destroy
  
  # Destroy creative
  # Return: Boolean
  puts "Destroyed creative" if creative.destroy

  # Create mobile app installs ad
  # Return: ad object
  # Create campaign before:
  campaign_params = {
    name: "Test campaign 5",
    objective: "MOBILE_APP_INSTALLS",
    status: "PAUSED"
  }

  campaign = BB::Facebook::Campaign.create(campaign_params)

  # Create adset then:
  adset_params = {
    name: "Test adset 5",
    campaign_id: campaign.id,
    billing_event: "APP_INSTALLS",
    targeting: {
      "age_max"=>65,
      "age_min"=>18,
      "app_install_state"=>"not_installed",
      "geo_locations"=>{
        "countries"=>["VN"],
        "location_types"=>["home", "recent"]
      },
      "page_types"=>["mobileexternal", "mobilefeed"],
      "user_device"=>["Android_Smartphone", "Android_Tablet"],
      "user_os"=>["Android"]
    },
    daily_budget: 70000,
    bid_amount: 100,
    optimization_goal: "APP_INSTALLS",
    promoted_object: {
      "application_id" => "1379676805660881",
      "object_store_url" => "https://play.google.com/store/apps/details?id=org.familug.game.remember"
    }
  }

  adset = BB::Facebook::Adset.create(adset_params)

  # Create creative then:
  creative_params = {
    object_story_spec: {
      "page_id" =>"1588195768129698",
      "link_data" => {
        "link" =>"http://play.google.com/store/apps/details?id=org.familug.game.remember",
        "call_to_action" => {
          "type" =>"INSTALL_MOBILE_APP",
          "value" => {
            "application" =>"1379676805660881",
            "link" => "http://play.google.com/store/apps/details?id=org.familug.game.remember",
            "link_title" => "Remember - IQ Test"
          }
        },
      "child_attachments" => [{
        "link" => "http://play.google.com/store/apps/details?id=org.familug.game.remember",
        "name" => "Remember - IQ Test",
        "call_to_action" => {
          "type"=>"INSTALL_MOBILE_APP",
          "value" => {
            "application" => "1379676805660881",
            "link" => "http://play.google.com/store/apps/details?id=org.familug.game.remember",
            "link_title" => "Remember - IQ Test"
          }
        }
      },
      {
        "link" => "http://play.google.com/store/apps/details?id=org.familug.game.remember",
        "call_to_action" => {
          "type" => "INSTALL_MOBILE_APP",
          "value" => {
            "application" => "1379676805660881",
            "link" => "http://play.google.com/store/apps/details?id=org.familug.game.remember"
          }
        }
      },
      {
        "link" => "http://play.google.com/store/apps/details?id=org.familug.game.remember",
        "call_to_action" => {
          "type" => "INSTALL_MOBILE_APP",
          "value"=> {
            "application"=>"1379676805660881",
            "link"=>"http://play.google.com/store/apps/details?id=org.familug.game.remember"
          }
        }
      }],
      "multi_share_end_card"=>true,
      "multi_share_optimized"=>true}
    }
  }

  creative = BB::Facebook::Creative.create(creative_params)

  ad_params = {
    status: "PAUSED",
    creative_id: creative.id,
    adset_id: adset.id,
    name: "Test ad 5"
  }

  ad = BB::Facebook::Ad.new(ad_params)
  ad.save
  # Ad object:
  # NOTE: Invalid parameter: Your account does not have enough install history to start using billing event for mobile app install ads.
  # Please visit https://developers.facebook.com/docs/reference/ads-api/cost-per-action-ads/ to learn more.

  # Destroy ad
  # Return: Boolean
  puts "Destroyed ad" if ad.destroy
  
  # Destroy adset
  # Return: Boolean
  puts "Destroyed adset" if adset.destroy

  # Destroy campaign
  # Return: Boolean
  puts "Destroyed campaign" if campaign.destroy
  
  # Destroy creative
  # Return: Boolean
  puts "Destroyed creative" if creative.destroy

  # Create mobile app engagement ad
  # Return: ad object
  # Create campaign before:
  campaign_params = {
    name: "Test campaign 6",
    objective: "MOBILE_APP_ENGAGEMENT",
    status: "PAUSED"
  }

  campaign = BB::Facebook::Campaign.create(campaign_params)

  # Create adset then:
  adset_params = {
    name: "Test adset 6",
    campaign_id: campaign.id,
    billing_event: "LINK_CLICKS",
    targeting: {
      "age_max"=>65,
      "age_min"=>18,
      "geo_locations"=>{
        "countries"=>["VN"],
        "location_types"=>["home", "recent"]
      },
      "page_types"=>["mobileexternal", "mobilefeed"],
      "user_device"=>["Android_Smartphone", "Android_Tablet"],
      "user_os"=>["Android"]
    },
    daily_budget: 70000,
    bid_amount: 100,
    optimization_goal: "LINK_CLICKS",
    promoted_object: {
      "application_id" => "1379676805660881",
      "object_store_url" => "https://play.google.com/store/apps/details?id=org.familug.game.remember"
    }
  }

  adset = BB::Facebook::Adset.create(adset_params)

  # Create creative then:
  creative_params = {
    object_story_spec: {
      "page_id" =>"1588195768129698",
      "link_data" => {
        "link" =>"http://play.google.com/store/apps/details?id=org.familug.game.remember",
        "call_to_action" => {
          "type" => "USE_MOBILE_APP",
          "value" => {
            "application" => "1379676805660881",
            "link" => "http://play.google.com/store/apps/details?id=org.familug.game.remember",
            "link_title" => "Remember - IQ Test"
          }
        },
      "picture"=>"shutterstock://182480630",
      "multi_share_end_card"=>true,
      "multi_share_optimized"=>true}
    }
  }

  creative = BB::Facebook::Creative.create(creative_params)

  ad_params = {
    status: "PAUSED",
    creative_id: creative.id,
    adset_id: adset.id,
    name: "Test ad 6"
  }

  ad = BB::Facebook::Ad.new(ad_params)
  ad.save
  # Ad object:
  # #<BB::Facebook::Ad:0x007f9ed26cc640
  # @account_id="235851576606480",
  # @adset_id="6033412595948",
  # @bid_amount=100,
  # @bid_info={"ACTIONS"=>100},
  # @bid_type="CPA",
  # @campaign_id="6033412588748",
  # @configured_status="PAUSED",
  # @conversion_specs=[{"action.type"=>["link_click"], "post"=>["1666127147003226"], "post.wall"=>["1588195768129698"]}],
  # @created_time="2015-11-13T09:32:01+0700",
  # @creative_id="6033412627748",
  # @effective_status="PENDING_REVIEW",
  # @id="6033412632148",
  # @last_updated_by_app_id="1623566494559922",
  # @name="Test ad 6",
  # @status="PAUSED",
  # @tracking_specs=
  #  [{"action.type"=>["mobile_app_install"], "application"=>["1379676805660881"]},
  #   {"action.type"=>["app_custom_event"], "application"=>["1379676805660881"]},
  #   {"action.type"=>["post_engagement"], "page"=>["1588195768129698"], "post"=>["1666127147003226"]}],
  # @updated_time="2015-11-13T09:32:02+0700">

  # Destroy ad
  # Return: Boolean
  puts "Destroyed ad" if ad.destroy
  
  # Destroy adset
  # Return: Boolean
  puts "Destroyed adset" if adset.destroy

  # Destroy campaign
  # Return: Boolean
  puts "Destroyed campaign" if campaign.destroy
  
  # Destroy creative
  # Return: Boolean
  puts "Destroyed creative" if creative.destroy

  # Create local awareness ad
  # Return: ad object
  # Create campaign before:
  campaign_params = {
    name: "Test campaign 7",
    objective: "LOCAL_AWARENESS",
    status: "PAUSED"
  }

  campaign = BB::Facebook::Campaign.create(campaign_params)

  # Create adset then:
  adset_params = {
    name: "Test adset 7",
    campaign_id: campaign.id,
    billing_event: "IMPRESSIONS",
    targeting: {
      "age_max"=>65,
      "age_min"=>18,
      "geo_locations" => {
        "custom_locations" => [{
          "name" => "Nguyen Huy Tuong, Thanh Xuan, Ha Noi",
          "address_string"=>"Nguyen Huy Tuong, Thanh Xuan, Ha Noi",
          "distance_unit"=>"kilometer",
          "latitude"=>20.9974804,
          "longitude"=>105.8042831,
          "radius"=>1,
          "primary_city_id"=>2590028,
          "region_id"=>3983,
          "country"=>"VN"
        }],
      "location_types" => ["home", "recent"]},
      "page_types" => ["desktopfeed", "mobilefeed"],
    },
    daily_budget: 70000,
    bid_amount: 1000,
    optimization_goal: "REACH",
    promoted_object: {
      "page_id" => "1588195768129698"
    }
  }

  adset = BB::Facebook::Adset.create(adset_params)

  # Create creative then:
  creative_params = {
    object_story_spec: {
      "page_id"=>"1588195768129698",
      "link_data"=>{
        "link"=>"https://www.facebook.com/pages/H%C6%B0C%E1%BA%A5utv/1588195768129698",
        "message"=>"Test",
        "name"=>"HuCau.tv",
        "description"=>" ",
        "image_hash"=>"12a4601709f145d16b3770132db5e003",
        "multi_share_end_card"=>true,
        "multi_share_optimized"=>true
      }
    }
  }

  creative = BB::Facebook::Creative.create(creative_params)

  ad_params = {
    status: "PAUSED",
    creative_id: creative.id,
    adset_id: adset.id,
    name: "Test ad 7"
  }

  ad = BB::Facebook::Ad.new(ad_params)
  ad.save
  # Ad object:
  # #<BB::Facebook::Ad:0x007fef89c952b8
  # @account_id="235851576606480",
  # @adset_id="6033413432948",
  # @bid_amount=1000,
  # @bid_info={"REACH"=>1000},
  # @bid_type="ABSOLUTE_OCPM",
  # @campaign_id="6033413167348",
  # @configured_status="PAUSED",
  # @created_time="2015-11-13T09:57:41+0700",
  # @creative_id="6033413409148",
  # @effective_status="PENDING_REVIEW",
  # @id="6033413439548",
  # @last_updated_by_app_id="1623566494559922",
  # @name="Test ad 7",
  # @status="PAUSED",
  # @tracking_specs=[{"action.type"=>["page_engagement"], "page"=>["1588195768129698"]}],
  # @updated_time="2015-11-13T09:57:41+0700">

  # Destroy ad
  # Return: Boolean
  puts "Destroyed ad" if ad.destroy
  
  # Destroy adset
  # Return: Boolean
  puts "Destroyed adset" if adset.destroy

  # Destroy campaign
  # Return: Boolean
  puts "Destroyed campaign" if campaign.destroy
  
  # Destroy creative
  # Return: Boolean
  puts "Destroyed creative" if creative.destroy

  # Create event responses ad
  # Return: ad object
  # Create campaign before:
  campaign_params = {
    name: "Test campaign 8",
    objective: "EVENT_RESPONSES",
    status: "PAUSED"
  }

  campaign = BB::Facebook::Campaign.create(campaign_params)

  # Create adset then:
  adset_params = {
    name: "Test adset 8",
    campaign_id: campaign.id,
    billing_event: "IMPRESSIONS",
    targeting: {
      "age_max"=>65,
      "age_min"=>18,
      "geo_locations"=>{
        "cities"=>[{
          "country"=>"VN",
          "distance_unit"=>"mile",
          "key"=>"2590028",
          "name"=>"Hanoi",
          "radius"=>50,
          "region"=>"Ha Noi",
          "region_id"=>"3983"
        }],
        "location_types" => ["home", "recent"]
      },
      "excluded_connections"=>[{
        "id"=>"475863359282243",
        "name"=>"Sale 20% all items"
      }],
      "page_types"=>["rightcolumn", "desktopfeed", "mobilefeed", "mobileexternal"]
    },
    daily_budget: 70000,
    bid_amount: 1000,
    optimization_goal: "EVENT_RESPONSES",
  }

  adset = BB::Facebook::Adset.create(adset_params)

  # Create creative then:
  creative_params = {
    object_story_spec: {
      "page_id"=>"1740497286175357",
      "link_data"=>{
        "link"=>"https://www.facebook.com/events/475863359282243/",
        "message"=>"Sale 20% all items from 15/11/2015 to 17/11/2015",
        "image_hash"=>"7b04b0f62ad2cf4cf2c42725673e5522",
        "multi_share_end_card"=>true,
        "multi_share_optimized"=>true
      }
    }
  }

  creative = BB::Facebook::Creative.create(creative_params)

  ad_params = {
    status: "PAUSED",
    creative_id: creative.id,
    adset_id: adset.id,
    name: "Test ad 8"
  }

  ad = BB::Facebook::Ad.new(ad_params)
  ad.save
  # Ad object:
  # #<BB::Facebook::Ad:0x007fee3b86ed50
  # @account_id="235851576606480",
  # @adset_id="6033414759948",
  # @bid_amount=1000,
  # @bid_info={"ACTIONS"=>1000},
  # @bid_type="ABSOLUTE_OCPM",
  # @campaign_id="6033414747548",
  # @configured_status="PAUSED",
  # @conversion_specs=[{"action.type"=>["rsvp"], "event"=>["475863359282243"]}],
  # @created_time="2015-11-13T10:48:06+0700",
  # @creative_id="6033414760148",
  # @effective_status="PENDING_REVIEW",
  # @id="6033414763748",
  # @last_updated_by_app_id="1623566494559922",
  # @name="Test ad 8",
  # @status="PAUSED",
  # @tracking_specs=[{"action.type"=>["post_engagement"], "page"=>["1740497286175357"], "post"=>["1916386715253079"]}],
  # @updated_time="2015-11-13T10:48:07+0700">

  # Destroy ad
  # Return: Boolean
  puts "Destroyed ad" if ad.destroy
  
  # Destroy adset
  # Return: Boolean
  puts "Destroyed adset" if adset.destroy

  # Destroy campaign
  # Return: Boolean
  puts "Destroyed campaign" if campaign.destroy
  
  # Destroy creative
  # Return: Boolean
  puts "Destroyed creative" if creative.destroy

  # Create offer claims ad
  # Return: ad object
  # Create campaign before:
  campaign_params = {
    name: "Test campaign 9",
    objective: "OFFER_CLAIMS",
    status: "PAUSED"
  }

  campaign = BB::Facebook::Campaign.create(campaign_params)

  # Create adset then:
  adset_params = {
    name: "Test adset 9",
    campaign_id: campaign.id,
    billing_event: "IMPRESSIONS",
    targeting:  {
      "age_max"=>65,
      "age_min"=>18,
      "geo_locations"=>{
        "cities"=>[{
          "country"=>"VN",
          "distance_unit"=>"mile",
          "key"=>"2590028",
          "name"=>"Hanoi",
          "radius"=>50,
          "region"=>"Ha Noi",
          "region_id"=>"3983"
        }],
        "location_types"=>["home", "recent"]
      },
      "page_types"=>["rightcolumn", "desktopfeed", "mobilefeed", "mobileexternal"]
    },
    daily_budget: 70000,
    bid_amount: 1000,
    optimization_goal: "OFFER_CLAIMS",
    promoted_object: {"page_id"=>"1740497286175357"}
  }

  adset = BB::Facebook::Adset.create(adset_params)

  # Create creative then:
  creative_params = {
    object_story_id: "1740497286175357_1916387595252991",
    object_type: "OFFER"
  }

  creative = BB::Facebook::Creative.create(creative_params)

  ad_params = {
    status: "PAUSED",
    creative_id: creative.id,
    adset_id: adset.id,
    name: "Test ad 9"
  }

  ad = BB::Facebook::Ad.new(ad_params)
  ad.save
  # Ad object:
  # #<BB::Facebook::Ad:0x007fee3bed0630
  # @account_id="235851576606480",
  # @adset_id="6033414916548",
  # @bid_amount=1000,
  # @bid_info={"ACTIONS"=>1000},
  # @bid_type="ABSOLUTE_OCPM",
  # @campaign_id="6033414913748",
  # @configured_status="PAUSED",
  # @conversion_specs=[{"action.type"=>["receive_offer"], "offer"=>["1916387595252991"], "offer.creator"=>["1740497286175357"]}],
  # @created_time="2015-11-13T10:58:47+0700",
  # @creative_id="6033414818548",
  # @effective_status="PENDING_REVIEW",
  # @id="6033414921348",
  # @last_updated_by_app_id="1623566494559922",
  # @name="Test ad 9",
  # @status="PAUSED",
  # @tracking_specs=[{"action.type"=>["post_engagement"], "page"=>["1740497286175357"], "post"=>["1916387595252991"]}],
  # @updated_time="2015-11-13T10:58:47+0700">

  # Destroy ad
  # Return: Boolean
  puts "Destroyed ad" if ad.destroy
  
  # Destroy adset
  # Return: Boolean
  puts "Destroyed adset" if adset.destroy

  # Destroy campaign
  # Return: Boolean
  puts "Destroyed campaign" if campaign.destroy
  
  # Destroy creative
  # Return: Boolean
  puts "Destroyed creative" if creative.destroy

  # Create video views ad
  # Return: ad object
  # Create campaign before:
  campaign_params = {
    name: "Test campaign 10",
    objective: "VIDEO_VIEWS",
    status: "PAUSED"
  }

  campaign = BB::Facebook::Campaign.create(campaign_params)

  # Create adset then:
  adset_params = {
    name: "Test adset 10",
    campaign_id: campaign.id,
    billing_event: "IMPRESSIONS",
    targeting:  {
      "age_max"=>65,
      "age_min"=>18,
      "geo_locations"=>{
        "countries"=>["VN"],
        "location_types"=>["home", "recent"]
      },
      "page_types"=>["rightcolumn", "desktopfeed", "mobilefeed", "mobileexternal"]
    },
    daily_budget: 70000,
    bid_amount: 1000,
    optimization_goal: "VIDEO_VIEWS",
  }

  adset = BB::Facebook::Adset.create(adset_params)

  # Create creative then:
  creative_params = {
    object_story_spec: {
      "page_id"=>"1588195768129698",
      "video_data"=>{
        "video_id"=>"1652670335015574",
        "description"=>"Video hot in youtube",
        "call_to_action"=>{
          "type"=>"WATCH_MORE",
          "value"=>{
            "link_caption"=>"http://hucau.tv",
            "link"=>"http://hucau.tv/"
          }
        },
        "image_url"=>
        "https://fbcdn-vthumb-a.akamaihd.net/hvthumb-ak-xpf1/v/t15.0-10/11863962158986052277309583862_n.jpg?oh=9e15ac72865bd63db30ec6da61112427&oe=56EEAD18&__gda__=1454860504_d3e7d1fc3c59c65405254d1250bdb5c0"
      }
    },
    object_type: "VIDEO"
  }

  creative = BB::Facebook::Creative.create(creative_params)

  ad_params = {
    status: "PAUSED",
    creative_id: creative.id,
    adset_id: adset.id,
    name: "Test ad 10"
  }

  ad = BB::Facebook::Ad.new(ad_params)
  ad.save
  # Ad object:
  # #<BB::Facebook::Ad:0x007feeeba140a0
  # @account_id="235851576606480",
  # @adset_id="6033415171548",
  # @bid_amount=1000,
  # @bid_info={"ACTIONS"=>1000},
  # @bid_type="ABSOLUTE_OCPM",
  # @campaign_id="6033415168148",
  # @configured_status="PAUSED",
  # @conversion_specs=[{"action.type"=>["video_view"], "post"=>["1666143563668251"], "post.wall"=>["1588195768129698"]}],
  # @created_time="2015-11-13T11:09:10+0700",
  # @creative_id="6033415175948",
  # @effective_status="PENDING_REVIEW",
  # @id="6033415180748",
  # @last_updated_by_app_id="1623566494559922",
  # @name="Test ad 10",
  # @status="PAUSED",
  # @tracking_specs=[{"action.type"=>["post_engagement"], "page"=>["1588195768129698"], "post"=>["1666143563668251"]}],
  # @updated_time="2015-11-13T11:09:10+0700">

  # Update ad
  # Return: Boolean
  update_ad = ad
  update_ad.update_attributes(name: "Ad Updated")
  # Updated Ad:
  # #<BB::Facebook::Ad:0x007ff194260498
  # @account_id="235851576606480",
  # @adset_id="6033314251548",
  # @bid_amount=100,
  # @bid_info={"ACTIONS"=>100},
  # @bid_type="CPA",
  # @campaign_id="6033314248148",
  # @configured_status="PAUSED",
  # @conversion_specs=[{"action.type"=>["post_engagement"], "page"=>["1740497286175357"], "post"=>["1906452529579831"]}],
  # @created_time="2015-11-11T22:10:19+0700",
  # @creative={"id"=>"6033281856748"},
  # @effective_status="PENDING_REVIEW",
  # @id="6033314255148",
  # @last_updated_by_app_id="493410937487049",
  # @name="Ad Updated",
  # @status="PAUSED",
  # @updated_time="2015-11-11T22:10:26+0700">

  # Destroy ad
  # Return: Boolean
  puts "Destroyed ad" if ad.destroy
  
  # Destroy adset
  # Return: Boolean
  puts "Destroyed adset" if adset.destroy

  # Destroy campaign
  # Return: Boolean
  puts "Destroyed campaign" if campaign.destroy
  
  # Destroy creative
  # Return: Boolean
  puts "Destroyed creative" if creative.destroy
rescue Exception => e
  puts e
  
  # Destroy ad
  # Return: Boolean
  puts "Destroyed ad" if ad.destroy
  
  # Destroy adset
  # Return: Boolean
  puts "Destroyed adset" if adset.destroy

  # Destroy campaign
  # Return: Boolean
  puts "Destroyed campaign" if campaign.destroy
  
  # Destroy creative
  # Return: Boolean
  puts "Destroyed creative" if creative.destroy
end
