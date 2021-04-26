json.extract! user, *User.params
json.org_group user.org_group
json.url api_v1_user_url(user, format: :json)
