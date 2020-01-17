require 'faker'

User.create!(
    name: "Tsugumi",
    email: "tsugumippp@icloud.com",
    password: "tsugumi"
)

50.times do |n|
    User.create!(
        name: Faker::JapaneseMedia::OnePiece.character,
        email: Faker::Internet.unique.email,
        password: "password"
    )
end