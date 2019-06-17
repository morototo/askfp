FactoryBot.define do
  factory :profile do
    association :user, factory: :user
    name { "TEST" }
    self_introduction { "宜しくお願いいたします。"}
  end
end
