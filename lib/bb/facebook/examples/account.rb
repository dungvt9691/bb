# Get access token example
# https://www.facebook.com/dialog/oauth?
# client_id=493410937487049&redirect_uri=http://bigbom.adtopgo.com/&
# scope=ads_management,ads_read,read_insights

# https://graph.facebook.com/v2.5/oauth/access_token?
# client_id=493410937487049&redirect_uri=http://bigbom.adtopgo.com/&
# client_secret=5f9a3562b7da49169668bc765533ab4d&code=<CODE>

require 'bb'
begin
  auth_code = "CAAXEoAgtbrIBAGZAGrTb9SnMEbCzMMk5cdd4ZCM5jhr14ZCrGz6w93OEWOMwexLFuZAZBIZBIIYrXLN2GKEz7ZAlm78nTg2FMzSDaNAuerByZAcCZC4Mjmiz0YDHnlFZBbvXJlaTHTVZC11iv6ZBT5t5jpcKPOwh9PJHQGamUD7CGfQULLb3a1xl5uRmzub6KCXlRRCGIZAZBDDQuUo94xhXFjibqv"
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
  
rescue Exception => e
  puts e
end
