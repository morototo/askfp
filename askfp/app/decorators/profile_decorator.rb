class ProfileDecorator < Draper::Decorator
  delegate_all
  def name
    if object.name.present?
      "#{object.name}"
    else
      "未設定"
    end
  end
  def self_introduction
    if object.self_introduction.present?
      "#{object.self_introduction}"
    else
      "-"
    end
  end
end
