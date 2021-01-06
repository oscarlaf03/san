require 'rails_helper'

RSpec.describe BeneficiarioPolicy, type: :policy do
  # let(:user) { User.new }
  # TODO colocoar databascleaner

  subject { described_class }

  permissions ".scope" do
    pending "add some examples to (or delete) #{__FILE__}"
  end

  permissions :show? do
    pending "add some examples to (or delete) #{__FILE__}"
  end

  permissions :create? do
    pending "add some examples to (or delete) #{__FILE__}"
  end

  permissions :update? do

    it "rejeita edicão de beneficiario da mesma org que o user" do
      user = user_with_organizacao
      bene = create(:beneficiario, organizacao: user.organizacao)
      expect(subject).not_to permit(user,bene)
    end

    it "rejeita edicão de beneficiario de organizacao diferente ao do user" do
      user = user_with_organizacao
      bene = create(:beneficiario)
      expect(subject).not_to permit(user,bene)
    end

    it "permite edicão de beneficiario por um internal backoffice user" do
      user = user_with_role(:backoffice)
      bene = create(:beneficiario)
      expect(subject).not_to permit(user,bene)
    end

  end

  permissions :destroy? do
    pending "add some examples to (or delete) #{__FILE__}"
  end
end
