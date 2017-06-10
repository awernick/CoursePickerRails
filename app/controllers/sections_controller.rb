class SectionsController < ApplicationController
  before_filter :set_course

  def index
    @sections = @course.sections
  end

  def show
    @section = @course.sections.find(params[:id])
  end

  def new
    @section = Section.new
  end

  def create
    @section = Section.new(params[:course])
    if @section.save
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
    @course = Course.find(params[:course_id])
  end
end
