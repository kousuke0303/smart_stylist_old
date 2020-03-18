User.create!(name: "Admin User",
             email: "admin@email.com",
             password: "password",
             password_confirmation: "password",
             question: "好きな食べ物は？",
             answer: "リンゴ",
             admin: true)

User.create!(name: "test_user1",
             email: "test1@email.com",
             password: "password",
             password_confirmation: "password",
             question: "好きな食べ物は？",
             answer: "リンゴ",)
             
User.create!(name: "test_user2",
             email: "test2@email.com",
             password: "password",
             password_confirmation: "password",
             question: "好きな食べ物は？",
             answer: "リンゴ",)