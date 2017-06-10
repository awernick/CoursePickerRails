class SectionsController < ApplicationController
  before_filter :set_course

  def index
    @sections = @course.sections
  end

  def show
    @section = @course.sections.find(params[:id])
  end

  def new
    @section = @course.sections.build
  end

  def create
    @section = @course.sections.build(section_params)
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

  def enroll
    @section = @course.sections.find(params[:id])
    @student = Student.find(params[:user_id])
    @enrollment = Enrollment.new(student: @student, section: @section)
    if not @enrollment.save
      # ERROR
    end

    redirect_to action: :index
  end

  private 

  def set_course
    @course = Course.find(params[:course_id])
  end

  def section_params
    params.require(:section).permit(:course_id, :date, :time)
  end
end
