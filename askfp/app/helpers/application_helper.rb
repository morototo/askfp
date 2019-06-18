module ApplicationHelper
  def registration_title(user_type)
    user_type == "guest" ? "ユーザ新規登録" : "FP新規登録"
  end
end
