require 'test_helper'

class CategoryTest < ActiveSupport::TestCase

  context "Category" do

    setup do
      FactoryGirl.build(:category)
    end

    context "associations" do
      should have_and_belong_to_many(:questions)
    end

    context "validations" do
      should validate_presence_of :name
      should validate_uniqueness_of :name
    end


  end

end

