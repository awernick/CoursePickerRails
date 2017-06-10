class SessionsController < ApplicationController
  before_filter :set_student

  def new
    if logged_in?(@student)
      return redirect_to @student 
    end
  end

  def create
    if @student.authenticate(params[:session][:password])
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
    @student = Student.find_by(params[:session][:username])
  end
end
