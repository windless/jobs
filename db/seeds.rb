User.delete_all
Project.delete_all
Sprint.delete_all

user = User.create!(name: "windless", email: "windlessg@gmail.com",
                   password: "foobar", password_confirmation: "foobar")



