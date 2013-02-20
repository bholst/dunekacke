require 'spec_helper'

describe TuneRating do
  let(:user) { FactoryGirl.create(:user) }
  let(:tune) { FactoryGirl.create(:tune) }
  
  describe "proper rating" do
    before do
      @rating = TuneRating.new
      @rating.user_id = user.id
      @rating.tune_id = tune.id
      @rating.value   = 3
    end
    
    subject { @rating }
    it { should respond_to(:user_id) }
    it { should respond_to(:tune_id) }
    it { should respond_to(:value) }
    it { should respond_to(:user) }
    its(:user) { should == user }
    it { should respond_to(:tune) }
    its(:tune) { should == tune }
    
    it { should be_valid }
    
    describe "when value is too small" do
      before { @rating.value = -1 }
      it { should_not be_valid }
    end
    
    describe "when value is too large" do
      before { @rating.value = 6 }
      it { should_not be_valid }
    end
    
    describe "when value is no integer" do
      before { @rating.value = 1.5 }
      it { should_not be_valid }
    end
    
    describe "when user_id is not present" do
      before { @rating.user_id = nil }
      it { should_not be_valid }
    end
    
    describe "when tune_id is not present" do
      before { @rating.tune_id = nil }
      it { should_not be_valid }
    end
    
    describe "trying to create another rating" do
      before do
        @rating.save
        @other = TuneRating.new
        @other.user_id = user.id
        @other.tune_id = tune.id
        @other.value   = 3
      end
      
      subject { @other }
      
      describe "with the same tune and user id" do
        it { should_not be_valid }
      end
      
      describe "with a different tune" do
        let(:other_tune) { FactoryGirl.create(:tune) }
        before { @other.tune_id = other_tune.id }
        
        it { should be_valid }
      end
      
      describe "with a different user" do
        let(:other_user) { FactoryGirl.create(:user) }
        before { @other.user_id = other_user.id }
        
        it { should be_valid }
      end
    end
    
    describe "accessible attributes" do
      it "should not allow access to user_id" do
        expect do
          TuneRating.new(:user_id => user.id)
        end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
      end
      
      it "should not allow access to tune_id" do
        expect do
          TuneRating.new(:tune_id => tune.id)
        end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
      end
    end
  end
end
