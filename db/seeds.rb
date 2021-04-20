p "Creating Oauth applications"

if Doorkeeper::Application.find_by(name: "san_web").nil?
  Doorkeeper::Application.create(name: "san_web", redirect_uri: "", scopes: "", secret: ENV['SAN_WEB_SECRET'])
end


if Doorkeeper::Application.find_by(name: "san_app").nil?
  Doorkeeper::Application.create(name: "san_app", redirect_uri: "", scopes: "", secret: ENV['SAN_APP_SECRET'])
end


p "Creating internal users"

['teste@teste.com','admin@admin.com','backoffice@backoffice.com','internal@internal.com'].each do |email|
  u = User.create(email:email, password:'123123')
  u.add_role(:backoffice)
end

p 'Creting neighboor organizations'
3.times do
  user_with_organizacao
end

p "Creating organizacao com plano"

org = FactoryBot.create(:organizacao)

seg = FactoryBot.create(:seguradora)
plano = FactoryBot.create(:plano, seguradora:seg)
condicao = FactoryBot.create(:condicao, organizacao: org)
org.planos << plano
org.condicoes << condicao
org.save
plano.save
condicao.save


p "Creating cliente user"


cliente = User.create(organizacao: org, email:'cliente@cliente.com', password:'123123')

p "Creating Beneficarios titulares"

(1..12).each do |index|
  FactoryBot.create(:beneficiario, organizacao: org, email: "titular#{index}@beneficiario.com", password: '123123')
end

p "Creating Beneficarios dependentes"

Beneficiario.all.each_with_index do |titular, index|
  FactoryBot.create(:beneficiario, organizacao: org, email: "dependente#{index}@beneficiario.com", password: '123123', titular: titular)
end

p "Creating Beneficios"

org_plano = OrganizacaoPlano.where(organizacao: org, plano:plano).first

Beneficiario.all.each do |beneficiario|
  b = Beneficio.create(beneficiario: beneficiario, organizacao_plano: org_plano)
  b.condicao = condicao
  b.save
end

p "Confirmando todos os usuários"
User.update_all confirmed_at: DateTime.now

p "Confirmando todos os beneficiarios"
Beneficiario.update_all confirmed_at: DateTime.now


p "Making planos"
Seguradora.all.each do |seg|
  if seg.planos.blank?
    5.times do
      FactoryBot.create(:plano, seguradora: seg)
    end
  end
end

p "Make org users"
Organizacao.all.each do |org|
  if org.users.blank?
    2.times do
      FactoryBot.create(:user, organizacao: org)
    end
  end
end

p "Make beneficiarios"

Organizacao.all.each do |org|
  if org.beneficiarios.blank?
    2.times do
      FactoryBot.create(:beneficiario, organizacao: org)
    end
  end
end

p "Make Tickets"

Organizacao.all.each do |org|
  if org.requests.blank?
    (3..8).to_a.sample.times do
      requestor = org.users.sample || FactoryBot.create(:user, organizacao: org, email: "oscar_teste#{rand.to_s.gsub('.','')}@geocities.#{%w[com br mx co tv inc dev net].sample}")
      params = {nome: "nome editado via ticket #{rand.to_s.gsub('.','')} "}
      FactoryBot.create(:ticket, requestor: requestor, name_model: "Beneficiario", id_model: org.beneficiarios.sample.id, params: params.to_json, action: 'update')
    end
  end
end


p "All done"



