require 'spec_helper'

describe "LayoutLinks" do

  it "should have a Home page at '/'" do
    get '/'
    response.should have_selector('title', content: "#{@base_title}")
  end
  
  it "should have the right links on the layout" do
    visit root_path
    
    click_link "home"
    response.should have_selector('title', content: "#{@base_title}")
    
    click_link "about"
    response.should have_selector('title', content: "#{@base_title} - About")
    
    click_link "app"
    response.should have_selector('title', content: "#{@base_title} - Application")

    click_link "comments"
    response.should have_selector('title', content: "#{@base_title} - Comments")
  end
end
