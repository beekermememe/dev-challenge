require "spec_helper.rb"
require "triple_crown"

describe "TripleCrown" do

  let(:player1) {
    player_stats1 = PlayerYearStat.new({
      :year => 2010,
      :league => "AL",
      :runs_batted_in => 300,
      :at_bats => 500,
      :hits => 420,
      :home_runs => 300
      })
    Player.new("I","Win",1987,[player_stats1])
  }

  let(:player2) {
    player_stats2 = PlayerYearStat.new({
      :year => 2010,
      :league => "AL",
      :runs_batted_in => 300,
      :at_bats => 500,
      :hits => 405,
      :home_runs => 299
      })
    Player.new("I","Do Not Win",1987,[player_stats2])
  }

  let(:player3) {
    player_stats3 = PlayerYearStat.new({
      :year => 2010,
      :league => "AL",
      :runs_batted_in => 200,
      :at_bats => 500,
      :hits => 400,
      :home_runs => 300
      })
    Player.new("I","Do Not Win",1987,[player_stats3])
  }

  it "should get the highest home run winner for a year" do

  end
  it "should seperate players into different leagues per year" do
    al_league, nl_league = TripleCrown.find_candidates_for_each_year([player1,player3,player2])
    expect(nl_league).to eq nl_league
    expect(al_league).to eq({ 2010 => [player1,player3,player2]})
  end

  it "should get the best batters for a year" do
    winner = TripleCrown.get_best_batters([player1,player3,player2],2010)
    expect(winner).to eq [player1]
  end

  it "should get the highest rbi winner for a year" do
    winner = TripleCrown.get_best_rbi_ers([player1,player3,player2],2010)
    expect(winner).to eq [player1,player2]
  end

  it "should get the highest batters for a year" do
    winner = TripleCrown.get_best_batters([player1,player3,player2],2010)
    expect(winner).to eq [player1]
  end

  it "should return the triple_crown winner" do
    tc_winner= TripleCrown.find_triple_crown_winners({2010 => [player1,player3,player2]})
    expect(tc_winner).to eq({2010 => [player1]})
  end
end