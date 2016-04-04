require 'bb'

begin
  auth_code = "CAAHAwSZBoPskBAPVlNF5d3FP7a9vjleXCXvboAFNWp1RFmoxxflW0xQpsnUpdIH1VryMtvOZBwSqAu9EZAKhzvZCxJ92Ho0WckMzMcjNvXYxXO9JXVoW446I7W3ZCUM7IafedzxnejxZAdeRPxvQm5ApwU1AvTVhOwqC4CSuQPPpllzSqIfV8XZBlxUe5FXsTGR0R3kGGtVE9VZASNKb2cZCk"
  partner   = "facebook"
  end_point = "https://graph.facebook.com"
  version   = 2.5

  # Set up service
  @service = BB::Service.new(auth_code: auth_code, partner: partner, end_point: end_point, version: version)

  # Get facebook ad account
  # Return: account object
  BB::Facebook.graph = @service.facebook
  @account = BB::Facebook::Account.find("1394098590824258")
  BB::Facebook::Account.id = @account.id
  binding.pry
rescue Exception => e
  puts e
end