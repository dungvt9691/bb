# Get access token example
# https://www.facebook.com/dialog/oauth?
# client_id=493410937487049&redirect_uri=http://bigbom.adtopgo.com/&
# scope=ads_management,ads_read,read_insights

# https://graph.facebook.com/v2.5/oauth/access_token?
# client_id=493410937487049&redirect_uri=http://bigbom.adtopgo.com/&
# client_secret=5f9a3562b7da49169668bc765533ab4d&code=<CODE>

require 'bb'
begin
  auth_code = "CAAXEoAgtbrIBAFZALmaH57z4KqUywCPl572MUQ1qnKovJ6SOaLXZANVhlgPWvo0bXSKhM6OZCR6XZBHjKXWObL7i15aNIztN1jtq7s0ArQZCd4FZAviEAKZAPRlOn9fTksTlX0nlRzL7t3GRHk2AfODkTUMNzuRHkDttUqcdCMoK7r19m1a4I1gLNc28pPUnVpESMtPFjdfVhuwSoxC8eOn"
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
  # @capabilities=
  #  ["PREMIUM",
  #   "PRORATED_BUDGET",
  #   "OFFSITE_CONVERSION_HIGH_BID",
  #   "HAS_AVAILABLE_PAYMENT_METHODS",
  #   "CAN_USE_MOBILE_EXTERNAL_PAGE_TYPE",
  #   "CAN_USE_MOBILE_EXTERNAL_PAGE_TYPE_FOR_LPP",
  #   "CAN_USE_OLD_AD_TYPES",
  #   "CAN_USE_VIDEO_METRICS_BREAKDOWN",
  #   "CAN_USE_FLEXIBLE_START_END_TIME",
  #   "CAN_USE_CUSTOM_CONVERSION_EVENT",
  #   "ADS_PE_VIDEO_CAROUSEL_WEBSITE_CREATION",
  #   "CONNECTIONS_UI_V2",
  #   "FLEXIBLE_TARGETING_NEW_UI_ACCOUNTS",
  #   "LEAD_GEN_CUSTOMIZED_TCPA",
  #   "LEAD_GEN_OPT_IN_ORGANIC"],
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

  # Set source_id to get insights
  # source_id is campaign_id, account_id, ad_id or adset_id
  # Test with source_id is account_id
  BB::Facebook::Insight.source_id = @account.id

  # Get all account's insights
  # Return: insights array
  insights = BB::Facebook::Insight.all
  # Array:
  # [#<BB::Facebook::Insight:0x007ff35bb5dd20
  # @account_id="235851576606480",
  # @actions=
  #  [{"action_type"=>"comment", "value"=>800},
  #   {"action_type"=>"like", "value"=>5878},
  #   {"action_type"=>"link_click", "value"=>645},
  #   {"action_type"=>"photo_view", "value"=>18194},
  #   {"action_type"=>"post", "value"=>33},
  #   {"action_type"=>"post_like", "value"=>6297},
  #   {"action_type"=>"unlike", "value"=>39},
  #   {"action_type"=>"video_play", "value"=>1611},
  #   {"action_type"=>"video_view", "value"=>2020},
  #   {"action_type"=>"page_engagement", "value"=>33867},
  #   {"action_type"=>"post_engagement", "value"=>27989}],
  # @app_store_clicks=0,
  # @call_to_action_clicks=0,
  # @card_views="0",
  # @cost_per_10_sec_video_view=
  #  [{"action_type"=>"video_view", "value"=>1559.1517323775},
  #   {"action_type"=>"page_engagement", "value"=>1559.1517323775},
  #   {"action_type"=>"post_engagement", "value"=>1559.1517323775}],
  # @cost_per_action_type=
  #  [{"action_type"=>"comment", "value"=>3262.525},
  #   {"action_type"=>"like", "value"=>444.03198366791},
  #   {"action_type"=>"link_click", "value"=>4046.5426356589},
  #   {"action_type"=>"photo_view", "value"=>143.45498515994},
  #   {"action_type"=>"post", "value"=>79091.515151515},
  #   {"action_type"=>"post_like", "value"=>414.48626329998},
  #   {"action_type"=>"unlike", "value"=>66923.58974359},
  #   {"action_type"=>"video_play", "value"=>1620.1241464929},
  #   {"action_type"=>"video_view", "value"=>1292.0891089109},
  #   {"action_type"=>"page_engagement", "value"=>77.066761153926},
  #   {"action_type"=>"post_engagement", "value"=>93.251634570724}],
  # @cost_per_inline_link_click=4046.5426356589,
  # @cost_per_inline_post_engagement=93.251634570724,
  # @cost_per_total_action=76.978115967675,
  # @cost_per_unique_action_type=
  #  [{"action_type"=>"comment", "value"=>9422.4548736462},
  #   {"action_type"=>"like", "value"=>444.56140350877},
  #   {"action_type"=>"link_click", "value"=>6832.5130890052},
  #   {"action_type"=>"photo_view", "value"=>396.78017634539},
  #   {"action_type"=>"post", "value"=>79091.515151515},
  #   {"action_type"=>"post_like", "value"=>477.5009147457},
  #   {"action_type"=>"unlike", "value"=>68684.736842105},
  #   {"action_type"=>"video_play", "value"=>1730.7824933687},
  #   {"action_type"=>"video_view", "value"=>1463.8362310712},
  #   {"action_type"=>"page_engagement", "value"=>128.00490436488},
  #   {"action_type"=>"post_engagement", "value"=>179.76582409257}],
  # @cost_per_unique_click=163.13644602788,
  # @cpm=11046.628264762,
  # @cpp=18319.400868937,
  # @ctr=10.975439428119,
  # @date_start="2014-03-18",
  # @date_stop="2015-11-12",
  # @deeplink_clicks=0,
  # @estimated_ad_recall_rate=0,
  # @estimated_ad_recall_rate_lower_bound=0,
  # @estimated_ad_recall_rate_upper_bound=0,
  # @frequency=1.6583703578924,
  # @impressions="236273",
  # @inline_link_clicks=645,
  # @inline_post_engagement=27989,
  # @reach=142473,
  # @social_clicks=5424,
  # @social_impressions=58593,
  # @social_reach=35106,
  # @spend=2610020,
  # @total_action_value=0,
  # @total_actions=33906,
  # @total_unique_actions=20428,
  # @unique_actions=
  #  [{"action_type"=>"comment", "value"=>277},
  #   {"action_type"=>"like", "value"=>5871},
  #   {"action_type"=>"link_click", "value"=>382},
  #   {"action_type"=>"photo_view", "value"=>6578},
  #   {"action_type"=>"post", "value"=>33},
  #   {"action_type"=>"post_like", "value"=>5466},
  #   {"action_type"=>"unlike", "value"=>38},
  #   {"action_type"=>"video_play", "value"=>1508},
  #   {"action_type"=>"video_view", "value"=>1783},
  #   {"action_type"=>"page_engagement", "value"=>20390},
  #   {"action_type"=>"post_engagement", "value"=>14519}],
  # @unique_clicks=15999,
  # @unique_ctr=11.229496115053,
  # @unique_impressions=142473,
  # @unique_link_clicks_ctr=0.26812097730798,
  # @unique_social_clicks=3303,
  # @unique_social_impressions=35106,
  # @video_10_sec_watched_actions=
  #  [{"action_type"=>"video_view", "value"=>1674}, {"action_type"=>"page_engagement", "value"=>1674}, {"action_type"=>"post_engagement", "value"=>1674}],
  # @video_15_sec_watched_actions=
  #  [{"action_type"=>"video_view", "value"=>1646}, {"action_type"=>"page_engagement", "value"=>1646}, {"action_type"=>"post_engagement", "value"=>1646}],
  # @video_30_sec_watched_actions=
  #  [{"action_type"=>"video_view", "value"=>1570}, {"action_type"=>"page_engagement", "value"=>1570}, {"action_type"=>"post_engagement", "value"=>1570}],
  # @video_avg_pct_watched_actions=
  #  [{"action_type"=>"video_view", "value"=>100}, {"action_type"=>"page_engagement", "value"=>6.06}, {"action_type"=>"post_engagement", "value"=>7.33}],
  # @video_avg_sec_watched_actions=
  #  [{"action_type"=>"video_view", "value"=>16}, {"action_type"=>"page_engagement", "value"=>0}, {"action_type"=>"post_engagement", "value"=>1}],
  # @video_complete_watched_actions=
  #  [{"action_type"=>"video_view", "value"=>1570}, {"action_type"=>"page_engagement", "value"=>1570}, {"action_type"=>"post_engagement", "value"=>1570}],
  # @video_p100_watched_actions=
  #  [{"action_type"=>"video_view", "value"=>1497}, {"action_type"=>"page_engagement", "value"=>1497}, {"action_type"=>"post_engagement", "value"=>1497}],
  # @video_p25_watched_actions=
  #  [{"action_type"=>"video_view", "value"=>1927}, {"action_type"=>"page_engagement", "value"=>1927}, {"action_type"=>"post_engagement", "value"=>1927}],
  # @video_p50_watched_actions=
  #  [{"action_type"=>"video_view", "value"=>1795}, {"action_type"=>"page_engagement", "value"=>1795}, {"action_type"=>"post_engagement", "value"=>1795}],
  # @video_p75_watched_actions=
  #  [{"action_type"=>"video_view", "value"=>1670}, {"action_type"=>"page_engagement", "value"=>1670}, {"action_type"=>"post_engagement", "value"=>1670}],
  # @video_p95_watched_actions=
  #  [{"action_type"=>"video_view", "value"=>1520}, {"action_type"=>"page_engagement", "value"=>1520}, {"action_type"=>"post_engagement", "value"=>1520}],
  # @website_clicks=31102,
  # @website_ctr=[{"action_type"=>"link_click", "value"=>0.27298929628015}]>]

  # Get account's insight with filter params
  # Return: filtered insights array
  insights = BB::Facebook::Insight.all(date_preset: "last_7_days", time_increment: 1)
  # Array:
  # [#<BB::Facebook::Insight:0x007ff35bb5dd20
  # @account_id="235851576606480",
  # @actions=
  #  [{"action_type"=>"comment", "value"=>800},
  #   {"action_type"=>"like", "value"=>5878},
  #   {"action_type"=>"link_click", "value"=>645},
  #   {"action_type"=>"photo_view", "value"=>18194},
  #   {"action_type"=>"post", "value"=>33},
  #   {"action_type"=>"post_like", "value"=>6297},
  #   {"action_type"=>"unlike", "value"=>39},
  #   {"action_type"=>"video_play", "value"=>1611},
  #   {"action_type"=>"video_view", "value"=>2020},
  #   {"action_type"=>"page_engagement", "value"=>33867},
  #   {"action_type"=>"post_engagement", "value"=>27989}],
  # @app_store_clicks=0,
  # @call_to_action_clicks=0,
  # @card_views="0",
  # @cost_per_10_sec_video_view=
  #  [{"action_type"=>"video_view", "value"=>1559.1517323775},
  #   {"action_type"=>"page_engagement", "value"=>1559.1517323775},
  #   {"action_type"=>"post_engagement", "value"=>1559.1517323775}],
  # @cost_per_action_type=
  #  [{"action_type"=>"comment", "value"=>3262.525},
  #   {"action_type"=>"like", "value"=>444.03198366791},
  #   {"action_type"=>"link_click", "value"=>4046.5426356589},
  #   {"action_type"=>"photo_view", "value"=>143.45498515994},
  #   {"action_type"=>"post", "value"=>79091.515151515},
  #   {"action_type"=>"post_like", "value"=>414.48626329998},
  #   {"action_type"=>"unlike", "value"=>66923.58974359},
  #   {"action_type"=>"video_play", "value"=>1620.1241464929},
  #   {"action_type"=>"video_view", "value"=>1292.0891089109},
  #   {"action_type"=>"page_engagement", "value"=>77.066761153926},
  #   {"action_type"=>"post_engagement", "value"=>93.251634570724}],
  # @cost_per_inline_link_click=4046.5426356589,
  # @cost_per_inline_post_engagement=93.251634570724,
  # @cost_per_total_action=76.978115967675,
  # @cost_per_unique_action_type=
  #  [{"action_type"=>"comment", "value"=>9422.4548736462},
  #   {"action_type"=>"like", "value"=>444.56140350877},
  #   {"action_type"=>"link_click", "value"=>6832.5130890052},
  #   {"action_type"=>"photo_view", "value"=>396.78017634539},
  #   {"action_type"=>"post", "value"=>79091.515151515},
  #   {"action_type"=>"post_like", "value"=>477.5009147457},
  #   {"action_type"=>"unlike", "value"=>68684.736842105},
  #   {"action_type"=>"video_play", "value"=>1730.7824933687},
  #   {"action_type"=>"video_view", "value"=>1463.8362310712},
  #   {"action_type"=>"page_engagement", "value"=>128.00490436488},
  #   {"action_type"=>"post_engagement", "value"=>179.76582409257}],
  # @cost_per_unique_click=163.13644602788,
  # @cpm=11046.628264762,
  # @cpp=18319.400868937,
  # @ctr=10.975439428119,
  # @date_start="2014-03-18",
  # @date_stop="2015-11-12",
  # @deeplink_clicks=0,
  # @estimated_ad_recall_rate=0,
  # @estimated_ad_recall_rate_lower_bound=0,
  # @estimated_ad_recall_rate_upper_bound=0,
  # @frequency=1.6583703578924,
  # @impressions="236273",
  # @inline_link_clicks=645,
  # @inline_post_engagement=27989,
  # @reach=142473,
  # @social_clicks=5424,
  # @social_impressions=58593,
  # @social_reach=35106,
  # @spend=2610020,
  # @total_action_value=0,
  # @total_actions=33906,
  # @total_unique_actions=20428,
  # @unique_actions=
  #  [{"action_type"=>"comment", "value"=>277},
  #   {"action_type"=>"like", "value"=>5871},
  #   {"action_type"=>"link_click", "value"=>382},
  #   {"action_type"=>"photo_view", "value"=>6578},
  #   {"action_type"=>"post", "value"=>33},
  #   {"action_type"=>"post_like", "value"=>5466},
  #   {"action_type"=>"unlike", "value"=>38},
  #   {"action_type"=>"video_play", "value"=>1508},
  #   {"action_type"=>"video_view", "value"=>1783},
  #   {"action_type"=>"page_engagement", "value"=>20390},
  #   {"action_type"=>"post_engagement", "value"=>14519}],
  # @unique_clicks=15999,
  # @unique_ctr=11.229496115053,
  # @unique_impressions=142473,
  # @unique_link_clicks_ctr=0.26812097730798,
  # @unique_social_clicks=3303,
  # @unique_social_impressions=35106,
  # @video_10_sec_watched_actions=
  #  [{"action_type"=>"video_view", "value"=>1674}, {"action_type"=>"page_engagement", "value"=>1674}, {"action_type"=>"post_engagement", "value"=>1674}],
  # @video_15_sec_watched_actions=
  #  [{"action_type"=>"video_view", "value"=>1646}, {"action_type"=>"page_engagement", "value"=>1646}, {"action_type"=>"post_engagement", "value"=>1646}],
  # @video_30_sec_watched_actions=
  #  [{"action_type"=>"video_view", "value"=>1570}, {"action_type"=>"page_engagement", "value"=>1570}, {"action_type"=>"post_engagement", "value"=>1570}],
  # @video_avg_pct_watched_actions=
  #  [{"action_type"=>"video_view", "value"=>100}, {"action_type"=>"page_engagement", "value"=>6.06}, {"action_type"=>"post_engagement", "value"=>7.33}],
  # @video_avg_sec_watched_actions=
  #  [{"action_type"=>"video_view", "value"=>16}, {"action_type"=>"page_engagement", "value"=>0}, {"action_type"=>"post_engagement", "value"=>1}],
  # @video_complete_watched_actions=
  #  [{"action_type"=>"video_view", "value"=>1570}, {"action_type"=>"page_engagement", "value"=>1570}, {"action_type"=>"post_engagement", "value"=>1570}],
  # @video_p100_watched_actions=
  #  [{"action_type"=>"video_view", "value"=>1497}, {"action_type"=>"page_engagement", "value"=>1497}, {"action_type"=>"post_engagement", "value"=>1497}],
  # @video_p25_watched_actions=
  #  [{"action_type"=>"video_view", "value"=>1927}, {"action_type"=>"page_engagement", "value"=>1927}, {"action_type"=>"post_engagement", "value"=>1927}],
  # @video_p50_watched_actions=
  #  [{"action_type"=>"video_view", "value"=>1795}, {"action_type"=>"page_engagement", "value"=>1795}, {"action_type"=>"post_engagement", "value"=>1795}],
  # @video_p75_watched_actions=
  #  [{"action_type"=>"video_view", "value"=>1670}, {"action_type"=>"page_engagement", "value"=>1670}, {"action_type"=>"post_engagement", "value"=>1670}],
  # @video_p95_watched_actions=
  #  [{"action_type"=>"video_view", "value"=>1520}, {"action_type"=>"page_engagement", "value"=>1520}, {"action_type"=>"post_engagement", "value"=>1520}],
  # @website_clicks=31102,
  # @website_ctr=[{"action_type"=>"link_click", "value"=>0.27298929628015}]>]

rescue Exception => e
  puts e
end
