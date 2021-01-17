require 'rails_helper'

RSpec.describe Organizacao, type: :model do

  context "Bad Attributes" do

    it"Rejeita organização com cnpj inválido" do
      org = create(:organizacao, cnpj:'08898104000167')
      expect(org.valid?).to be false
    end

  end

  context "Good Attributes" do
  
    it"Aceita organização com cnpj valido" do
      org = create(:organizacao, cnpj:'08898104000177')
      expect(org.valid?).to be true
    end

  end

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
