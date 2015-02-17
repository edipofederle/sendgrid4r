# encoding: utf-8
require File.dirname(__FILE__) + '/../spec_helper'

describe "SendGrid4r::REST::Stats::Subuser" do

  before :all do
    Dotenv.load
    @client = SendGrid4r::Client.new(ENV["SILVER_SENDGRID_USERNAME"], ENV["SILVER_SENDGRID_PASSWORD"])
    @subuser = ENV["SILVER_SUBUSER"]
  end

  context "always" do
    describe "#get_subusers_stats" do
      it "returns subusers stats if specify mandatory params" do
        begin
        actual = @client.get_subusers_stats(@subuser, "2015-01-01")
        expect(actual.class).to be(Array)
        expect(actual.length > 0).to be(true)
        actual.each{|global_stat|
          expect(global_stat.class).to be(SendGrid4r::REST::Stats::TopStat)
          stats = global_stat.stats
          expect(stats.length).to eq(1)
          stats.each{|stat|
            expect(stat.class).to be(SendGrid4r::REST::Stats::Stat)
            expect(stat.metrics.class).to be(SendGrid4r::REST::Stats::Metric)
          }
        }
      rescue => e
        puts e.inspect
      end
      end
      it "returns subusers stats if specify all params" do
        actual = @client.get_subusers_stats(@subuser, "2015-01-01", "2015-01-02")
        expect(actual.class).to be(Array)
        expect(actual.length > 0).to be(true)
        actual.each{|global_stat|
          expect(global_stat.class).to be(SendGrid4r::REST::Stats::TopStat)
          stats = global_stat.stats
          expect(stats.length).to eq(1)
          stats.each{|stat|
            expect(stat.class).to be(SendGrid4r::REST::Stats::Stat)
            expect(stat.metrics.class).to be(SendGrid4r::REST::Stats::Metric)
          }
        }
      end
    end
    describe "#get_subusers_stats_sums" do
      it "returns subusers stats sums if specify mandatory params" do
        actual = @client.get_subusers_stats_sums("2015-01-01")
        expect(actual.class).to be(SendGrid4r::REST::Stats::TopStat)
        stats = actual.stats
        expect(stats.length).to eq(2)
        stats.each{|stat|
          expect(stat.class).to be(SendGrid4r::REST::Stats::Stat)
          expect(stat.metrics.class).to be(SendGrid4r::REST::Stats::Metric)
        }
      end
      it "returns subusers stats sums if specify all params" do
        actual = @client.get_subusers_stats_sums(
          "2015-01-01", "2015-01-02", "opens", "desc", 5, 0)
        expect(actual.class).to be(SendGrid4r::REST::Stats::TopStat)
        stats = actual.stats
        expect(stats.length).to eq(0)
        stats.each{|stat|
          expect(stat.class).to be(SendGrid4r::REST::Stats::Stat)
          expect(stat.metrics.class).to be(SendGrid4r::REST::Stats::Metric)
        }
      end
    end
  end
end