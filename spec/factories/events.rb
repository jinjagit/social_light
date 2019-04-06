FactoryBot.define do
  factory :event do
    title "Example Title"
    info "Example info"
    location "Example location"
    date 1.week.from_now
    association :creator
  end
end
