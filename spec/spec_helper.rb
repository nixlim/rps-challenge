ENV['RACK_ENV'] = 'test'
require 'simplecov'
require 'simplecov-console'
require 'rspec'
require 'capybara/rspec'
require './app/rpc'
require './spec/features/web_helper.rb'
Capybara.app = RPC

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new([
  SimpleCov::Formatter::Console,
  # Want a nice code coverage website? Uncomment this next line!
  # SimpleCov::Formatter::HTMLFormatter
])
SimpleCov.start

RSpec.configure do |config|
  config.after(:suite) do
    puts
    puts "\e[33mHave you considered running rubocop? It will help you improve your code!\e[0m"
    puts "\e[33mTry it now! Just run: rubocop\e[0m"
  end
end
