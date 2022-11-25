FactoryBot.define do
  factory :article do
    title { "test title" }
    content { "test content" }
    sequence(:slug) { |n| "#{n}" }
  end
end
