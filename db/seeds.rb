deck = Deck.create!(name: Faker::Lorem.word)
card = []
5.times do
  card << Card.create!(
    question: Faker::Lorem.sentence,
    answer: Faker::Lorem.word
    )
end
p card
deck.cards << card
