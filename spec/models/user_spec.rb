require 'rails_helper'

RSpec.describe User, type: :mopdel do 
  context "realationship with orgs" do
    it 'Tem uma org' do
     user = user_with_organizacao
     expect(user.organizacao).to be_present
    end

    it 'Não tem uma org' do
      user = create(:user)
      expect(user.organizacao).not_to be_present
    end
  end

  context "Roles" do

    it "tem um role para org determinada" do
      user = create(:user)
      org = create(:organizacao)
      user.add_role :back_office, org
      expect(user.has_role? :back_office, org).to be(true)
    end

  end
end