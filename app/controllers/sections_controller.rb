class SectionsController < ApplicationController
  include SessionsHelper

  before_filter :authenticate_student, only: [:enroll, :drop]
  before_filter :set_course
  before_filter :set_section, except: [:index, :new, :create]

  def index
    if @course.present?
      @sections = @course.sections
    else
      @sections = Section.all
    end

    respond_to do |format|
      format.json { render json: @sections }
      format.html
    end
  end

  def show
    respond_to do |format|
      format.json { render json: @section }
      format.html
    end
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
    @enrollment = Enrollment.new(student: current_student, section: @section)
    if not @enrollment.save
      flash[:danger] = "You are already enrolled!"
    end
    
    # Should probably redirect to referrer
    flash[:success] = "You have succesfully enrolled for the course!"
    redirect_to request.referrer
  end

  def drop
    if @section.students.exists?(current_student)
      # Destroy Section - Student association to drop
      @enrollment = @section.enrollments.find_by(student: current_student)
      @enrollment.destroy
      flash[:info] = "You have dropped the course"
    else
      flash[:danger] = "There was an error. Please try again later."
    end

    redirect_to request.referrer
  end

  private 

  def set_course
    if params.has_key? :course_id
      @course = Course.find(params[:course_id])
    end
  end

  def set_section
    if @course.present?
      @section = @course.sections.find_by(uuid: params[:uuid])
    else
      @section = Section.find_by(uuid: params[:uuid])
    end
  end

  def authenticate_student
    unless logged_in?
      # FLASH ERROR
      redirect_to login_path
    end
  end

  # NOTE: UUID is not assignable
  def section_params
    params.require(:section).permit(:course_id, :date, :time)
  end
end
