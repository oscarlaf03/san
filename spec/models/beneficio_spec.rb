require 'rails_helper'

RSpec.describe Beneficio, type: :model do
  context "Relationships" do
    let(:beneficio) {create(:beneficio)}
    let(:condicao) {create(:condicao)}
    it "tem uma condicao through condicao" do
      expect(beneficio.condicao.kind_of?(Condicao)).to be true
    end

    it "Responde para plano retornando o Plano" do
      expect(beneficio.plano.kind_of?(Plano)).to be true
    end

    it "Responde para organizacao retornando uma Organizacao" do
      expect(beneficio.organizacao.kind_of?(Organizacao)).to be true
    end

  end
end
