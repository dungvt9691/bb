Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/bb`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'bb'
```

And then execute:

$ bundle

Or install it yourself as:

$ gem install bb

# Usage

Setup your service:

```ruby
service = BB::Service.new(partner: <partner>, auth_code: <auth_code>,
end_point: <end_point>, version: <version>)
```

- partner: "Facebook", "Google"
- auth_code: Access token if partner is Facebook
- end_point: Partner's API end point (Facebook is https://graph.facebook.com)
- version: Partner's API version


## Facebook Ads Management

Setup facebook graph api:

```ruby
BB::Facebook.graph = @service.facebook
```

##### AD ACCOUNTS
- List all ad accounts:

```ruby
@accounts = BB::Facebook::Account.all
```

Return `BB::Facebook::Account` objects array

- Find campaign by `id`:

```ruby
@account = BB::Facebook::Account.find(<account_id>)
```

Return `BB::Facebook::Account` object

##### AD CAMPAIGNS

**NOTE**: View more `campaigns` informations at https://developers.facebook.com/docs/marketing-api/reference/ad-campaign-group

Setup account_id to call api:

```ruby
BB::Facebook::Account.id = BB::Facebook::Account.get_account.id
```

- List all campaigns:

```ruby
@campaigns = BB::Facebook::Campaign.all
```

Return `BB::Facebook::Campaign` objects array

- List campaigns with `conditions [HASH]`:

```ruby
@campaigns = BB::Facebook::Campaign.where(<condition>)
```

Return `BB::Facebook::Campaign` objects array

- Find campaign by `id`:

```ruby
@campaign = BB::Facebook::Campaign.find(<campaign_id>)
```

Return `BB::Facebook::Campaign` object

- Create a campaign:

Require params: `name`, `objective`, `status`

```ruby
@campaign = BB::Facebook::Campaign.new(name: <name>, objective: <object>, status: <status>)
@campaign.save
```
Return `Boolean`

Or using `create` method:

```ruby
@campaign = BB::Facebook::Campaign.create(name: <name>, objective: <object>, status: <status>)
```

Return `BB::Facebook::Campaign` object

- Update a campaign:

Only update fields: `name`

```ruby
@campaign = BB::Facebook::Campaign.find(<campaign_id>)
@campaign.update_attributes(name: <new_name>)
```

Return `Boolean`

- Destroy a campaign:

```ruby
@campaign = BB::Facebook::Campaign.find(<campaign_id>)
@campaign.destroy
```

Return `Boolean`

##### AD SETS

**NOTE**: View more `targeting` informations at https://developers.facebook.com/docs/marketing-api/buying-api/targeting

Setup account_id to call api:

```ruby
BB::Facebook::Account.id = BB::Facebook::Account.get_account.id
```

- List all ad sets:

```ruby
@adsets = BB::Facebook::Adset.all
```

Return `BB::Facebook::Adset` objects array

- List ad sets with `conditions [HASH]`:

```ruby
@adsets = BB::Facebook::Adset.where(<condition>)
```

Return `BB::Facebook::Adset` objects array

- Find ad set by `id`:

```ruby
@adset = BB::Facebook::Adset.find(<adset_id>)
```

Return `BB::Facebook::Adset` object

- Create an ad set:

Required params: `name`, `campaign_id`, `billing_event`, `targeting`, `daily_budget`, `optimization_goal`

Required one params: `bid_amount`, `is_autobid`


```ruby
#Example params:

adset_params = {
  name: <name>,
  campaign_id: <campaign_id>,
  billing_event: <billing_event>,
  targeting: <targeting>,
  daily_budget: <daily_budget>,
  bid_amount: <bid_amount>,
  optimization_goal: <optimization_goal>
}
```

```ruby
@adset = BB::Facebook::Adset.new(adset_params)
@adset.save
```

Return `Boolean`

Or using `create` method:
```ruby
@adset = BB::Facebook::Adset.create(adset_params)
```

Return `BB::Facebook::Adset` object

- Update an ad set:

Only update fields: `billing_event`, `optimization_goal`, `name`, `targeting`, `bid_amount`, `adset_schedule`, `pacing_type`, `lifetime_budget`, `daily_budget`, `status`, `start_time`, `end_time`, `is_autobid`

```ruby
#Example params:

update_params = {
  name: <name>,
  status: <status>,
  targeting: <targeting>,
  bid_amount: <bid_amount>,
  pacing_type: <pacing_type>,
  lifetime_budget: <lifetime_budget>,
  adset_schedule: <adset_schedule>,
  end_time: <end_time>
}
```

```ruby
@adset = BB::Facebook::Adset.find(<adset_id>)
@adset.update_attributes(update_params)
```
Return `Boolean`

- Destroy an ad set:

```ruby
@adset = BB::Facebook::Adset.find(<adset_id>)
@adset.destroy
```

