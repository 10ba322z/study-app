User.create!(username: "Example User",
             email:    "test@example.com",
             password:              "testtest",
             password_confirmation: "testtest",
             activated: true,
             activated_at: Time.zone.now)
