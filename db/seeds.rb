User.create([
	{uname: 'Geffern', email: 'nkp305@gmail.com', password: '124610'},
	{uname: 'Jlim', email: 'jlim@nycda.com', password: 'jlim123'}

])
Post.create([
	{title: 'My first post', body: 'Isn\'t thiswonderful?', user_id: 1},
	{title: 'Not impressed', body: 'I\'ve seen better.', user_id:2}
])	
	
