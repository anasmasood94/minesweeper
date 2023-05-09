FactoryBot.define do
  factory :board do
    name { 'My Board' }
    email { 'board@example.com' }
    width { 5 }
    height { 5 }
    number_of_mines { 10 }
  end
end
