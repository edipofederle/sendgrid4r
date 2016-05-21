# -*- encoding: utf-8 -*-

module SendGrid4r
  module Factory
    #
    # SendGrid Web API v3 MailFactory implementation
    #
    module MailFactory
      def self.create_params(
        personalizations:, from:, content:
      )
        SendGrid4r::REST::Mail::Params.new(
          nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,
          nil, nil, nil, nil, nil, nil
        ).tap do |params|
          params.personalizations = personalizations
          params.from = from
          params.content = content
        end
      end

      def self.create_email(email:, name: nil)
        SendGrid4r::REST::Mail::Email.new(email, name)
      end

      def self.create_personalization(to:, subject:)
        SendGrid4r::REST::Mail::Personalization.new(
          nil, nil, nil, nil, nil, nil, nil, nil
        ).tap do |personalization|
          personalization.to = to
          personalization.subject = subject
        end
      end

      def self.create_attachment(content:, filename:)
        SendGrid4r::REST::Mail::Attachment.new(
          nil, nil, nil, nil, nil
        ).tap do |attachment|
          attachment.content = content
          attachment.filename = filename
        end
      end

      def self.create_mail_settings
        SendGrid4r::REST::Mail::MailSettings.new(nil, nil, nil, nil, nil)
      end

      def self.create_tracking_settings
        SendGrid4r::REST::Mail::TrackingSettings.new(nil, nil, nil, nil)
      end

      def self.create_content(type:, value:)
        SendGrid4r::REST::Mail::Content.new(type, value)
      end
    end
  end
end
