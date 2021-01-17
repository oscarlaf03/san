require 'rails_helper'

RSpec.describe User, type: :mopdel do 

  context "Bad Attributes" do

    it"Rejeita user com email inválido" do
      user = build(:user, email:'invalid_email')
      expect(user.valid?).to be false
    end

  end

  context "Good Attributes" do

    it"Aceita user com email valido" do
      user = build(:user, email: Faker::Internet.safe_email)
      expect(user.valid?).to be true
    end

  end
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