source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


gem 'rails', '~> 5.0.2'
gem 'pg', '~> 0.20'
gem 'puma', '~> 3.0'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
gem 'bcrypt', '~> 3.1.7'
gem 'doorkeeper'
gem 'jsonapi-resources'
# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

gem 'rack-cors'
gem 'carrierwave', '~> 1.1'
gem 'mini_magick'
gem 'carrierwave-base64', '~> 2.5', '>= 2.5.2'
gem 'file_validators', '~> 2.1'

group :development, :test do
  gem 'byebug', platform: :mri
end

group :development do
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :development, :test do
  gem 'rspec-rails', '~> 3.5'
  gem 'factory_girl_rails'
  gem 'rspec_api_documentation', '4.9'
  gem 'apitome'
end

group :test do
  gem 'shoulda-matchers', git: 'https://github.com/thoughtbot/shoulda-matchers.git', branch: 'rails-5'
end
