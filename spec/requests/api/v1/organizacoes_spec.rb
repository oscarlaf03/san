require 'rails_helper'

RSpec.describe  Api::V1::OrganizacoesController, type: :request do

  context "Não confunde Beneficarios com Users do mesmo id" do
    it "#show -- Forbidden for Beneficiario"do
      org = create(:organizacao)
      user = create(:user,id: 99)
      beneficiario = create(:beneficiario,id: 99)
      get api_v1_organizacao_path(org), { headers: auth_headers(beneficiario) }
      expect(response.status).to eq(403)

    end
  end

  context "Authorized internal user" do

    it "#index -- gets 200 OK" do
      get api_v1_organizacoes_path, {headers: auth_headers}
      expect(response.status).to eq(200)
    end

    it "#index -- returns all Orgs" do
      20.times do
        create(:organizacao)
      end
      get api_v1_organizacoes_path, {headers: auth_headers}
      expect(JSON.parse(response.body).size).to eq(Organizacao.count)
    end

    it "#show -- gets 200 OK" do
      org = create(:organizacao)
      get api_v1_organizacao_path(org), {headers: auth_headers}
      expect(response.status).to eq(200)
    end

    it "#update -- updates OK" do
      pending("syntax for path requests rspec")
      new_razao_social = "Nova razão social editada"
      org =  create(:organizacao)
      body= {
        razao_social: new_razao_social
      }

      patch api_v1_organizacao_path(org), {params: body, headers: auth_headers}
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
