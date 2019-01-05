# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :exam do
    sequence(:sessionid) {|n| "Session#{n}"}
  end
end

