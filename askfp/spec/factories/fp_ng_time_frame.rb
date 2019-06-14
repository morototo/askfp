FactoryBot.define do
  factory :fp_ng_time_frame do
    association :user, factory: :user

    trait :set_weekday_time_frame do
      ignore do
        time_frame_id 1
      end
      time_frame_id { time_frame_id }
      is_weekday { true }
      is_holiday { false }
    end

    trait :set_holiday_time_frame do
      ignore do
        time_frame_id 1
      end
      time_frame_id { time_frame_id }
      is_weekday { false }
      is_holiday { true }
    end
  end
end
