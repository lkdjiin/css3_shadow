class PagesController < ApplicationController
  def home
    @title = "#{base_title}"
  end

  def about
    @title = "#{base_title} - About"
  end

  def todo
    @title = "#{base_title} - Todo"
  end

  def app
    @title = "#{base_title} - Application"
  end

end
