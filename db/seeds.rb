# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.first_or_create!(
  name: 'admin1',
  email: 'admin@admin', # adminユーザーのメールアドレス
  password: 'admin1',    # adminユーザーのパスワード
  admin: true                 # admin列をtrueに設定してadmin権限を付与
)


# テスト用のSeed

User.create!(
    name: '@test1',
    email: 'test1@test1',
    password: '111111',
    admin:false
  )


User.create!(
    name: '@test2',
    email: 'test2@test2',
    password: '111111',
    admin:false
  )

User.create!(
    name: '@test3',
    email: 'test3@test3',
    password: '111111',
    admin:false
  )

User.create!(
    name: '@test4',
    email: 'test4@test4',
    password: '111111',
    admin:false
  )

