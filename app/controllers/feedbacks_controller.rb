class FeedbacksController < ApplicationController

  before_filter :session_expiry
  before_filter :authorize, :except => [:create]

  def index
    @feedbacks = Feedback.order('created_at DESC')
  end

  def create
    @feedback = Feedback.new(params[:feedback])
    respond_to do |format|
      if @feedback.save
        flash[:notice] = "Your feedback has been successfully sent. Thank You."
        format.html {redirect_to review_exam_question_path(:id => params[:exam_question_id], :order_number => params[:order_number])}
        format.js
      else
        format.html do
          redirect_to review_exam_question_path(:id => params[:exam_question_id], :order_number => params[:order_number])
        end
        format.js {render :action => :error}
      end
    end

  end

  def edit
    @feedback = Feedback.find(params[:id])
  end

  def update
    @feedback = Feedback.find(params[:id])
    respond_to do |format|
      if @feedback.update_attributes(params[:feedback])
        flash[:notice] = 'Feedback was successfully updated.'
        format.html { redirect_to feedbacks_url }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def show
    @feedback = Feedback.find(params[:id])
    respond_to do |format|
      format.html
    end
  end

  def destroy
    @feedback = Feedback.find(params[:id])
    @feedback.destroy

    respond_to do |format|
      format.html { redirect_to(feedbacks_url) }
    end
  end

end

