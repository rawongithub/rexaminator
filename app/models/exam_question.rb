class ExamQuestion < ActiveRecord::Base

  include ActiveRecord::Transitions

  belongs_to :question
  belongs_to :exam

  attr_accessible :exam_id, :question_id, :answer1, :answer2, :answer3, :answer4

  state_machine do
    state :loaded
    state :viewed
    state :completed
    state :loaded_checked
    state :viewed_checked
    state :completed_checked

    event :view do
      transitions :from => [:loaded, :viewed],               :to => :viewed
      transitions :from => [:completed],                     :to => :completed
    end

    event :complete do
      transitions :from => [:loaded, :viewed, :completed],   :to => :completed
    end

    event :check do
      transitions :from => [:loaded, :loaded_checked],       :to => :loaded_checked
      transitions :from => [:viewed, :viewed_checked],       :to => :viewed_checked
      transitions :from => [:completed, :completed_checked], :to => :completed_checked
    end

    event :reset do
      transitions :from => [:loaded, :viewed, :completed],   :to => :viewed
    end
  end

  def accurate?(words = {:true => 'correct', :false => 'incorrect', :nil => 'unknown'})
    return words[:nil] if self.accurate.nil?
    self.accurate ? words[:true] : words[:false]
  end

end

