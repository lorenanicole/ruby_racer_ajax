get '/' do
  # Look in app/views/index.erb
  erb :index
end

post '/play' do
  puts params
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
  puts params
  if params[:data] == '1'
    players = Round.where(game_id: session[:game])
    players.find_by_player_id(session[:player1]).update_attributes(winner: true, winning_time: params[:time])
    players.find_by_player_id(session[:player2]).update_attributes(winner: false, winning_time: params[:time])
    redirect '/stats'
  elsif params[:data] == '2'
    players = Round.where(game_id: session[:game])
    players.find_by_player_id(session[:player2]).update_attributes(winner: true, winning_time: params[:time])
    players.find_by_player_id(session[:player1]).update_attributes(winner: false, winning_time: params[:time])
    redirect '/stats'
  end
end

get '/stats' do

  erb :stats
end
