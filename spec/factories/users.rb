FactoryBot.define do
  factory :user do
    name { "Dan" }
    email { "example@mail.ru" }
    password { "123123" }
    password_confirmation { "123123" }
  end
end
