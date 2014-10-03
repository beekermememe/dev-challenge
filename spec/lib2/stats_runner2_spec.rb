require "spec_helper"
require 'stats_reader2'

describe "StatsReader2" do

  context "opening file" do
    it "should open the file passed for stats data" do
      players, team_data = StatsReader2.read_player_stats("#{Dir.pwd}/spec/resources/test_stats_file.csv",{},"LAA","2011")
      expect(players.count).to eq 1
      expect(players["abreubo01"].playerid).to eq "abreubo01"
      expect(team_data[0].teamid).to eq "LAA"
      expect(team_data[0].yearid).to eq "2011"
    end

    it "should open the file passed for stats data" do
      new_data = StatsReader2.read_player_details("#{Dir.pwd}/spec/resources/test_players_file.csv")
      expect(new_data.count).to eq 1
      expect(new_data["aaronha01"].playerid).to eq "aaronha01"
    end
  end
end