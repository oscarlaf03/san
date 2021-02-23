module SpecTestHelper

  def auth_headers(user=nil)
    user ||= FactoryBot.create(:user)
    access_token = FactoryBot.create(:access_token,resource_owner_id: user.id )
    {'Authorization': "Bearer #{access_token.token}"}
  end

end
