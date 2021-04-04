# app/controllers/custom_tokens_controller.rb
class CustomTokensController < Doorkeeper::TokensController

  # Overriding create action
  # POST /oauth/token
  def create
    response = strategy.authorize
    body = response.body

    if response.status == :ok
      # User the resource_owner_id from token to identify the user
      case  params[:user_type]
      when 'user'
        user = User.find(response.token.resource_owner_id) rescue nil
      when  'beneficiario'
        user = Beneficiario.find(response.token.resource_owner_id) rescue nil
      end

      response.token.model_user_type  = user.model_name.to_s.downcase
      response.token.save

      unless user.nil?
        ### If you want to render user with template
        ### create an ActionController to render out the user
        # ac = ActionController::Base.new()
        # user_json = ac.render_to_string( template: 'api/users/me', locals: { user: user})
        # body[:user] = Oj.load(user_json)

        ### Or if you want to just append user using 'as_json'
        body[:user_id] = user.id.as_json
        body[:user_scope] = user.user_scope.as_json
      end
    end

    self.headers.merge! response.headers
    self.response_body = body.to_json
    self.status        = response.status

  rescue Doorkeeper::Errors::DoorkeeperError => e
    handle_token_exception e
  end
end
