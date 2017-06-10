class StudentsController < ApplicationController
  before_filter :set_student, except: [:new, :create]

  def new
  end

  def create
  end

  def profile
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def set_student
    @student = Student.find(params[:id])
  end

  def student_params
    params.require(:student).permit(:first_name, :last_name, :email, :username,
                                    :password, :password_confirmation)

  end
end
