class CategoriesController < ApplicationController

  before_filter :session_expiry
  before_filter :authorize

  # GET /categories
  def index
    @categories = Category.order(:name)

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /categories/1
  def show
    @category = Category.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /categories/new
  def new
    @category = Category.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /categories/1/edit
  def edit
    @category = Category.find(params[:id])
  end

  # POST /categories
  def create
    @category = Category.new
    @category.accessible = :all if admin?
    @category.attributes = params[:category]

    respond_to do |format|
      if @category.save
        flash[:notice] = 'Category was successfully created.'
        format.html { redirect_to categories_url }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /categories/1
  def update
    @category = Category.find(params[:id])
    @category.accessible = :all if admin?

    respond_to do |format|
      if @category.update_attributes(params[:category])
        flash[:notice] = 'Category was successfully updated.'
        format.html { redirect_to categories_url }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /categories/1
  def destroy
    @category = Category.find(params[:id])
    @category.destroy

    respond_to do |format|
      format.html { redirect_to(categories_url) }
    end
  end
end

