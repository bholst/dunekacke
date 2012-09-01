require 'spec_helper'

describe "StaticPages" do
  describe "Home page" do
    it "should have the content 'Dunekacke'" do
      visit root_path
      page.should have_content('Dunekacke')
    end
    
    it "should have the right title" do
      visit root_path
      page.should have_selector('title', :text => "Dunekacke")
    end
    
    it "should not have a custom page title" do
      visit root_path
      page.should_not have_selector('title', :text => "|")
    end
  end
  
  describe "Help page" do
    it "should have the content 'Help'" do
      visit help_path
      page.should have_content('Help')
    end
    
    it "should have the right title" do
      visit help_path
      page.should have_selector('title', :text => "Dunekacke | Help")
    end
  end
  
  describe "About page" do
    it "should have the content 'About Dunekacke'" do
      visit about_path
      page.should have_content('About Dunekacke')
    end
    
    it "should have the right title" do
      visit about_path
      page.should have_selector('title', :text => "Dunekacke | About")
    end
  end
  
  describe "Contact page" do

    it "should have the h1 'Contact'" do
      visit contact_path
      page.should have_selector('h1', :text => 'Contact')
    end

    it "should have the title 'Contact'" do
      visit contact_path
      page.should have_selector('title', :text => "Dunekacke | Contact")
    end
  end
end
