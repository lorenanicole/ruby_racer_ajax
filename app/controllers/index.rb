get '/' do
  # Look in app/views/index.erb
  erb :index
end

post '/play' do
  @player1 = Player.add_player(params[:player1])
  @player2 = Player.add_player(params[:player2])
  game = Game.new(name: (1...1000000).to_a.sample)
  game.players.push(@player1, @player2)
  game.save
  session[:player1] = @player1.id
  session[:player2] = @player2.id
  session[:game] = game.id
  erb :board
end

post '/results' do
  if params[:value] == '1'
    game = Game.find(session[:game])
    game.players.find(session[:player1]).winner = true
    game.save
  elsif params[:value] == '2'
    game = Game.find(session[:game])
    game.players.find(session[:player2]).winner = true
    game.save
  end
end

get '/stats' do
  erb :stats
end
