FactoryBot.define do
  factory :user do
  end
  factory :test_user, class: 'User' do
    name      {"test user"}
    email     {"test@test.com"}
    password  {"12345678"}
  end
  factory :test_login_user, class: 'User' do
    email     {"test@test.com"}
    password  {"12345678"}
  end
end