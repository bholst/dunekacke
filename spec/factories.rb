FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}   
    password "foobar"
    password_confirmation "foobar"
    activated true
    
    factory :admin do
      admin true
    end
    
    factory :unactivated do
      activated false
    end
  end
  
  factory :tune do
    content "X:1\nM:3/4\nL:1/8\nK:D\nDDD"
    user
  end
end

