require "spec_helper.rb"
require "player"

describe "Player" do
  let(:player) { Player.new("John", "Doe", 1934, []) }

  let(:player2) { Player.new("John", "Doe", 1934, [PlayerYearStat.new({:year => 2010, :games => 1})]) }

  it "should have a birthyear" do
    expect(player.birthyear).to eq(1934)

  end

  it "should have a name" do
    expect(player.name).to eq("John Doe")
  end

  it "should have stats" do
    expect(player.stats).to eq([])
  end

  it "should return stats for the year passed" do
    expect(player2.stats_for_year(2010).games).to eq 1
  end
end
