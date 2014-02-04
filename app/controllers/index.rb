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
  @game_id = session[:game]
  erb :board
end

get '/play' do
  game = Game.new(name: (1...1000000).to_a.sample)
  game.players.push(Player.find(session[:player1]), Player.find(session[:player2]))
  game.save
  session[:game] = game.id
  @game_id = session[:game]
  erb :board
end

post '/results' do
  if params[:data] == '1'
    players = Round.where(game_id: session[:game])
    players.find_by_player_id(session[:player1]).update_attributes(winner: true, winning_time: params[:time])
    players.find_by_player_id(session[:player2]).update_attributes(winner: false, winning_time: params[:time])
  elsif params[:data] == '2'
    players = Round.where(game_id: session[:game])
    players.find_by_player_id(session[:player2]).update_attributes(winner: true, winning_time: params[:time])
    players.find_by_player_id(session[:player1]).update_attributes(winner: false, winning_time: params[:time])
  end
end

get '/stats/:game_id' do
  puts params
  puts session
  @game_id = params[:game_id]
  @round_records = Round.where(game_id: params[:game_id])
  @player_1 = @round_records[0]
  winner = @round_records.find_by_winner(true)
  @winner_name = Player.find(winner.player_id).name
  loser = @round_records.find_by_winner(false)
  @loser_name = Player.find(loser.player_id).name
  session.clear
  erb :stats
end