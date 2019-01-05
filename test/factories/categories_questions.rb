FactoryGirl.define do
  factory :category_question do
    association :category
    association :question
  end
end

