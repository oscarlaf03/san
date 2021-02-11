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

  context "Devise for User" do
    it "#set_reset_password_token - returns the plain text token" do
      user = create(:user)
      potential_token = user.send(:set_reset_password_token)
      potential_token_digest = Devise.token_generator.digest(user, :reset_password_token, potential_token)
      actual_token_digest = user.reset_password_token
      expect(potential_token_digest).to eql(actual_token_digest)
    end
  end
end
