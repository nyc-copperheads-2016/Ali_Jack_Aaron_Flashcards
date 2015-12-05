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
