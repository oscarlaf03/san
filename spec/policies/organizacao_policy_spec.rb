require 'rails_helper'

RSpec.describe OrganizacaoPolicy, type: :policy do
  let(:user) { User.new }

  subject { described_class }

  permissions ".scope" do
    pending "add some examples to (or delete) #{__FILE__}"
  end

  permissions :show? do
    pending "add some examples to (or delete) #{__FILE__}"
  end

  permissions :create? do
    it "Permite create de usuario interno" do
      user = user_with_role(:backoffice)
      expect(subject).to permit(user)
    end

    it "Recusa create de usuario qualquer " do
      user = user_with_organizacao
      expect(subject).not_to permit(user)
    end
  end

  permissions :update? do
    it "Não permite edição da org de user qualquer" do
      expect(subject).not_to  permit(create(:user), create(:organizacao))
    end

    it "Permite edição da org por um user role :backoffice" do
      user = user_with_role(:backoffice)
      expect(subject).to  permit(user, create(:organizacao))
    end

    it "Permite edição da org por User que pertence a org" do
      user = user_with_organizacao
      expect(subject).to permit(user, user.organizacao)
    end

    it "Rejeita edição da org por Beneficiario que pertence a org" do
      beneficiario = create(:beneficiario)
      expect(subject).not_to permit(beneficiario, beneficiario.organizacao)
    end

  end

  permissions :destroy? do
    pending "add some examples to (or delete) #{__FILE__}"
  end
end
