FactoryGirl.define do
  factory :project do
    sequence(:name) { |n| "Project #{n}" }
    description "des bla bla bla"
    user
  end
end
