require 'spec_helper'

describe "Tune Pages" do
  subject { page }
  
  let(:user) { FactoryGirl.create(:user) }
  let!(:t1) { FactoryGirl.create(:tune, :user => user, :content => "X:1\nT:Foo\nM:3/4\nL:1/8\nK:D\nDDD") }
  let!(:t2) { FactoryGirl.create(:tune, :user => user, :content => "X:1\nT:Bar\nM:3/4\nL:1/8\nK:D\nDDD") }

  before do
    sign_in user
  end
  
  describe "links" do
    before do
      visit root_path
    end
    
    it { should have_link('Tunes', :href => tunes_path) }
  end
  
  describe "index" do
    before(:each) do
      sign_in user
      visit tunes_path
    end
    
    it { should have_selector('title', :text => 'All tunes') }
    it { should have_selector('h1',    :text => 'All tunes') }
    
    describe "tunes" do
      it { should have_link("Foo", :href => tune_path(t1)) }
      it { should have_link("Bar", :href => tune_path(t2)) }
    end
  end
  
  describe "tune page" do
    before do
      visit tune_path(t1)
    end
    
    it { should have_selector('title', :text => 'Foo') }
    it { should have_selector('h1',    :text => 'Foo') }
  end
  
  describe "add" do
    before { visit new_tune_path }
    
    let(:submit) { "Save tune" }
    
    describe "with invalid information" do
      it "should not create a tune" do
        expect { click_button submit }.not_to change(Tune, :count)
      end
    end
    
    describe "with valid information" do
      let(:abc) { "X:1\nT:Foo\nM:3/4\nL:1/4\nK:D\nDDD" }
      before do
        fill_in "Put your ABC here:",     :with => abc
      end
      
      it "should create a tune" do
        expect { click_button submit }.to change(Tune, :count).by(1)
      end
      
      describe "after saving the tune" do
        before do
          click_button submit
        end
        
        it { should have_selector('title', :text => 'Foo') }
      end
    end
  end
end
