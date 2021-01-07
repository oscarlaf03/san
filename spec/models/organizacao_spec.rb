require 'rails_helper'

RSpec.describe Organizacao, type: :model do
  context " Organizacao Relationships" do
    it "Tem  muitos planos through OrganizacaoPlano" do
      org = create(:organizacao)
      plano = create(:plano)
      expect org.planos.first == plano
    end

    it "Tem mutas condicoes " do
      org = create(:organizacao)
      5.times do 
        create(:condicao, organizacao: org)
      end
      expect(org.condicoes.size).to eq(5)
    end

    
  end
end
