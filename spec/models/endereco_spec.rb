require 'rails_helper'

RSpec.describe Endereco, type: :model do
  let(:organizacao) { create(:organizacao)}
  let(:beneficiario) { create(:beneficiario)}

  context "Testar relationships" do

    it"Responde a beneficiario" do
      endereco = create(:endereco, beneficiario: beneficiario)
      expect(endereco.beneficiario).to eq(beneficiario)
    end

    it"Responde a organizacao" do
      endereco = create(:endereco, organizacao: organizacao)
      expect(endereco.organizacao).to eq(organizacao)
    end

  end
end
