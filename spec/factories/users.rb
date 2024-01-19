FactoryBot.define do
  factory :user do
    uuid { SecureRandom.uuid }
    gender { 'male' }
    name { { title: 'Mr', first: 'John', last: 'Doe' } }
    location { 'XYZ' }
    age { 25 }
  end
end
