FactoryBot.define do
  factory :user do
    first_name {Faker::Name.first_name }
    last_name{ Faker::Name.last_name  }
    email { Faker::Internet.safe_email(name: self.first_name)}
    password {"123123"}
    phone {Faker::Number.number(digits: 11)}
    organizacao { nil }
  end
end


def user_with_organizacao
  FactoryBot.create(:user, organizacao: FactoryBot.create(:organizacao))
end

def user_with_role(role, class_or_record = nil,**user_custom_params)
  user = FactoryBot.create(:user,user_custom_params)
  user.add_role role.to_sym, class_or_record
  user
end

def internal_user
  user_with_role(:backoffice)
end

def org_user(organizacao = nil)
  org = organizacao ? organizacao : FactoryBot.create(:organizacao)
  FactoryBot.create(:user, organizacao: org)
end
