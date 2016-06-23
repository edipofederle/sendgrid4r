module SendGrid4r::CLI
  module Stats
    #
    # SendGrid Web API v3 Stats Global
    #
    class Global < SgThor
      desc 'get', 'Gets all of your user’s email statistics.'
      option :start_date, require: true
      option :end_date
      option :aggregated_by
      def get
        puts @client.get_global_stats(parameterise(options))
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end
    end
  end
end
