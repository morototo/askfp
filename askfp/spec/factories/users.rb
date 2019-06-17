FactoryBot.define do
  factory :user do
    sequence(:email) { |i| "test#{i}@example.com" }
    password {'password'}

    trait :guest do
      user_type { "guest" }
    end

    trait :fp do
      user_type { "fp" }
    end

    after(:create) do |user|
      user.profile = create(:profile, user: user)
    end
  end
end
