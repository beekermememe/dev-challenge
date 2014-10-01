require "spec_helper"
require "runner"

describe "Runner" do

  let(:runner) { Runner.new}

  it "should get the player stats" do
    StatsReader.expects(:read_stats_data).returns({stats: "here"})
    StatsReader.stubs(:read_player_data).returns({players: "here"})
    runner.build_player_data
  end

  it "should get the team stats" do
    TeamStats.any_instance.expects(:build_team_stats).with([]).returns(teamstats: "here")
    runner.extract_team_data([])
  end

  it "should get the triple crown stats" do

  end

  it "should get the most improved stats" do

  end

  it "should get player slugging percentages by team and year" do

  end
end