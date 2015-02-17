# encoding: utf-8
require File.dirname(__FILE__) + '/../spec_helper'

describe "SendGrid4r::REST::Stats::Global" do

  before :all do
    Dotenv.load
    @client = SendGrid4r::Client.new(ENV["SENDGRID_USERNAME"], ENV["SENDGRID_PASSWORD"])
  end

  context "always" do

    describe "#get_global_stats" do

      it "returns global stats if specify mandatory params" do
        actual = @client.get_global_stats("2015-01-01")
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

      it "returns global stats if specify all params" do
        actual = @client.get_global_stats(
          "2015-01-01", "2015-01-01", SendGrid4r::REST::Stats::AggregatedBy::WEEK)
        expect(actual.class).to be(Array)
        expect(actual.length).to eq(2)
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

  end

end
