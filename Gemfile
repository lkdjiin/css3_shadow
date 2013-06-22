source 'http://rubygems.org'
ruby '1.9.3'

gem 'rails', '3.2.13'
# This version of jquery-rails contains jquery-ui. Greater versions have
# removed that.
gem 'jquery-rails', '2.3.0'
gem 'haml-rails'
gem 'thin'

group :production do
  gem 'pg'
end

group :development, :test do
  gem 'sqlite3'
  gem 'rspec-rails', '2.8.1'
  gem "jasminerice", :git => 'https://github.com/bradphelan/jasminerice.git'
end

group :development do
  gem 'annotate'
end

group :test do
  gem 'webrat', '0.7.3'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end


