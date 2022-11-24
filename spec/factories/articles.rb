FactoryBot.define do
  factory :article do
    title { "test title" }
    content { "test content" }
    sequence(:slug) { |n| "sample-article#{n}" }
  end
end
