# -*- encoding: utf-8 -*-

module SendGrid4r
  module Factory
    #
    # SendGrid Web API v3 Campaign Factory Class implementation
    #
    class CampaignFactory
      def create(title: nil, subject: nil, sender_id: nil, list_ids: nil,
        segment_ids: nil, categories: nil, suppression_group_id: nil,
        custom_unsubscribe_url: nil, ip_pool: nil, html_content: nil,
        plain_content: nil)
        segment = SendGrid4r::REST::MarketingCampaigns::Campaign.new(
          nil, title, subject, sender_id, list_ids, segment_ids, categories,
          suppression_group_id, custom_unsubscribe_url, ip_pool, html_content,
          plain_content, nil, nil
        )
        hash = segment.to_h
        segment.to_h.each do |key, value|
          hash.delete(key) if value.nil?
        end
        hash
      end
    end
  end
end
