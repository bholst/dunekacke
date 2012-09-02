FactoryGirl.define do
  factory :user do
    name      "Michael Mustermann"
    email     "foo@bar.com"
    password  "foobar"
    password_confirmation "foobar"
  end
end