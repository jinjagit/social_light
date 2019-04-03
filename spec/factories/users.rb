FactoryBot.define do
  factory :user, aliases: [:creator] do
    sequence(:name) { |n| "John Example#{n}" }
  end
end
