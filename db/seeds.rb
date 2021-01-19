
p "Creating internal users"

['teste@teste.com','admin@admin.com','backoffice@backoffice.com'].each do |email|
  u = User.create(email:email, password:'123123')
  u.add_role(:backoffice)
  u.save
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

(1..5).each do |index|
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







