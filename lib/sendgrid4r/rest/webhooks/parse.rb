# -*- encoding: utf-8 -*-

module SendGrid4r::REST
  #
  # SendGrid Web API v3 Webhooks
  #
  module Webhooks
    #
    # SendGrid Web API v3 Webhooks Parse
    #
    module Parse
      include Request

      ParseSettings = Struct.new(:result)
      ParseSetting = Struct.new(:url, :hostname, :spam_check_outgoing)

      def self.url
        "#{BASE_URL}/user/webhooks/parse/settings"
      end

      def self.create_parse_settings(resp)
        return resp if resp.nil?
        parse_settings = resp['result'].map do |setting|
          Parse.create_parse_setting(setting)
        end
        ParseSettings.new(parse_settings)
      end

      def self.create_parse_setting(resp)
        return resp if resp.nil?
        ParseSetting.new(
          resp['url'], resp['hostname'], resp['spam_check_outgoing']
        )
      end

      def get_parse_settings(&block)
        resp = get(@auth, Parse.url, &block)
        finish(resp, @raw_resp) { |r| Parse.create_parse_settings(r) }
      end
    end
  end
end
