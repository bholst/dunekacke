require 'spec_helper'

describe "StaticPages" do
  subject { page }
  
  describe "Home page" do
    before { visit root_path }
    
    it { should have_content('Dunekacke') }
    it { should have_selector('title', :text => "Dunekacke") }
    it { should_not have_selector('title', :text => "|") }
    end
  end
  
  describe "Help page" do
    before { visit help_path }
    
    it { should have_content('Help') }
    it { should have_selector('title', :text => "Dunekacke | Help") }
  end
  
  describe "About page" do
    before { visit about_path }
    
    it { should have_content('About Dunekacke') }
    it { should have_selector('title', :text => "Dunekacke | About") }
  end
  
  describe "Contact page" do
    before { visit contact_path }

    it { should have_selector('h1', :text => 'Contact') }
    it { should have_selector('title', :text => "Dunekacke | Contact") }
    end
  end
end
