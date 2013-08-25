FactoryGirl.define do

  factory :company do
    sequence(:name)  { |n| "Company #{n}" }
    sequence(:email) { |n| "company_#{n}@company.com"}
    phone  111222333
    address "Praha, Vaclavske namesti 10, 130 00"
    web "www.company.com"
    ico 12312312
    dic 12312312
  end

  factory :employee do
    sequence(:name) { |n| "name_#{n}"}
    sequence(:surname) { |n| "surname_#{n}"}
    sequence(:email) { |n| "name_#{n}@email.com"}
    phone  111222333
    address "Praha, Vaclavske namesti 10, 130 00"
    birthday { 21.years.ago } 
    position "manager"
    association :company
  end

  factory :position do
    sequence(:name) { |n| "position_name_#{n}"}
    association :company
  end
end
