require "spec_helper"

describe "Team" do
  let(:team) { Team.new("LAA")}
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

  it "should have a team_code" do
    expect(team.team_code).to eq "LAA"
  end

  it "should have stats" do
     expect(team.stats).to eq({})
  end

  it "should update the team with player batting average stats" do
     team.update_team_stats_data(player_stat)
     expect(team.stats[2010].count).to eq 1
     expect(team.stats[2010][0]).to eq player_stat.batting_average
  end

  it "should return the batting average of the entire team" do
    team.update_team_stats_data(player_stat)
    expect(team.get_batting_average(player_stat.year)).to eq "The batting average for LAA for 2010 was #{player_stat.batting_average}%"
  end

  it "should return an error message if there is not batting average avail" do
    expect(team.get_batting_average(player_stat.year)).to eq "No stats for LAA in 2010"
  end

end