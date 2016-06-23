# encoding: utf-8
require File.dirname(__FILE__) + '/../spec_helper'

module SendGrid4r::REST
  describe SpamReports do
    describe 'integration test', :it do
      before do
        Dotenv.load
        @client = SendGrid4r::Client.new(api_key: ENV['SILVER_API_KEY'])
        @emails = [
          'a1@spam_report.com', 'a2@spam_report.com', 'a3@spam_report.com'
        ]
      end

      context 'without block call' do
        it '#get_spam_reports' do
          start_time = Time.now - 60 * 60 * 24 * 365
          end_time = Time.now
          spam_reports = @client.get_spam_reports(
            start_time: start_time, end_time: end_time
          )
          expect(spam_reports).to be_a(Array)
          spam_reports.each do |spam_report|
            expect(spam_report).to be_a(
              SpamReports::SpamReport
            )
          end
        end

        it '#delete_spam_reports(delete_all: true)' do
          @client.delete_spam_reports(delete_all: true)
        end

        it '#delete_spam_reports(emails: [])' do
          @client.delete_spam_reports(emails: @emails)
        end

        it '#get_spam_report' do
          spam_report = @client.get_spam_report(email: @email)
          expect(spam_report).to be_a(Array)
        end

        it '#delete_spam_report' do
          expect do
            @client.delete_spam_report(email: 'a1@spam_report.com')
          end.to raise_error(RestClient::ResourceNotFound)
        end
      end
    end

    describe 'unit test', :ut do
      let(:client) do
        SendGrid4r::Client.new(api_key: '')
      end

      let(:spam_reports) do
        '['\
          '{'\
            '"created": 1443651141,'\
            '"email": "user1@example.com",'\
            '"ip": "10.63.202.100"'\
          '},'\
          '{'\
            '"created": 1443651154,'\
            '"email": "user2@example.com",'\
            '"ip": "10.63.202.100"'\
          '}'\
        ']'
      end

      let(:spam_report) do
        '{'\
          '"created": 1454433146,'\
          '"email": "test1@example.com",'\
          '"ip": "10.89.32.5"'\
        '}'
      end

      it '#get_spam_reports' do
        allow(client).to receive(:execute).and_return(spam_reports)
        actual = client.get_spam_reports
        expect(actual).to be_a(Array)
        actual.each do |spam_report|
          expect(spam_report).to be_a(SpamReports::SpamReport)
        end
      end

      it '#delete_spam_reports(delete_all: true)' do
        allow(client).to receive(:execute).and_return('')
        client.delete_spam_reports(delete_all: true)
      end

      it '#delete_spam_reports(emails: [])' do
        allow(client).to receive(:execute).and_return('')
        actual = client.delete_spam_reports(emails: [])
        expect(actual).to eq('')
      end

      it '#get_spam_report' do
        allow(client).to receive(:execute).and_return(spam_reports)
        actual = client.get_spam_report(email: '')
        expect(actual).to be_a(Array)
        actual.each do |spam_report|
          expect(spam_report).to be_a(SpamReports::SpamReport)
        end
      end

      it '#delete_spam_report' do
        allow(client).to receive(:execute).and_return('')
        actual = client.delete_spam_report(email: '')
        expect(actual).to eq('')
      end

      it 'creates spam_reports instance' do
        actual = SpamReports.create_spam_reports(JSON.parse(spam_reports))
        expect(actual).to be_a(Array)
        actual.each do |subuser|
          expect(subuser).to be_a(SpamReports::SpamReport)
        end
      end

      it 'creates spam_report instance' do
        actual = SpamReports.create_spam_report(JSON.parse(spam_report))
        expect(actual).to be_a(SpamReports::SpamReport)
        expect(actual.created).to eq(Time.at(1454433146))
        expect(actual.email).to eq('test1@example.com')
        expect(actual.ip).to eq('10.89.32.5')
      end
    end
  end
end
