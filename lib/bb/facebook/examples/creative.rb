# Get access token example
# https://www.facebook.com/dialog/oauth?
# client_id=493410937487049&redirect_uri=http://bigbom.adtopgo.com/&
# scope=ads_management,ads_read,read_insights

# https://graph.facebook.com/v2.5/oauth/access_token?
# client_id=493410937487049&redirect_uri=http://bigbom.adtopgo.com/&
# client_secret=5f9a3562b7da49169668bc765533ab4d&code=<CODE>

# Object story id example: "1740497286175357_1906452529579831"
# Image hash example: 12a4601709f145d16b3770132db5e003

require 'bb'

begin
  auth_code = "CAAXEoAgtbrIBAGc02KX166aZAdFq8DNH3ylHH2FwLvPhKeRFKwZCYl5J954jkMZCmn8A1I8MbhZAdRPWEtcFKeIXQz1gFtZCSvIyo9I1mTiW0GPmf0eBxZAvKBi1hN5ZAIqzwH2mxP4M9vOdRyFX1KBgabZAZCst8YWZBO6PCWX5xZBtEmwSz4biYFDFtHqZCy1XbgsKhmvbsMIlQLTp8GLGLJdr"
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

  # List all account's creatives
  # Return: creatives array
  creatives = BB::Facebook::Creative.all 
  # Array: 
  # [#<BB::Facebook::Creative:0x007fce8a841d58
  #  @body="trang nay hay lam",
  #  @id="6033282963948",
  #  @image_hash="12a4601709f145d16b3770132db5e003",
  #  @image_url="https://fbcdn-creative-a.akamaihd.net/hads-ak-xpa1/t45.1600-4/s110x80/12124989_6032140677748_1941490570_n.jpg",
  #  @link_og_id="919328211462040",
  #  @name="Test thoi ma",
  #  @object_type="DOMAIN",
  #  @object_url="http://hucau.tv/",
  #  @run_status="ACTIVE",
  #  @thumbnail_url=
  #   "https://fbexternal-a.akamaihd.net/safe_image.php?d=AQAnWZ4J6Pqyrnpn&w=64&h=64&url=https%3A%2F%2Ffbcdn-creative-a.akamaihd.net%2Fhads-ak-xta1%2Ft45.1600-4%2F12124839_6032140677948_563097645_n.jpg&cfs=1",
  #  @title="Test thoi ma">]

  # Get a account's creative
  # Return: creative object
  creative = BB::Facebook::Creative.find(creatives.first.id)
  # Creative object: 
  # #<BB::Facebook::Creative:0x007fce8a841d58
  # @body="trang nay hay lam",
  # @id="6033282963948",
  # @image_hash="12a4601709f145d16b3770132db5e003",
  # @image_url="https://fbcdn-creative-a.akamaihd.net/hads-ak-xpa1/t45.1600-4/s110x80/12124989_6032140677748_1941490570_n.jpg",
  # @link_og_id="919328211462040",
  # @name="Test thoi ma",
  # @object_type="DOMAIN",
  # @object_url="http://hucau.tv/",
  # @run_status="ACTIVE",
  # @thumbnail_url=
  #  "https://fbexternal-a.akamaihd.net/safe_image.php?d=AQAnWZ4J6Pqyrnpn&w=64&h=64&url=https%3A%2F%2Ffbcdn-creative-a.akamaihd.net%2Fhads-ak-xta1%2Ft45.1600-4%2F12124839_6032140677948_563097645_n.jpg&cfs=1",
  # @title="Test thoi ma">
 
  # Create creative
  # + Create by params object_story_id
  # Return: creative object
  creative_1 = BB::Facebook::Creative.new(object_story_id: "1740497286175357_1906452529579831")
  creative_1.save
  # Creative object: 
  # #<BB::Facebook::Creative:0x007f7f7d483cb8
  # @id="6033281856748",
  # @name="Quảng cáo từ một bài viết trên Trang #6.033.281.856.748",
  # @object_story_id="1740497286175357_1906452529579831",
  # @object_type="PHOTO",
  # @run_status="ACTIVE",
  # @thumbnail_url=
  #  "https://fbexternal-a.akamaihd.net/safe_image.php?d=AQCSkZVHG_hh4vtJ&w=64&h=64&url=https%3A%2F%2Fscontent.xx.fbcdn.net%2Fhphotos-xta1%2Fv%2Ft1.0-9%2F11218712_1906452529579831_1906917211863300106_n.jpg%3Foh%3Df0fa73ae2778fdad67e1cad4c8ab7818%26oe%3D56C11694&cfs=1">

  # Or create by create method
  # Return: creative object
  creative_2 = BB::Facebook::Creative.create(object_story_id: "1740497286175357_1906452529579831")
  # Creative object: 
  # #<BB::Facebook::Creative:0x007f7f80043da8
  # @id="6033281856748",
  # @name="Quảng cáo từ một bài viết trên Trang #6.033.281.856.748",
  # @object_story_id="1740497286175357_1906452529579831",
  # @object_type="PHOTO",
  # @run_status="ACTIVE",
  # @thumbnail_url=
  #  "https://fbexternal-a.akamaihd.net/safe_image.php?d=AQCSkZVHG_hh4vtJ&w=64&h=64&url=https%3A%2F%2Fscontent.xx.fbcdn.net%2Fhphotos-xta1%2Fv%2Ft1.0-9%2F11218712_1906452529579831_1906917211863300106_n.jpg%3Foh%3Df0fa73ae2778fdad67e1cad4c8ab7818%26oe%3D56C11694&cfs=1">

  # + Create by params object_story_spec
  # Return: creative object
  object_story_spec = {
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
  creative_3 = BB::Facebook::Creative.new(object_story_spec: object_story_spec)
  creative_3.save
  # Creative object: 
  # #<BB::Facebook::Creative:0x007fd6034a2078
  # @id="6033287031748",
  # @name="Ad from a Page post #6,033,287,031,748",
  # @object_story_id="1740497286175357_1915748701983547",
  # @object_story_spec=
  #  {:page_id=>"1740497286175357",
  #   :link_data=>
  #    {:link=>"http://dungvuthe.com/",
  #     :message=>"try it out",
  #     :caption=>"My caption",
  #     :call_to_action=>{:type=>"SIGN_UP", :value=>{:link_caption=>"Sign up!", :link=>"http://dungvuthe.com/"}},
  #     :multi_share_end_card=>true,
  #     :multi_share_optimized=>true}},
  # @object_type="SHARE",
  # @run_status="ACTIVE",
  # @thumbnail_url=
  #  "https://fbexternal-a.akamaihd.net/safe_image.php?d=AQATcGKATQN_nGvb&w=64&h=64&url=https%3A%2F%2Fwww.facebook.com%2Fimages%2Fshare_options%2Fshare_arrow.gif&cfs=1">

  # Or create by create method
  # Return: creative object
  creative_4 = BB::Facebook::Creative.create(object_story_spec: object_story_spec)
  # Creative object: 
  # #<BB::Facebook::Creative:0x007fd6034a2078
  # @id="6033287031748",
  # @name="Ad from a Page post #6,033,287,031,748",
  # @object_story_id="1740497286175357_1915748701983547",
  # @object_story_spec=
  #  {:page_id=>"1740497286175357",
  #   :link_data=>
  #    {:link=>"http://dungvuthe.com/",
  #     :message=>"try it out",
  #     :caption=>"My caption",
  #     :call_to_action=>{:type=>"SIGN_UP", :value=>{:link_caption=>"Sign up!", :link=>"http://dungvuthe.com/"}},
  #     :multi_share_end_card=>true,
  #     :multi_share_optimized=>true}},
  # @object_type="SHARE",
  # @run_status="ACTIVE",
  # @thumbnail_url=
  #  "https://fbexternal-a.akamaihd.net/safe_image.php?d=AQATcGKATQN_nGvb&w=64&h=64&url=https%3A%2F%2Fwww.facebook.com%2Fimages%2Fshare_options%2Fshare_arrow.gif&cfs=1">

  # + Create by params object_url
  # Return: creative object
  creative_params = {
    object_url: "http://dungvuthe.com",
    title: "Test creative 1",
    body: "Test",
    image_hash: "12a4601709f145d16b3770132db5e003"
  }
  creative_5 = BB::Facebook::Creative.new(creative_params)
  creative_5.save
  # Creative object: 
  # #<BB::Facebook::Creative:0x007f7f80197308
  # @body="Test",
  # @image_hash="12a4601709f145d16b3770132db5e003",
  # @object_url="http://dungvuthe.com",
  # @title="Test object 1">

  # Or create by create method
  # Return: creative object
  creative_6 = BB::Facebook::Creative.create(creative_params)
  # Creative object: 
  # #<BB::Facebook::Creative:0x007f7f80197308
  # @body="Test",
  # @image_hash="12a4601709f145d16b3770132db5e003",
  # @object_url="http://dungvuthe.com",
  # @title="Test object 1">

  # Update creative
  # Return: Boolean
  update_creative = creative_1
  update_creative.update_attributes(name: "Creative Updated")
  # Updated Creative: 
  # #<BB::Facebook::Creative:0x007f9312a03028
  # @id="6033287061948",
  # @name="Test Updated 1",
  # @object_story_id="1740497286175357_1915748838650200",
  # @object_story_spec=
  #  {:page_id=>"1740497286175357",
  #   :link_data=>
  #    {:link=>"http://dungvuthe.com/",
  #     :message=>"try it out",
  #     :caption=>"My caption",
  #     :call_to_action=>{:type=>"SIGN_UP", :value=>{:link_caption=>"Sign up!", :link=>"http://dungvuthe.com/"}},
  #     :multi_share_end_card=>true,
  #     :multi_share_optimized=>true}},
  # @object_type="SHARE",
  # @run_status="ACTIVE",
  # @thumbnail_url=
  #  "https://fbexternal-a.akamaihd.net/safe_image.php?d=AQATcGKATQN_nGvb&w=64&h=64&url=https%3A%2F%2Fwww.facebook.com%2Fimages%2Fshare_options%2Fshare_arrow.gif&cfs=1">

  # Destroy creative
  # Return: Boolean
  puts "Destroyed creative_1" if creative_1.destroy
  puts "Destroyed creative_2" if creative_2.destroy
  puts "Destroyed creative_3" if creative_3.destroy
  puts "Destroyed creative_4" if creative_4.destroy
  puts "Destroyed creative_5" if creative_5.destroy
  puts "Destroyed creative_6" if creative_6.destroy

rescue Exception => e
  puts e
end
