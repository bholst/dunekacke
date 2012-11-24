require 'spec_helper'

describe Tune do
  let(:user) { FactoryGirl.create(:user) }
  
  describe "with proper abc" do
    before do
      @tune = user.tunes.build(:content => "X:1\nT:No title\nM:3/4\nL:1/8\nK:D\nDDD")
    end
    
    subject { @tune }
    it { should respond_to(:content) }
    it { should respond_to(:user_id) }
    it { should respond_to(:user) }
    its(:user) { should == user }
    
    it { should be_valid }
    
    
    describe "when user_id is not present" do
      before { @tune.user_id = nil }
      it { should_not be_valid }
    end
    
    describe "accessible attributes" do
      it "should not allow access to user_id" do
        expect do
          Tune.new(:user_id => user.id)
        end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
      end
    end
    
    describe "with blank content" do
      before { @tune.content = " " }
      it { should_not be_valid }
    end
  end
  
  describe "with missing x" do
    before do
      @tune = user.tunes.build(:content => "T:No title\nM:3/4\nL:1/8\nK:D\nDDD")
      @tune.save
    end
    
    subject { @tune.content }
    
    it { should == "X:1\nT:No title\nM:3/4\nL:1/8\nK:D\nDDD" }
  end
end
