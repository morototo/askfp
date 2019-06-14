FactoryBot.define do
  factory :user do
    sequence(:email) { |i| "test#{i}@example.com" }

    trait :guest do
      user_type { "guest" }
    end

    trait :fp do
      user_type { "fp" }
    end

    after(:create) do |user|
      user.profile = create(:profile, user: user)
      user.fp_ng_time_frames = create(:fp_ng_time_frame, user: user)
    end
  end
end
