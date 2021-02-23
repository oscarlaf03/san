require 'rails_helper'

RSpec.describe  Api::V1::OrganizacoesController, type: :request do 
  context "Authorized internal user" do
    it "#index -- gets 200" do
      get api_v1_organizacoes_path, {headers: auth_headers}
      expect(response.status).to eq(200)
    end

  end

  context "Unauthorized  user" do
    it "#index -- gets 401" do
      get api_v1_organizacoes_path, {headers: {}}
      expect(response.status).to eq(401)
    end

  end


end
