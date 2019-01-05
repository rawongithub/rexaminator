class Feedback < ActiveRecord::Base

  CATEGORIES = {
                :bug        => 'I have found a bug in this question',
                :other      => 'I just want to comment this question'
               }

  belongs_to :question

  validates_presence_of :question_id
  validates_presence_of :category
  validates_presence_of :body
  validates_presence_of :author

  attr_accessible :question_id, :category, :body, :author

  def self.category_options
    CATEGORIES.invert.sort
  end

end

