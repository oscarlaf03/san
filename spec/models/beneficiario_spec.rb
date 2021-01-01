require 'rails_helper'

RSpec.describe Beneficiario, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  context "Relationships" do 
    it "Pertence a uma organizacao" do
    org = create(:organizacao)
    b = create(:beneficiario, organizacao: org)
    expect b.organizacao  == org
    end

    it "dependente tem um titular" do
      titular = create(:beneficiario)
      dependente = create(:beneficiario, titular: titular)
      expect dependente.titular == titular
    end

    it "titular tem dependentes" do
      titular = create(:beneficiario)
      dependente = create(:beneficiario, titular: titular)
      expect titular.dependentes.first ==  dependente
    end

  end
end
