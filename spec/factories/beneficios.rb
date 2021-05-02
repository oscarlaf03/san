FactoryBot.define do
  factory :beneficio do
    beneficiario
    organizacao_plano { association :organizacao_plano, organizacao: instance.beneficiario.organizacao}
    beneficio_condicao { FactoryBot.build(:beneficio_condicao,beneficio: instance, condicao: instance.beneficiario.organizacao.condicoes.first || FactoryBot.create(:condicao, organizacao: instance.beneficiario.organizacao) )}
    carteirinha { Faker::Number.number(digits: 14).to_s }
    data_inclusao {Date.today - rand(2..4) }
    vigencia { [6,12].sample}
  end
end


def beneficio_recem_incluido(**args)
  dentro_do_corte = args[:dentro_do_corte].nil? ? true : args[:dentro_do_corte]
  prorata = args[:prorata].nil? ? false : args[:prorata]
  org_plano = FactoryBot.create(:organizacao_plano)
  today = Date.today
  corte_do_mes = Date.new(today.year, today.month, org_plano.dia_corte)
  if prorata
    org_plano.organizacao.update(prorata: true)
  end
  incluso_em =  dentro_do_corte ? corte_do_mes - 1 : corte_do_mes + 1
  FactoryBot.create(:beneficio,organizacao_plano: org_plano, data_inclusao: incluso_em)
end

def beneficio_recem_excluido(**args)
  dentro_do_corte = args[:dentro_do_corte].nil? ? true : args[:dentro_do_corte]
  prorata = args[:prorata].nil? ? false : args[:prorata]
  today = Date.today
  beneficio =  FactoryBot.create(:beneficio,data_inclusao: today - 60)
  corte_do_mes = Date.new(today.year, today.month, beneficio.dia_corte)
  if prorata
    beneficio.organizacao.update(prorata: true)
  end
  exclusao_em = dentro_do_corte ? corte_do_mes - 1 : corte_do_mes + 1
  beneficio.update(data_exclusao: exclusao_em)
  beneficio
end

