User.create! name: "Admin",
  email: "admin@admin.com",
  password: "foobar",
  password_confirmation: "foobar",
  admin: true
User.create! name: "Duc",
  email: "duc@duc.com",
  password: "foobar",
  password_confirmation: "foobar",
  admin: true
10.times do |n|
  User.create! name: "User #{n}",
  email: "user#{n}@user.com",
  password: "foobar",
  password_confirmation: "foobar"
end

10.times do |n|
  Category.create! name: "Category #{n}", title: "Category #{n} - " * 10
end

category = Category.first
100.times do |n|
  word = Word.new
  4.times do |nn|
    answer_content = (0...4).map{(65 + rand(26)).chr}.join
    word.answers.new content: answer_content
  end
  correct_answer = word.answers.at rand 4
  correct_answer.correct = true
  word.content = correct_answer.content
  word.category_id = category.id
  word.save
end