Return `Boolean`

##### AD CREATIVES

**NOTE**: View more `creatives` informations at https://developers.facebook.com/docs/marketing-api/reference/ad-creative

Setup account_id to call api:

```ruby
BB::Facebook::Account.id = BB::Facebook::Account.get_account.id
```

- List all creatives:

```ruby
@creatives = BB::Facebook::Creative.all
```

Return `BB::Facebook::Creative` objects array

- List creatives with `conditions [HASH]`:

```ruby
@creatives = BB::Facebook::Creative.where(<condition>)
```

Return `BB::Facebook::Creative` objects array

- Find creative by `id`:

```ruby
@creative = BB::Facebook::Creative.find(<creative_id>)
```

Return `BB::Facebook::Creative` object

- Create a creative:

Requires only params: `object_story_spec`, `object_story_id`, `object_url`


```ruby
#Example params:

creative_params = {
  object_story_spect: {
    "link_data" => {
      "call_to_action" => {
        "type" => <type>,
        "value" => {
          "link" => <url>,
          "link_caption" => <link_caption>
        }
      },
      "caption" => <caption>,
      "link" => <url>,
      "message" => <message>
    },
    "page_id" => <page_id>
  }
}
```

```ruby
@creative = BB::Facebook::Creative.new(creative_params)
@creative.save
```

Return `Boolean`

Or using `create` method:

```ruby
@creative = BB::Facebook::Creative.create(creative_params)
```

Return `BB::Facebook::Creative` object

- Update a creative:

Only update fields: `name`

```ruby
@creative = BB::Facebook::Creative.find(<creative_id>)
@creative.update_attributes(name: <name>)
```

Return `Boolean`

- Destroy a creative:

```ruby
@creative = BB::Facebook::Creative.find(<creative_id>)
@creative.destroy
```

Return `Boolean`

##### ADS

**NOTE**: View more `ads` informations at https://developers.facebook.com/docs/marketing-api/reference/adgroup

Setup account_id to call api:

```ruby
BB::Facebook::Account.id = BB::Facebook::Account.get_account.id
```

- List all ads:

```ruby
@ads = BB::Facebook::Ad.all
```

Return `BB::Facebook::Ad` objects array

- List ads with `conditions [HASH]`:

```ruby
@ads = BB::Facebook::Ad.where(<condition>)
```

Return `BB::Facebook::Ad` objects array

- Find ad by `id`:

```ruby
@ad = BB::Facebook::Ad.find(<ad_id>)
```

Return `BB::Facebook::Ad` object

- Create a ad:

Requires params: `creative`, `status`, `name`, `adset_id`


```ruby
#Example params:

ad_params = {
  status: <status>,
  creative_id: <creative_id>,
  adset_id: <adset_id>,
  name: <name>
}
```

```ruby
@ad = BB::Facebook::Ad.new(ad_params)
@ad.save
```

Return `Boolean`

Or using `create` method:

```ruby
@ad = BB::Facebook::Ad.create(ad_params)
```

Return `BB::Facebook::Ad` object

- Update a ad:

Only update fields: `name`

```ruby
@ad = BB::Facebook::Ad.find(<ad_id>)
@ad.update_attributes(name: <name>)
```

Return `Boolean`

- Destroy a ad:

```ruby
@ad = BB::Facebook::Ad.find(<ad_id>)
@ad.destroy
```

Return `Boolean`

##### AD INSIGHTS

**NOTE**: View more `insights` informations at https://developers.facebook.com/docs/marketing-api/insights-api

Setup source_id to call api:

```ruby
BB::Facebook::Insight.source_id = <account_id>
```

Or

```ruby
BB::Facebook::Insight.source_id = <campaign_id>
```

Or

```ruby
BB::Facebook::Insight.source_id = <adset_id>
```

Or

```ruby
BB::Facebook::Insight.source_id = <ad_id>
```

- List all insights:

```ruby
@insights = BB::Facebook::Insight.all
```

Return `BB::Facebook::Insight` objects array

- List insights with `filter [HASH]`:

```ruby
#Filter params: 
time_range: {'since'=>YYYY-MM-DD,'until'=>YYYY-MM-DD}
time_ranges: list<{'since'=>YYYY-MM-DD,'until'=>YYYY-MM-DD}>
time_increment: enum{monthly, all_days} or integer
date_preset: enum{today, yesterday, last_3_days, this_week, last_week, last_7_days, last_14_days, last_28_days, last_30_days, last_90_days, this_month, last_month, this_quarter, last_3_months, lifetime}
```

```ruby
#Example params:
filter = {
  date_preset: "last_7_days",
  time_increment: 1
}
```

```ruby
@insights = BB::Facebook::Insight.all(filter)
```


Return `BB::Facebook::Insight` objects array



# Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake false` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

# Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/bb. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


# License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

