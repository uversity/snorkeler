require 'spec_helper'

describe Snorkeler do
  describe "configure" do
    before do
      Snorkeler.configure do |config|
        config.endpoint = "http://localhost:3000"
      end
    end
    subject { Snorkeler.endpoint }
    it { should == 'http://localhost:3000' }
  end
end