require 'rails_helper'

RSpec.describe Api::V1::OrganizacoesController, type: :request do

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

    it "#create -- creates an org" do
      body ={
        slug: Faker::Company.buzzword,
        razao_social: "quinta a noite Empresa teste api",
        cnpj: Faker::Company.brazilian_company_number,
        nome_fantasia: Faker::Company.name,
        inscricao_municipal: Faker::Number.number(digits: 5),
        inscricao_estadual: Faker::Number.number(digits: 8)
      }
      post api_v1_organizacoes_path, {params:{organizacao: body}, headers: auth_headers}
      expect(response.status).to eq(201)

    end

    it "#update -- updates an attribute" do
      new_razao_social = "Nova razão social editada"
      org =  create(:organizacao)
      body= {
        razao_social: new_razao_social
      }
      patch api_v1_organizacao_path(org), {params:{organizacao: body}, headers: auth_headers}
      expect(Organizacao.find(org.id).razao_social == body[:razao_social]).to be true
    end
  end

  context "Authorized organizacao user" do
    let(:user) {user_with_organizacao}
    let(:org){user.organizacao}
    let(:user_header) {auth_headers(user)}

    it "#index -- gets 200 OK" do
      get api_v1_organizacoes_path, {headers: auth_headers}
      expect(response.status).to eq(200)
    end

    it "#index -- returns only orgs of that user " do
      get api_v1_organizacoes_path, {headers: user_header}
      org_id = JSON.parse(response.body).first["id"]
      expect(user.org_group_ids.include?(org_id)).to be true
    end

    it "#show -- gets 200 OK" do
      get api_v1_organizacao_path(org), {headers: user_header}
      expect(response.status).to eq(200)
    end

    it "#create -- Forbids creating an org" do
      body ={
        slug: Faker::Company.buzzword,
        razao_social: "quinta a noite Empresa teste api",
        cnpj: Faker::Company.brazilian_company_number,
        nome_fantasia: Faker::Company.name,
        inscricao_municipal: Faker::Number.number(digits: 5),
        inscricao_estadual: Faker::Number.number(digits: 8)
      }
      post api_v1_organizacoes_path, {params:{organizacao: body}, headers: user_header}
      expect(response.status).to eq(403)

    end

    it "#update -- Forbids updating an  org attribute" do
      new_razao_social = "Nova razão social editada"
      org =  create(:organizacao)
      body= {
        razao_social: new_razao_social
      }
      patch api_v1_organizacao_path(org), {params:{organizacao: body}, headers: user_header}
      expect(response.status).to eq(403)
    end

  end

  context "Unauthorized user of another organizacao" do
    let(:user) {user_with_organizacao}
    let(:org) {user_with_organizacao.organizacao}
    let(:user_header) {auth_headers(user)}

    it "#index -- gets 200 OK" do
      get api_v1_organizacoes_path, {headers: auth_headers}
      expect(response.status).to eq(200)
    end

    it "#index -- returns only orgs of that user " do
      get api_v1_organizacoes_path, {headers: user_header}
      org_id = JSON.parse(response.body).first["id"]
      expect(user.org_group_ids.include?(org_id)).to be true
    end

    it "#show -- Forbids seeing another org" do
      get api_v1_organizacao_path(org), {headers: user_header}
      expect(response.status).to eq(403)
    end

  end

  context "Unauthorized beneficiario user" do
    let(:org){user_with_organizacao.organizacao}
    let(:beneficiario) {create(:beneficiario, organizacao: org)}
    let(:beneficiario_header) {auth_headers(beneficiario)}

    it "#index -- Forbids index" do
      get api_v1_organizacoes_path, {headers: beneficiario_header}
      expect(response.status).to eq(403)
    end

    it "#show -- Forbids show" do
      get api_v1_organizacao_path(org), {headers: beneficiario_header}
      expect(response.status).to eq(403)
    end

    it "#create -- Forbids creating an org" do
      body ={
        slug: Faker::Company.buzzword,
        razao_social: "quinta a noite Empresa teste api",
        cnpj: Faker::Company.brazilian_company_number,
        nome_fantasia: Faker::Company.name,
        inscricao_municipal: Faker::Number.number(digits: 5),
        inscricao_estadual: Faker::Number.number(digits: 8)
      }
      post api_v1_organizacoes_path, {params:{organizacao: body}, headers: beneficiario_header}
      expect(response.status).to eq(403)

    end

    it "#update -- Forbids updating an  org attribute" do
      new_razao_social = "Nova razão social editada"
      org =  create(:organizacao)
      body= {
        razao_social: new_razao_social
      }
      patch api_v1_organizacao_path(org), {params:{organizacao: body}, headers: beneficiario_header}
      expect(response.status).to eq(403)
    end

  end

  context "Unsigned user" do
    let(:org) {user_with_organizacao.organizacao}

    it "#index -- gets 401" do
      get api_v1_organizacoes_path, {headers: {}}
      expect(response.status).to eq(401)
    end

    it "#show -- gets 401" do
      get api_v1_organizacao_path(org), {headers: {}}
      expect(response.status).to eq(401)
    end

    it "#create -- gets 401" do
      body ={
        slug: Faker::Company.buzzword,
        razao_social: "quinta a noite Empresa teste api",
        cnpj: Faker::Company.brazilian_company_number,
        nome_fantasia: Faker::Company.name,
        inscricao_municipal: Faker::Number.number(digits: 5),
        inscricao_estadual: Faker::Number.number(digits: 8)
      }
      post api_v1_organizacoes_path, {params:{organizacao: body}, headers: {}}
      expect(response.status).to eq(401)
    end

    it "#update -- gets 401" do
      new_razao_social = "Nova razão social editada"
      org =  create(:organizacao)
      body= {
        razao_social: new_razao_social
      }
      patch api_v1_organizacao_path(org), {params:{organizacao: body}, headers: {}}
      expect(response.status).to eq(401)
    end

  end


end
