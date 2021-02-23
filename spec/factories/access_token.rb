FactoryBot.define do
  factory :access_token, class: "Doorkeeper::AccessToken" do
    resource_owner_id {'some_id'}
    application
  end
end
