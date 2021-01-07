require 'rails_helper'

RSpec.describe Plano, type: :model do
  context "Testando Relationships" do
    it "Tem muitas organizacoes" do
      org = create(:organizacao)
      plano = create(:plano)
      create(:organizacao_plano, organizacao: org, plano: plano)
      expect plano.organizacoes.first == org
    end

    it "belongs_to seguradora" do
      plano = create(:plano)
      expect(plano.seguradora).to be_present
    end
  end
end
