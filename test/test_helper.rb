ENV["RAILS_ENV"] = "test"
#require 'simplecov'
#SimpleCov.start 'rails'
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
require 'rails/test_help'
require 'capybara/rails'
class ActionDispatch::IntegrationTest
  include Capybara::DSL
  Capybara.app = Rexaminator::Application
  Capybara.default_driver = :selenium
  Capybara.default_wait_time = 5
  Capybara.register_driver :selenium do |app|
    Capybara::Selenium::Driver.new(app, :browser => :chrome)
  end
end

require "minitest/reporters"
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require 'database_cleaner'
DatabaseCleaner.strategy = :truncation

class ActiveSupport::TestCase
  # Transactional fixtures accelerate your tests by wrapping each test method
  # in a transaction that's rolled back on completion.  This ensures that the
  # test database remains unchanged so your fixtures don't have to be reloaded
  # between every test method.  Fewer database queries means faster tests.
  #
  # Read Mike Clark's excellent walkthrough at
  #   http://clarkware.com/cgi/blosxom/2005/10/24#Rails10FastTesting
  #
  # Every Active Record database supports transactions except MyISAM tables
  # in MySQL.  Turn off transactional fixtures in this case; however, if you
  # don't care one way or the other, switching from MyISAM to InnoDB tables
  # is recommended.
  #
  # The only drawback to using transactional fixtures is when you actually
  # need to test transactions.  Since your test is bracketed by a transaction,
  # any transactions started in your code will be automatically rolled back.
  self.use_transactional_fixtures = false

  # Instantiated fixtures are slow, but give you @david where otherwise you
  # would need people(:david).  If you don't want to migrate your existing
  # test cases which use the @david style and don't mind the speed hit (each
  # instantiated fixtures translates to a database query per test method),
  # then set this back to true.
#  self.use_instantiated_fixtures  = false

  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
#  fixtures :all

  # Add more helper methods to be used by all tests here...
  def login_admin
    visit("/admin")
    assert "/login", current_path
    fill_in('login', :with => "admin")
    fill_in('password', :with => "secret")
    click_on('Login')
    assert_equal "/admin", current_path
  end

  def authorize_admin
    @controller.stubs(:admin?).returns(true)
  end

  def question_from_factory(answers=[true, true, true, true])
    q = FactoryGirl.build(:question)
    q.save!(:validate => false)
    answers.each do |a|
      q.answers << FactoryGirl.create(:answer, :question => q, :correct => a)
    end
    q.categories = [FactoryGirl.create(:category, :questions => [q])]
    q.save!
    q
  end

end

require 'mocha/setup'
