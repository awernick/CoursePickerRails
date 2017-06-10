class CoursesController < ApplicationController
  before_action :set_course, except: [:index, :new, :create]

  def index
    @courses = Course.all
    @courses = apply_filters(@courses)
    @courses = apply_sorting(@courses)

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

  def apply_filters(courses)
    # Create an object that will store all 
    # of our values. This will make it
    # easy to access values in the front end
    @filters = OpenStruct.new({
      page: params[:page],
      per_page: params[:per_page],
    })

    courses = courses.paginate({
      page: @filters.page,
      per_page: @filters.per_page
    })

    return courses
  end

  def apply_sorting(courses)
    @sorting ||= OpenStruct.new({
      column: params[:sort_column],
      direction: params[:direction]
    })
 
    if @sorting.column.present? and Course.new.respond_to? @sorting.column
      return courses.order("#{@sorting.column} #{@sorting.direction}")
    else
      return courses
    end
  end

  def set_course
    @course = Course.find(params[:id])
  end

  def course_params
    params.require(:course).permit(:name, :description, :cost)
  end
end
