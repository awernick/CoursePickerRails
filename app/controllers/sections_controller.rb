class SectionsController < ApplicationController
  before_filter :set_course, except: [:new, :create]
  before_filter :set_section, except: [:index, :new, :create]

  def index
  end

  def show
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
    @student = Student.find(params[:user_id])

    # Make sure the Student trying to enroll
    # is the same as the logged in user
    unless logged_in? @student
      # FLASH ERROR
      return redirect_to action: :index
    end

    @enrollment = Enrollment.new(student: @student, section: @section)
    if not @enrollment.save
      # FLASH ERROR
    end

    # Should probably redirect to referrer
    redirect_to action: :index
  end

  def drop
    if @section.students.exists?(current_student)
      # Destroy Section - Student association to drop
      @enrollment = @section.enrollments.find_by(student: current_student)
      @enrollment.destroy
    else
      # FLASH ERROR
    end

    # Should probably redirect to referrer
    redirect_to action: :index
  end

  private 

  def set_course
    if params.has_key? :course_id
      @course = Course.find(params[:course_id])
    end
  end

  def set_section
    if @course.present?
      @section = @course.sections.find_by(uuid: params[:id])
    else
      @section = Section.find_by(uuid: params[:id])
    end
  end

  # NOTE: UUID is not assignable
  def section_params
    params.require(:section).permit(:course_id, :date, :time)
  end
end
