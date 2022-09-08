first_user = User.create(name: 'Tom', email: 'a@gmail.com', password: '111111', password_confirmation: '111111', confirmed_at: DateTime.now)
first_group = Group.create(user: first_user, name: 'Test group', icon: Group::ICONS.first)
(1..4).each do |i|
    first_group.expenses.push Expense.create(author: first_user, name: 'expense 1', amount: i*2)
end