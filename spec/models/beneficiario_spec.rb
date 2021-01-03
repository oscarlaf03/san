require 'rails_helper'

RSpec.describe Beneficiario, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  context "Relationships" do 
    it "Pertence a uma organizacao" do
    org = create(:organizacao)
    b = create(:beneficiario, organizacao: org)
    expect(b.organizacao  == org).to be(true)
    end

    it "dependente tem um titular" do
      titular = create(:beneficiario)
      dependente = create(:beneficiario, titular: titular)
      expect(dependente.titular == titular).to be(true)
    end

    it "titular tem dependentes" do
      titular = create(:beneficiario)
      dependente = create(:beneficiario, titular: titular)
      expect(titular.dependentes.first ==  dependente).to be(true)
    end

  end

  context "Beneficiario Roles" do
    it "Tem role de de titular e de dependente" do
      org = create(:organizacao)
      titular = create(:beneficiario, organizacao: org)
      3.times do
        dependente = create(:beneficiario, titular: titular, organizacao:org)
        titular.add_role :titular, dependente
        dependente.add_role :dependente, titular
      end
      dep = titular.dependentes.first
      expect(
        (titular.has_role? :titular, dep) && (dep.has_role? :dependente,titular)
      ).to be(true)
    end

    it "Responde a perfil corretamente" do
      titular = beneficiario_with_dependentes
      dependente = titular.dependentes.sample
      expect(titular.perfil == 'titular' && dependente.perfil == 'dependente').to be(true)
    end

    it "Falha para tornar dependente a um titular" do
      titular= beneficiario_with_dependentes
      dep = titular.dependentes.sample
      titular.update(titular: dep)
      expect(titular.valid?).to be(false)
    end
  end
end
