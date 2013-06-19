require 'spec_helper'

describe PagesController do
  render_views
  
  before :all do
    @base_title = "CSS3 Drop Shadows Generator"
  end

  describe "GET 'home'" do
    it "returns http success" do
      get 'home'
      response.should be_success
    end
    
    it "should have the right title" do
      get 'home'
      response.should have_selector("title", :content => "#{@base_title}")
    end
  end

  describe "GET 'about'" do
    it "returns http success" do
      get 'about'
      response.should be_success
    end
    
    it "should have the right title" do
      get 'about'
      response.should have_selector("title", :content => "#{@base_title} - About")
    end
  end

  describe "GET 'app'" do
    it "returns http success" do
      get 'app'
      response.should be_success
    end
    
    it "should have the right title" do
      get 'app'
      response.should have_selector("title", :content => "#{@base_title} - Application")
    end
  end

  describe "GET 'comments'" do
    it "returns http success" do
      get 'comments'
      response.should be_success
    end
    
    it "should have the right title" do
      get 'comments'
      response.should have_selector("title", :content => "#{@base_title} - Comments")
    end
  end

end
