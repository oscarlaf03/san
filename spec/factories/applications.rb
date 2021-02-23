FactoryBot.define do 
  factory :application, class: "Doorkeeper::Application" do
    # name {Faker::Games::Pokemon.name }
    name {'test_app_for_rspec'}
  end
end
