99.times do |n|
  name = "sample_user_#{n+1}"
  email    = "sample_user_#{n+1}@sample.com"
  password = "password_#{n+1}"
  user = User.new(username:  name,
                  email: email,
                  password:              password,
                  password_confirmation: password)
  user.skip_confirmation!
  user.save
end

users = User.order(:created_at).take(7)
30.times do |c|
  content  = "投稿テスト#{c+1}"
  start_at = Time.current - c.day - rand(1..8).hours
  end_at   = Time.current - c.day
  users.each { |user| user.microposts.create!(content: content, start_at: start_at, end_at: end_at) }
end
