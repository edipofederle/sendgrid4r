# -*- encoding: utf-8 -*-

module SendGrid4r::REST
  #
  # SendGrid Web API v3 Blocks
  #
  module Blocks
    include Request

    Block = Struct.new(:created, :email, :reason, :status)

    def self.url(email = nil)
      url = "#{BASE_URL}/suppression/blocks"
      url = "#{url}/#{email}" unless email.nil?
      url
    end

    def self.create_blocks(resp)
      return resp if resp.nil?
      resp.map { |block| Blocks.create_block(block) }
    end

    def self.create_block(resp)
      return resp if resp.nil?
      created = Time.at(resp['created']) unless resp['created'].nil?
      Block.new(created, resp['email'], resp['reason'], resp['status'])
    end

    def get_blocks(
      start_time: nil, end_time: nil, limit: nil, offset: nil, &block
    )
      params = {}
      params[:start_time] = start_time.to_i unless start_time.nil?
      params[:end_time] = end_time.to_i unless end_time.nil?
      params[:limit] = limit.to_i unless limit.nil?
      params[:offset] = offset.to_i unless offset.nil?
      resp = get(@auth, Blocks.url, params, &block)
      finish(resp, @raw_resp) { |r| Blocks.create_blocks(r) }
    end

    def delete_blocks(delete_all: nil, emails: nil, &block)
      if delete_all
        payload = { delete_all: delete_all }
      else
        payload = { emails: emails }
      end
      delete(@auth, Blocks.url, nil, payload, &block)
    end

    def get_block(email:, &block)
      resp = get(@auth, Blocks.url(email), &block)
      finish(resp, @raw_resp) { |r| Blocks.create_blocks(r) }
    end

    def delete_block(email:, &block)
      delete(@auth, Blocks.url(email), &block)
    end
  end
end
