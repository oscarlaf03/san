json.extract! user, *User.params
json.url api_v1_user_url(user, format: :json)
