FactoryGirl.define do
  factory :question do
    sequence(:body) {|n| "Question#{n}"}
    active true
  end
end

