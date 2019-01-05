class Question < ActiveRecord::Base

  has_many :answers, :dependent => :destroy, :order => 'id ASC'
  has_many :exam_questions, :dependent => :destroy
  has_many :exams, :through => :exam_questions
  has_and_belongs_to_many :categories, :uniq => true
  has_many :feedbacks, :dependent => :destroy, :order => 'created_at DESC'

  validates_presence_of :body
  validates_associated :answers, :on => :update
  validate :min_one_category
  validate :min_one_correct_answer
  validate :must_have_four_answers

  accepts_nested_attributes_for :answers

  scope :active,   where(:active => true)
  scope :inactive, where(:active => false)

  def min_one_category
    errors.add(:base, 'Minimum one category is needed') if self.categories.empty?
  end
  def min_one_correct_answer
    errors.add(:base, 'Minimum one correct answer is needed') unless self.answers.any?{|a| a.correct }
  end
  def must_have_four_answers
    errors.add(:base, 'Need to have 4 answers') unless self.answers.size == 4
  end

  #check if question is accurate (all answers must be accurate)
  #params[:bools] is an Array of booleans ordered ascendant by id
  def accurate?(bools)
    self.answers.map(&:correct) == bools
  end

end

