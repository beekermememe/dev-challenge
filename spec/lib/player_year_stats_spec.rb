require "spec_helper"
require 'player_year_stat'

describe "PlayerYearStat" do
  it "should assign the model attribs on initialization" do
    player_stat = PlayerYearStat.new({year: 2011, games: 2})
    expect(player_stat.year).to eq(2011)
    expect(player_stat.games).to eq(2)
  end

  it "should assign slugging percentage to zero if no at bats" do
    player_stat = PlayerYearStat.new({year: 2011, games: 2})
    expect(player_stat.slugging_percentage).to eq(0.0)
  end

  it "should assign batting average to zero if no at bats" do
    player_stat = PlayerYearStat.new({year: 2011, games: 2})
    expect(player_stat.batting_average).to eq(0.0)
  end

  it "should calculate the players batting average correctly" do
    data = "abreubo01",2010,"AL","LAA",154,573,88,146,41,1,20,78,24,10
    player_stat = PlayerYearStat.new({
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
    expect(player_stat.at_bats).to eq 573
    expect(player_stat.hits).to eq 146
    expect(player_stat.batting_average).to eq 0.2547993019197208
  end

  it "should calculate the players slugging_percentage correctly" do
    data = ["abreubo01",2010,"AL","LAA",154,573,88,146,41,1,20,78,24,10]
    player_stat = PlayerYearStat.new({
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
    expect(player_stat.slugging_percentage).to eq 0.43455497382198954
  end

end