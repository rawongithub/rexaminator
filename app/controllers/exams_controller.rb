class ExamsController < ApplicationController

  before_filter :authorize, :except => [:new, :create, :start, :go, :finish, :show, :export]
  before_filter :ensure_current_exam, :except => [:index, :new, :create]

  def index
    @num_of_exams = Exam.count
    @exams = Exam.paginate(:page => params[:page], :per_page => 25, :order => 'id DESC')
    @generated_count = Exam.generated.count
    @started_count   = Exam.started.count
    @checked_count   = Exam.checked.count
    @completed_count = Exam.completed.count
  end

  def new
    @exam = Exam.new
    session[:exam] = nil
  end

  def create
    noq_from_params = params[:num_of_questions].to_i
    noq_from_params = 0 if noq_from_params < 0
    max_num_of_questions = [noq_from_params, Exam::MAX_NUM_OF_QUESTIONS].min
    @exam = Exam.new
    @exam.sessionid = session.object_id
    @exam.draw_questions(max_num_of_questions)
    respond_to do |format|
      if @exam.save
        session[:exam] = @exam.id #store exam id in session
        format.html { redirect_to(start_exam_url(@exam))}
      else
        format.html { render :action => "new" }
      end
    end
  end

  def show
    @exam = Exam.find(params[:id])
  end

  def start
    @exam = Exam.find(params[:id])
    @num_of_questions = @exam.questions.size
  end

  def go
    @exam = Exam.includes(:exam_questions => :question).find(params[:id])
    @exam.start! unless @exam.started?
    @exam_questions = @exam.exam_questions
    @questions = @exam_questions.map(&:question).paginate(:page => params[:question], :per_page => 1)
    @question = @questions.first
    @exam_question = @exam_questions.select{|eq| eq.question_id == @question.id}.first
    @exam_question.view!
    @exam_question.save(:validate => false)
    @question_number = params[:question] || "1"
    @num_of_questions = @exam_questions.size
  end

  def finish
    @exam = Exam.includes(:exam_questions => :question).find(params[:id])
    @exam.check unless @exam.checked? or @exam.completed?
    @exam.reload
    @exam_questions = @exam.exam_questions
    @exam_questions_total = @exam_questions.size
    @exam_questions_completed = @exam_questions.select{|eq| ['completed', 'completed_checked'].include?(eq.state)}.size
    @exam_questions_viewed = @exam_questions.select{|eq| ['viewed', 'viewed_checked'].include?(eq.state)}.size + @exam_questions_completed
    @exam_questions_accurate = @exam.accurate
    @exam.complete! unless @exam.completed?
  end

  def destroy
    @exam = Exam.find(params[:id])
    @exam.destroy
    redirect_to(exams_url)
  end

protected

  def ensure_current_exam
    return true if admin?
    unless Exam.find(params[:id]).id == session[:exam]
#      render :file => "#{Rails.root}/public/404.html", :status => 404
      flash[:error] = "Error: Unauthorized access. You have been redirected to home page."
      redirect_to root_url and return false
    end
    true
  end

end

