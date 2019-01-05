# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :answer do
    sequence(:body) {|n| "Answer#{n}"}
    correct true
  end
end

