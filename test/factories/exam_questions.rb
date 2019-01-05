# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :exam_question do
    answer1 :false
    answer2 :true
    answer3 :false
    answer4 :false
    state   :loaded
  end
end

