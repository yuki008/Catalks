FactoryBot.define do 
  factory :user do 
    email { "tama@example.com" } 
    username { "たま" }
    password { "abcdef" }
    password_confirmation { "abcdef" }
  end
end