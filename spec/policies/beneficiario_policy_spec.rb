require 'rails_helper'

RSpec.describe BeneficiarioPolicy, type: :policy do
  let(:user) { User.new }

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

    it "permite edicão de beneficiario da mesma org que o user" do
      user = user_with_organizacao
      bene = create(:beneficiario, organizacao: user.organizacao)
      expect(subject).to permit(user,bene)
    end

  end

  permissions :destroy? do
    pending "add some examples to (or delete) #{__FILE__}"
  end
end
