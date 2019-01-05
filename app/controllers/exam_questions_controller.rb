class ExamQuestionsController < ApplicationController

  def update
    @exam_question = ExamQuestion.find(params[:id])
    @exam_question.attributes = params[:exam_question]
    unless @exam_question.attributes.has_value?(true)
      @exam_question.reset!
    else
      @exam_question.complete!
    end
    success = @exam_question.save
    respond_to do |format|
      format.html do
        unless request.xhr?
          success ? flash[:notice] = 'Question was successfully updated.' : flash[:error] = 'Question not updated.'
          redirect_to go_exam_path(@exam_question.exam)
        else
          render :nothing => true
        end
      end
      format.js do
        render
      end
    end
  end

  def review
    @exam = Exam.find(session[:exam])
    @exam_question = @exam.exam_questions.find(params[:id])
    @question = Question.find(@exam_question.question_id)
    @order_number = params[:order_number]
    @feedback = Feedback.new(:question_id => @question.id)
    @feedback_category_options = Feedback.category_options
  end

end

