module SessionsHelper
  def log_in(student)
    session[:student_id] = student.id
  end

  def logout(student)
    session[:student_id].destroy
    @current_user = nil
  end

  def logged_in?(student)
    student && session[:student_id] == student.id
  end

  def current_student
    @current_student ||= Student.find(session[:student_id])
  end
end
