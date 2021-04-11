require 'rails_helper'

RSpec.describe Ticket, type: :model do

  context "Ticket should be valid" do
    let(:internal_user) { create(:user)}
    let(:requestor) {user_with_organizacao}

    it "without 'id_model' for 'create' action" do
      ticket = build(:ticket, requestor: requestor, action: 'create')
      expect(ticket.valid?).to be true
    end

    it "with params nil when destroy action" do
      ticket = build(:ticket, params: nil, action: 'destroy')
      ticket.valid?
      expect(ticket.errors.details.has_key?(:params)).to be false
    end

    it "with params not in json format when destroy action" do
      ticket = build(:ticket, params: 'perro gato', action: 'destroy')
      ticket.valid?
      expect(ticket.errors.details.has_key?(:params)).to be false
    end

  end

  context "Ticket should not be valid" do
    let(:requestor) {user_with_organizacao}

    it "without requestor" do
      ticket = build(:ticket, requestor: nil, action: 'create')
      expect(ticket.valid?).to be false
    end

    it "with internal user as requestor" do
      ticket = build(:ticket, requestor: create(:user), action:'create')
      expect(ticket.valid?).to be false
    end

    it "with user organizacao as owner" do
      ticket = build(:ticket, owner: user_with_organizacao, action: 'create')
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

    it "with params not in json format when non-destroy action" do
      ticket = build(:ticket, params: nil, action: 'create')
      ticket.valid?
      expect(ticket.errors.details.has_key?(:params)).to be true
    end

    it "Pointing to a nonexistent object for a non-create action" do
      ticket = build(:ticket,action: 'update', id_model:999999999)
      expect(ticket.valid?).to be false
    end

    it "Pointing to an object of another org non-create action" do
      other_org_user = user_with_organizacao
      ticket = build(:ticket, action: 'update', id_model:other_org_user.id, requestor: requestor, name_model:'User', params: {email: 'new_email_test@example.org'}.to_json )
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

    it "Organizacao responds accurately to requests" do
      times.times do
        create(:ticket, requestor: org_user)
      end
      expect( org_user.organizacao.requests.size).to eq(Ticket.select{ |t| t.requestor.organizacao == org_user.organizacao }.size)
    end
  end

  context "Instance methods" do
    let(:org_user) {user_with_organizacao}


    it "#execute! -- update" do
      guinea_pig = create(:user, organizacao: org_user.organizacao)
      new_email =  'updated_via_ticket@example.com'
      ticket = create(:ticket, name_model: 'User', id_model: guinea_pig.id,action:'update', requestor: org_user, params: {email:new_email}.to_json)
      ticket.execute!
      expect(User.find(guinea_pig.id).email).to eq(new_email)
    end

    it "#execute! -- create" do
      params ={
        email:  'created_via_ticket_process@example.com',
        nome: 'nome via ticket',
        sobre_nome: 'sobrenome via ticket creted',
        cpf: Faker::IDNumber.brazilian_citizen_number,
        # organizacao: org_user.organizacao,
        genero: 'homem',
      }
      ticket = create(:ticket, name_model: 'Beneficiario',action: 'create', requestor: org_user, params: params.to_json  )
      ticket.execute!
      expect(Beneficiario.last.nome).to eq(params[:nome])
    end

    it "#execute! -- destroy" do
      guinea_pig = create(:user, organizacao: org_user.organizacao)
      ticket = create(:ticket, name_model: 'User', id_model: guinea_pig.id,action: 'destroy', requestor: org_user  )
      ticket.execute!
      expect(User.find_by(id: guinea_pig.id)).to be nil
    end
  end
end
