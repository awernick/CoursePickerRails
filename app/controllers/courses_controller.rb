class CoursesController < ApplicationController
  before_action :set_course, except: [:index, :new, :create]

  def index
    @courses = Course.all

    respond_to do |format|
      format.json { render json: @courses }
      format.html
    end
  end

  def show
    respond_to do |format|
      format.html
      format.json { render json: @course }
    end
  end

  def new
    @course = Course.new
  end

  def create
    @course = Course.new(course_params)
    if @course.save
      respond_to do |format|
        format.json { render json: @course }
        format.html { redirect_to action: :index }
      end
    else
      respond_to do |format|
        format.json { render json: @course.errors.full_messages }
        format.html { render action: :new }
      end
    end
  end

  def edit

  end

  def update

  end

  def destroy

  end

  private

  def set_course
    @course = Course.find(params[:id])
  end

  def course_params
    params.require(:course).permit(:name, :description, :cost)
  end
end
