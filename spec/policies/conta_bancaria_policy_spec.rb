require 'rails_helper'

RSpec.describe ContaBancariaPolicy, type: :policy do
  let(:user) { User.new }

  subject { described_class }

  permissions ".scope" do
    pending "add some examples to (or delete) #{__FILE__}"
  end

  permissions :show? do
    let(:conta ) { create(:conta_bancaria)}
    context "Podem vizualizar a conta bancaria" do
      it "o beneficiario dono da conta" do
        expect(subject).to permit(conta.beneficiario, conta)
      end

      it "o user interno com perfil autorizado" do
        expect(subject).to permit(internal_user, conta)
      end

      it "um user da mesma organizacao" do
        expect(subject).to permit(org_user(conta.organizacao), conta)
      end
    end

    context"Não podem visualizar a conta bancaria" do
      it "um beneficiario diferente ou da conta" do
        expect(subject).not_to permit(create(:beneficiario), conta)
      end

      it "um user sem perfil autorizado interno" do
        expect(subject).not_to permit(create(:user), conta)
      end

      it "um user de outra org diferente ao da conta" do
        other_user = org_user(create(:organizacao))
        expect(subject).not_to permit(other_user, conta)
      end

    end

  end

  permissions :create? do
    pending "add some examples to (or delete) #{__FILE__}"
  end

  permissions :update? do
    let(:conta) { create(:conta_bancaria) }
    let(:beneficiario) { conta.beneficiario }
    context " Podem editar a conta Bancaria " do

      it"o beneficiario dono da conta bancaria" do
        expect(subject).to permit(beneficiario, conta)
      end
    end

    context "Não podem editar a conta bancaria" do

      it"um benficiiario que não é dono da conta" do
        expect(subject).not_to permit( create(:beneficiario), conta)
      end

    end

  end

end

