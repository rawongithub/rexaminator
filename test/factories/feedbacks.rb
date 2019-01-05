# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :feedback do
    active   true
    category 'opinion'
    body     'I like this question'
    author   'tester'
  end
end

