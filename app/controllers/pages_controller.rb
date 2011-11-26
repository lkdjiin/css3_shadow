class PagesController < ApplicationController
  def home
    @title = "#{base_title} - Home"
  end

  def about
    @title = "#{base_title} - About"
  end

  def help
    @title = "#{base_title} - Help"
  end

  def comments
    @title = "#{base_title} - Comments"
  end

end
