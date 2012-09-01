require 'spec_helper'

describe "StaticPages" do
  describe "Home page" do
    it "should have the content 'Dunekacke'" do
      visit '/static_pages/home'
      page.should have_content('Dunekacke')
    end
    
    it "should have the right title" do
      visit '/static_pages/home'
      page.should have_selector('title', :text => "Dunekacke | Home")
    end
  end
  
  describe "Help page" do
    it "should have the content 'Help'" do
      visit '/static_pages/help'
      page.should have_content('Help')
    end
    
    it "should have the right title" do
      visit '/static_pages/help'
      page.should have_selector('title', :text => "Dunekacke | Help")
    end
  end
  
  describe "About page" do
    it "should have the content 'About Dunekacke'" do
      visit '/static_pages/about'
      page.should have_content('About Dunekacke')
    end
    
    it "should have the right title" do
      visit '/static_pages/about'
      page.should have_selector('title', :text => "Dunekacke | About")
    end
  end
end
