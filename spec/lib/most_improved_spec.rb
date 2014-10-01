require "spec_helper.rb"
require "most_improved"
require "player_year_stat"

describe "MostImproved" do

  let(:player1) { 
    data = "abreubo01",2009,"AL","LAA",154,500,250,250,41,1,20,78,24,10
    player_stat1 = PlayerYearStat.new({
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
    data = "abreubo01",2010,"AL","LAA",154,300,300,300,41,1,20,78,24,10
    player_stat2 = PlayerYearStat.new({
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
    Player.new("Abe","Reub",1975,[player_stat1,player_stat2])
  }
  it "should return if the player is eligible" do
    expect(MostImproved.is_player_eligible_for_most_improved?(player1,2010,2009)).to eq true
    expect(MostImproved.is_player_eligible_for_most_improved?(player1,2011,2010)).to eq false
  end

  it "should return the improvement of the player from year to year" do
    expect(MostImproved.get_improvement(player1,2010,2009)).to eq 0.5
  end

  it "should return the player with the most improvement for the year" do
    expect(MostImproved.get_best_for_year([player1],2010,2009)[0].name).to eq(player1.name)
    expect(MostImproved.get_best_for_year([player1],2011,2010)).to eq([])
  end

  it "should create a lookup table with all the best players for each year" do
    MostImproved.stubs(:get_best_for_year).returns([player1])
    MostImproved.stubs(:is_player_eligible_for_most_improved?).returns(true)
    MostImproved.stubs(:get_improvement).returns(1)
    data = MostImproved.create_most_improved_lookup([player1])
    expect(data.count).to eq 15
    data.each do |year,player|
      expect(player.name).to eq player1.name
    end
  end
end