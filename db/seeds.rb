User.delete_all
Project.delete_all
Sprint.delete_all

user = User.create!(name: "windless", email: "windlessg@gmail.com",
                   password: "foobar", password_confirmation: "foobar")

30.times do |n|
  user.projects.create(name: "Project #{n}",
                       description: "des bla bla bla")
end

30.times do |n|
  sprint = user.projects.first.sprints.create(description: "sprint #{n}")
end


