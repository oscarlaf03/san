FactoryBot.define do
  factory :ticket do
    name_model { "MyString" }
    id_model { "MyString" }
    params { "MyString" }
    canceled { false }
    open { false }
    user { nil }
  end
end
