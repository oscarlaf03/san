require 'rails_helper'

RSpec.describe Ticket, type: :model do

  context "Ticket should be valid" do
    let(:internal_user) { create(:user)}
    let(:requestor) {user_with_organizacao}

    it "without 'id_model' for 'create' action" do
      ticket = build(:ticket, requestor: requestor, action: 'create')

      # binding.pry
      expect(ticket.valid?).to be true
    end


    
  end

  context "Ticket should not be valid" do

    it "without requestor" do
      ticket = build(:ticket, requestor: nil)
      expect(ticket.valid?).to be false
    end

    it "with internal user as requestor" do
      ticket = build(:ticket, requestor: create(:user))
      expect(ticket.valid?).to be false
    end

    it "with user organizacao as owner" do
      ticket = build(:ticket, owner: user_with_organizacao)
      expect(ticket.valid?).to be false
    end

    it "without name_model" do
      ticket = build(:ticket, name_model: nil, id_model: nil, action:'create')
      expect(ticket.valid?).to be false
    end

    it "with unknown name_model constant" do
      ticket = build(:ticket,name_model:"Perro", action: 'create', id_model: nil)
      expect(ticket.valid?).to be false
    end

    it "without action" do
      ticket = build(:ticket,action: nil)
      expect(ticket.valid?).to be false
    end

    it "with and invalid action" do
      ticket = build(:ticket,action: "INVALID_ACTION")
      expect(ticket.valid?).to be false
    end

    it "without id_model for a not create action" do
      ticket = build(:ticket,action: 'update', id_model:nil)
      expect(ticket.valid?).to be false
    end

    it "with any id_model value for create action" do
      ticket = build(:ticket,action: 'create', id_model:999999)
      expect(ticket.valid?).to be false
    end

    it "Pointing to a nonexistent object for a non-create action" do
      ticket = build(:ticket,action: 'update', id_model:999999999)
      expect(ticket.valid?).to be false
    end

  end

  context "Ticket has associatons" do
    let(:internal_user) { create(:user)}
    let(:org_user) {user_with_organizacao}
    let(:times){ 5 }

    it "belongs to internal users as tickets via owner attribute" do
      times.times do
        create(:ticket, owner: internal_user)
      end
      expect(internal_user.tickets.size).to eq(times)
    end

    it "belongs to org_user users as requests via requestor attribute" do
      times.times do
        create(:ticket, requestor: org_user)
      end
      expect(org_user.requests.size).to eq(times)
    end

    it "responds to the Organizacao the requestor belongs to" do
      # org_user = user_with_organizacao
      ticket =  create(:ticket, requestor: org_user)
      expect(ticket.organizacao).to equal(org_user.organizacao)
    end

    it "Organizacao responds to requets" do
      times.times do
        create(:ticket, requestor: org_user)
      end
      expect( org_user.organizacao.requests.size).to eq(Ticket.select{ |t| t.requestor.organizacao == org_user.organizacao }.size)
    end
  end
end
