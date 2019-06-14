FactoryBot.define do
  factory :fp_ng_time_frame do
    association :user, factory: :user

    trait :set_weekday_time_frame do
      # transient do
      #   time_frame_id 1
      # end
      time_frame_id { 1 }
      is_weekday { true }
      is_holiday { false }
    end

    trait :set_holiday_time_frame do
      # transient do
      #   time_frame 1
      # end
      time_frame_id { 1 }
      is_weekday { false }
      is_holiday { true }
    end
  end
end
