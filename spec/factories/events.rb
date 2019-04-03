FactoryBot.define do
  factory :event do
    title "Example Title"
    info "Example info"
    location "Example location"
    date Time.now
    association :creator
  end
end
