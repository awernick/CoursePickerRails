class SessionsController < ApplicationController
  include SessionsHelper

  before_filter :set_student, only: :create

  def new
    if logged_in?
      return redirect_to current_user
    end
  end

  def create
    if @student && @student.authenticate(params[:session][:password])
      login(@student)
      redirect_to @student
    else
      # FLASH ERROR 
      render :new
    end
  end

  def destroy
    logout(@student)
    redirect_to root_path
  end

  private

  def set_student
    @student = Student.find_by(username: params[:session][:username])
  end
end
