module BB
  module Facebook
    class Insight < BB::Facebook::Model
      attr_accessor :actions, :unique_actions, :app_store_clicks,
      :call_to_action_clicks, :card_views, :unique_clicks,
      :cost_per_action_type, :cost_per_inline_post_engagement,
      :cost_per_inline_link_click, :cost_per_total_action,
      :cost_per_unique_action_type, :cost_per_10_sec_video_view,
      :cost_per_unique_click, :cpm, :cpp, :ctr, :unique_ctr, :date_start,
      :date_stop, :deeplink_clicks, :estimated_ad_recall_rate,
      :estimated_ad_recall_rate_lower_bound, :estimated_ad_recall_rate_upper_bound,
      :frequency, :impressions, :unique_impressions, :inline_link_clicks,
      :inline_post_engagement, :reach, :social_clicks, :unique_social_clicks,
      :social_impressions, :unique_social_impressions, :social_reach,
      :spend, :total_action_value, :total_actions, :total_unique_actions,
      :unique_link_clicks_ctr, :video_avg_pct_watched_actions,
      :video_avg_sec_watched_actions, :video_complete_watched_actions,
      :video_p25_watched_actions, :video_p50_watched_actions,
      :video_p75_watched_actions, :video_p95_watched_actions,
      :video_p100_watched_actions, :video_10_sec_watched_actions,
      :video_15_sec_watched_actions, :video_30_sec_watched_actions,
      :website_clicks, :website_ctr, :buying_type, :account_id, :campaign_id,
      :relevance_score, :estimated_ad_recallers, :estimated_ad_recallers_lower_bound,
      :estimated_ad_recallers_upper_bound
      
      def self.source_id=(source_id)
        @source_id = source_id
      end

      def self.source_id
        @source_id
      end

      def self.all(filter = {})
        begin
          request = BB::Facebook::Request.new(graph: BB::Facebook.graph)

          req_insights = request.get_insights(self.source_id, filter)

          unless req_insights['error'].nil?
            raise BB::Errors::NotFound, req_insights['error']['message']
          end

          insights = []

          req_insights['data'].each do |insight|
            attributes = self.symbolize_keys!(insight)

            insight = BB::Facebook::Insight.new(attributes)

            insights << insight
          end

          insights
        rescue BB::Errors::NotFound => e
          puts e.message
          nil
        rescue Exception => e
          puts e.message
          nil
        end
      end
    end
  end
end