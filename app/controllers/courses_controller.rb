class CourseController < ApplicationController
  before_action :set_course, except: [:index, :new, :create]

  def index
    @course = Course.all
  end

  def show
  end

  def new
    @course = Course.new
  end

  def create
    @course = Course.new(params[:course])
    if @course.save
      redirect_to action: :index
    else
      render action: :new
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
end
