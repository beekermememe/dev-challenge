require 'team_stats'
require 'player'
require 'player_year_stat'

describe "TeamStats" do
  let(:team_stats) { TeamStats.new() }
  let(:player_stat) { 
    data = "abreubo01",2010,"AL","LAA",154,573,88,146,41,1,20,78,24,10
    PlayerYearStat.new({
      year: data[1],
      league: data[2],
      team_id: data[3],
      games: data[4].to_i,
      at_bats: data[5].to_i,
      runs: data[6].to_i,
      hits: data[7].to_i,
      two_base_hit: data[8].to_i,
      three_base_hit: data[9].to_i,
      home_runs: data[10].to_i,
      runs_batted_in: data[11].to_i
    })
  }


  it "should have teams" do
    expect(team_stats.teams).to eq({})
  end

  it "should build a team from player data" do
    player = Player.new("A","Brebuo",1977,[player_stat])
    team_stat = team_stats.extract_and_update_team_stat_from_player_info(player,{})
    expect(team_stat["LAA"].class).to eq Team
  end
end