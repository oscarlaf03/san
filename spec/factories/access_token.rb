FactoryBot.define do
  factory :access_token, class: "Doorkeeper::AccessToken" do
    resource_owner_id {'some_id'}
    model_user_type {}
    application
  end
end
