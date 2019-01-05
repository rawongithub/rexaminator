class QuestionsController < ApplicationController

  NUM_ANSWERS = 4

  before_filter :session_expiry
  before_filter :authorize

  # GET /questions
  def index
    @num_of_questions = Question.count
    @questions = Question.paginate(:page => params[:page], :per_page => 20, :order => 'id DESC')
    @active_count = Question.active.count
    @inactive_count = Question.inactive.count
  end

  # GET /questions/1
  def show
    @question = Question.find(params[:id])
    @categories = @question.categories.sort{|a,b| a.name <=> b.name}

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /questions/new
  def new
    @question = Question.new
    @categories = Category.order(:name)
    NUM_ANSWERS.times{@question.answers.build}

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /questions/1/edit
  def edit
    @question = Question.find(params[:id])
    @categories = Category.order(:name)

  end

  # POST /questions
  def create
    @question = Question.new
    @question.accessible = :all if admin?
    @question.attributes = params[:question]
    @categories = Category.order(:name)
    respond_to do |format|
      if @question.save
        flash[:notice] = 'Question has been successfully created.'
        format.html { redirect_to(@question) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /questions/1
  def update
    params[:question][:category_ids] ||= []
    @question = Question.find(params[:id])
    @question.accessible = :all if admin?
    @question.attributes = params[:question]
    @categories = Category.order(:name)

    respond_to do |format|
      if @question.valid? && @question.answers.all?(&:valid?)
        @question.save!
        @question.answers.each(&:save!)
        flash[:notice] = 'Question has been successfully updated.'
        format.html { redirect_to(@question) }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /questions/1
  def destroy
    @question = Question.find(params[:id])
    @question.destroy

    respond_to do |format|
      format.html { redirect_to(questions_url) }
    end
  end

end

