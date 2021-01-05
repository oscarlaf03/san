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
    pending "add some examples to (or delete) #{__FILE__}"
  end

  permissions :update? do
    it "Não permite edição da org" do
      expect(subject).not_to  permit(create(:user), create(:organizacao))
    end

    it "Permite edição da org por um user role :backoffice" do
      user = user_with_role(:backoffice)
      expect(subject).to  permit(user, create(:organizacao))
    end
  end

  permissions :destroy? do
    pending "add some examples to (or delete) #{__FILE__}"
  end
end
