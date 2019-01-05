class Answer < ActiveRecord::Base

  belongs_to :question

  validates :body, :presence => true

  attr_accessible :body, :correct, :question_id

  def accurate?(bool)
    self.correct == bool
  end

end

