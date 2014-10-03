require "spec_helper"
require "runner2"

describe "Runner" do

  let(:runner) { Runner2.new}

  it "should return the players and teams" do
    runner.run_tasks("#{Dir.pwd}/spec/resources/test_players_file.csv", "#{Dir.pwd}/spec/resources/test_stats_file.csv","LAA","2011")
  end
end

