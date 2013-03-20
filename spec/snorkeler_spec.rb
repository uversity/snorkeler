require 'spec_helper'

describe Snorkeler do
  before do
    Snorkeler.configure do |config|
      config.endpoint = "http://localhost:3001"
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
    let (:samples) do
      [
        {
          integer: {
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
    subject { Snorkeler.import "psql", "slow_queries", samples}
    it { should == ""}
  end
end