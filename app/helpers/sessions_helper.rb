module SessionsHelper
  def login(student)
    session[:student_id] = student.id
  end

  def logout(student)
    session.delete(:student_id)
    @current_user = nil
  end

  def logged_in?(student = nil)
    if student.present?
      # Check if the student is logged in
      return session[:student_id] == student.id
    else
      # Check if any student is logged in
      return !session[:student_id].nil?
    end
  end

  def current_student
    @current_student ||= Student.find(session[:student_id])
  end
end
