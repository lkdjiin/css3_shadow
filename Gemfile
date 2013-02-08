source 'http://rubygems.org'

gem 'rails', '3.1.10'
gem 'jquery-rails'
gem 'haml', '3.1.3'

group :production do
  gem 'pg'
end

group :development, :test do
  gem 'sqlite3'
  gem 'rspec-rails', '2.7.0'
end

group :development do
  gem 'annotate', :git => 'git://github.com/ctran/annotate_models.git'
end

group :test do
  gem 'webrat', '0.7.3'
  gem 'coco', '0.6'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.1.5'
  gem 'coffee-rails', '~> 3.1.1'
  gem 'uglifier', '>= 1.0.3'
end


