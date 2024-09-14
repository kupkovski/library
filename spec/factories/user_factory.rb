# This will guess the User class
FactoryBot.define do
  factory :user do
    name { "John" }
    user_type  { "member" }
    email { "member@email.com" }
    password { "123456" }
  end
end
