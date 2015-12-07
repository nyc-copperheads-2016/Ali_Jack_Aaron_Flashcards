deck = Deck.create!(name: Faker::Lorem.word)
card = []
5.times do
  card << Card.create!(
    question: Faker::Hipster.sentence,
    answer: Faker::Hipster.word
    )
end
p card
deck.cards << card

deck = Deck.create!(name: Faker::Hacker.noun)
card = []
10.times do
  card << Card.create!(
    question: Faker::Hacker.verb,
    answer: Faker::Hacker.say_something_smart
    )
end
p card
deck.cards << card
