require 'chronic'
require 'ostruct'

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

    @sections = apply_filters(@sections)
    @sections = apply_sorting(@sections)

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

  def apply_filters(sections)
    # Create an object that will store all 
    # of our values. This will make it
    # easy to access values in the front end
    @filters = OpenStruct.new({
      page: params[:page],
      per_page: params[:per_page],
      days: params[:days] || [],
      start_time: params[:start_time],
      end_time: params[:end_time],
      professor: params[:professor],
    })

    # Display filtered days
    if @filters.days.present?
      days = @filters.days.map {|d| Section::DAYS.keys[d.to_i] }
      sections = sections.with_days(*days)
    end

    # Display classes later or starting at the the start time
    if @filters.start_time.present?
      start_time = Chronic.parse(@filters.start_time).strftime("%I:%M%p")
      sections = sections.where("start_time >= ?", start_time)
    end

    # Display classes earlier or ending at end_time
    if @filters.end_time.present?
      end_time = Chronic.parse(@filters.end_time).strftime("%I:%M%p")
      sections = sections.where("end_time <= ?", end_time)
    end

    # Try to find the professor by last name or first name
    # TODO: Search by both properties and not either or.
    if @filters.professor.present?
      sections = sections.joins(:professor).where(
        'professors.first_name LIKE ? OR ' \
        'professors.last_name LIKE ?', 
        "%#{@filters.professor}", 
        "%#{@filters.professor}"
      )
    end

    sections = sections.paginate({
      page: @filters.page,
      per_page: @filters.per_page
    })

    return sections
  end

  def apply_sorting(sections)
    @sorting ||= OpenStruct.new({
      column: params[:sort_column],
      direction: params[:direction]
    })
  
    if @sorting.column.present?
      sections = sections.joins(:professor) if @sorting.column.include? "professor"
      return sections.order("#{@sorting.column} #{@sorting.direction}")
    else
      return sections
    end
  end

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
      flash[:info] = "Please login to proceed with the previous action"
      redirect_to login_path
    end
  end

  # NOTE: UUID is not assignable
  def section_params
    params.require(:section).permit(:course_id, :date, :time)
  end
end
