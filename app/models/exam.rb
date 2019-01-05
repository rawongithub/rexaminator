class Exam < ActiveRecord::Base

  # minimum and maximum numbers of question for exam
  MIN_NUM_OF_QUESTIONS = 1
  MAX_NUM_OF_QUESTIONS = 30

  include ActiveRecord::Transitions

  has_many :exam_questions, :dependent => :destroy, :order => 'question_id ASC'
  has_many :questions, :through => :exam_questions, :order => 'questions.id ASC'

  validates_presence_of :sessionid
  validate :number_of_questions_should_be_in_valid_range

  scope :generated, where(:state => 'generated')
  scope :started,   where(:state => 'started')
  scope :checked,   where(:state => 'checked')
  scope :completed, where(:state => 'completed')

  state_machine do
    state :generated
    state :started
    state :checked
    state :completed, :enter => [:complete_exam]

    event :start do
      transitions :from => [:generated], :to => :started
    end

    event :check do
      transitions :from => [:started], :to => :checked
    end

    event :complete do
      transitions :from => [:checked], :to => :completed
    end
  end

  def draw_questions(max_num_of_questions)
    self.questions = Question.active.order('Random()').limit(max_num_of_questions)
  end

  def complete_exam
    self.update_attribute(:completed_at, Time.now)
  end

  def number_of_questions_should_be_in_valid_range
    unless self.questions.size.between?(MIN_NUM_OF_QUESTIONS, MAX_NUM_OF_QUESTIONS)
      errors.add(:num_of_questions, "should be greater or equal than #{MIN_NUM_OF_QUESTIONS} and less or equal than #{MAX_NUM_OF_QUESTIONS}")
    end
  end

  def exam_questions_answers(question_id)
    eq = ExamQuestion.where(:exam_id => self.id, :question_id => question_id).first
    return [eq.answer1, eq.answer2, eq.answer3, eq.answer4]
  end

  def check
    self.questions.each do |question|
      eq = ExamQuestion.where(:exam_id => self.id, :question_id =>  question.id).first
      eq.check! if eq.update_attribute(:accurate, question.accurate?(exam_questions_answers(question.id)))
    end
    self.check!
  end

  def accurate
    ExamQuestion.where(:exam_id => self.id, :accurate => true).count
  end

  def score
    all = self.questions.size
    (self.accurate.to_f / all) * 100
  end

  def questions_states
    states = {}
    exam_questions = ExamQuestion.where(:exam_id => self.id).order(:question_id)
    exam_questions.each_with_index do |exam_question, index|
      states[index+1] = exam_question.state
    end
    states
  end

end

