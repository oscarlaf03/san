require 'rails_helper'

RSpec.describe ContaBancaria, type: :model do
  context "Testando relationships" do

    it"beneficiario tem conta" do
      beneficiario = create(:beneficiario)
      banco = create(:conta_bancaria, beneficiario: beneficiario)
      expect( beneficiario.conta_bancaria == banco).to be true
    end

  end
end
