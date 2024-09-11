# db/seeds.rb
require 'faker'
require 'open-uri'

# Nombre total d'utilisateurs à créer
user_count = 20

puts "Suppression des anciens utilisateurs..."
User.destroy_all

# Création d'un utilisateur admin
puts "Création de l'utilisateur Admin..."
admin = User.new(
  email: "admin@example.com",
  password: 'password',
  password_confirmation: 'password',
  role: :admin,
  name: Faker::Name.first_name,
  surname: Faker::Name.last_name,
  username: "admin_user"
)
begin
  avatar_url = Faker::Avatar.image(slug: "admin", size: "100x100", format: "png", set: "set1")
  admin.profile_image.attach(io: URI.open(avatar_url), filename: "admin_user.png", content_type: 'image/png')
  admin.save!
  puts "Admin créé avec succès: #{admin.email}"
rescue => e
  puts "Erreur lors de l'attachement de l'image pour l'utilisateur admin: #{e.message}"
end

# Création d'un utilisateur modérateur
puts "Création de l'utilisateur Modérateur..."
moderator = User.new(
  email: "moderator@example.com",
  password: 'password',
  password_confirmation: 'password',
  role: :moderator,
  name: Faker::Name.first_name,
  surname: Faker::Name.last_name,
  username: "moderator_user"
)
begin
  avatar_url = Faker::Avatar.image(slug: "moderator", size: "100x100", format: "png", set: "set1")
  moderator.profile_image.attach(io: URI.open(avatar_url), filename: "moderator_user.png", content_type: 'image/png')
  moderator.save!
  puts "Modérateur créé avec succès: #{moderator.email}"
rescue => e
  puts "Erreur lors de l'attachement de l'image pour l'utilisateur modérateur: #{e.message}"
end

# Création d'un utilisateur membre
puts "Création de l'utilisateur Membre..."
member = User.new(
  email: "member@example.com",
  password: 'password',
  password_confirmation: 'password',
  role: :member,
  name: Faker::Name.first_name,
  surname: Faker::Name.last_name,
  username: "member_user"
)
begin
  avatar_url = Faker::Avatar.image(slug: "member", size: "100x100", format: "png", set: "set1")
  member.profile_image.attach(io: URI.open(avatar_url), filename: "member_user.png", content_type: 'image/png')
  member.save!
  puts "Membre créé avec succès: #{member.email}"
rescue => e
  puts "Erreur lors de l'attachement de l'image pour l'utilisateur membre: #{e.message}"
end

# Création des utilisateurs restants avec le rôle user
remaining_users_count = user_count - 3

puts "Création de #{remaining_users_count} utilisateurs normaux..."
remaining_users_count.times do
  user = User.new(
    email: Faker::Internet.email,
    password: 'password',
    password_confirmation: 'password',
    role: :user,
    name: Faker::Name.first_name,
    surname: Faker::Name.last_name,
    username: Faker::Internet.username
  )

  begin
    avatar_url = Faker::Avatar.image(slug: nil, size: "100x100", format: "png", set: "set1")
    user.profile_image.attach(io: URI.open(avatar_url), filename: "#{user.username}.png", content_type: 'image/png')
    user.save!
    puts "Utilisateur normal créé avec succès: #{user.email}"
  rescue => e
    puts "Erreur lors de l'attachement de l'image pour l'utilisateur #{user.username}: #{e.message}"
  end
end

puts "Tous les utilisateurs ont été créés avec succès."
