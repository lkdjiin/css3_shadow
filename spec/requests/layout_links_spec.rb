require 'spec_helper'

describe "LayoutLinks" do

  it "should have a Home page at '/'" do
    get '/'
    response.should have_selector('title', content: "Home")
  end
  
  it "should have the right links on the layout" do
    visit root_path
    
    click_link "home"
    response.should have_selector('title', content: "Home")
    
    click_link "about"
    response.should have_selector('title', content: "Home")
    
    click_link "todo"
    response.should have_selector('title', content: "Home")
  end
end
