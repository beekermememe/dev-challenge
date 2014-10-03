require 'csv'
require 'pry'
require 'player_year_stat2'
require 'player2'
class StatsReader2

class << self
  def read_player_stats(filename,players,team,year)
    csvfile = CSV.open(filename,"r", {headers: true})
    data = csvfile.read
    data.each do |row|
      if players[row.to_hash["playerID"]]
        players[row.to_hash["playerID"]].player_stats << PlayerYearStat2.new(row.to_hash)
      else
        players[row.to_hash["playerID"]] = Player2.new({"playerid" => row.to_hash["playerID"], "player_stats" => [PlayerYearStat2.new(row.to_hash)]})
      end
    end
    team_data = []
    players.each do |id,player|
      player.player_stats.each do |player_stat|
        next if player_stat.yearid != year || player_stat.teamid != team
        team_data << player_stat
      end
    end
    return players, team_data
  end


  def read_player_details(filename)
    csvfile = CSV.open(filename,"r", {headers: true})
    data = csvfile.read
    players = {}
    data.each do |row|
      players[row.to_hash['playerID']] = Player2.new(row.to_hash)
    end
    players
  end

  def read_all_data(players_filename, stats_filename,team_code,year)
    players = read_player_details(players_filename)
    players, team_data = read_player_stats(stats_filename,players,team_code,year)
    return players, team_data
  end

end

end