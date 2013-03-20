require 'spec_helper'

describe Snorkeler do
  before do
    Snorkeler.configure do |config|
      config.endpoint = "http://localhost:3001"
      config.middleware = Faraday::Builder.new do |builder|
        # Checks for files in the payload
        # Handle 4xx server responses
        builder.use Snorkeler::Response::RaiseError, Snorkeler::Error::ClientError
        # Parse JSON response bodies using MultiJson
        builder.use Snorkeler::Response::ParseJson
        # Handle 5xx server responses
        builder.use Snorkeler::Response::RaiseError, Snorkeler::Error::ServerError
        # Set Faraday's HTTP adapter
        builder.adapter :typhoeus
      end
    end
  end
  describe "self" do
    subject { Snorkeler }
    it { should respond_to :configure}
    it { should respond_to :client}
    it { should respond_to :import}
  end

  describe ".configure" do
    subject { Snorkeler.endpoint }
    it { should == 'http://localhost:3001' }
  end

  describe ".client" do
    subject { Snorkeler.client }
    it { should_not be_nil }
    it { should respond_to :import }
  end

  describe ".import" do
    describe "success" do
      describe "sample data" do
        use_vcr_cassette
        let (:samples) do
          [
            {
              integer: {
                time:  100,
                query_duration: 500,
                query_count: 10,
                weight: 1000,
              },
              string: {
                table: 'a_mysql_table',
                query_str: 'select * from <TABLE>;',
                host: 'mysql001'
              },
              set: {
                flags: ['foo', 'bar', 'baz']
              }
            }
          ]
        end
        subject { Snorkeler.import dataset: "psql", subset: "slow_queries", samples: samples}
        it { should == {message: "INSERTED"} }
      end
      describe "nil data set" do
        use_vcr_cassette
        let (:samples) { nil }
        subject { Snorkeler.import dataset: "psql", subset: "slow_queries", samples: samples}
        it { should == {message: "INSERTED"} }
      end
    end
    describe "fail" do
      describe "empty data set" do
        use_vcr_cassette
        let (:samples) {[] }
        subject { Snorkeler.import dataset: "psql", subset: "slow_queries", samples: samples}
        it { should == {message: "ERROR"}}
      end
    end
  end
end
