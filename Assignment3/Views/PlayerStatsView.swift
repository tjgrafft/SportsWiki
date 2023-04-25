//
//  PlayerStatsView.swift
//  Assignment3
//
//  Created by Taylor Grafft on 3/26/23.
//

import SwiftUI

//New PlayerStatsView with new API endpoint

struct PlayerStatsView: View {
    let player: Player
    @EnvironmentObject private var dataProvider: MLBViewModel
    @State private var playerStats: PlayerStats?
    @State private var milestones: [Milestone] = []
    @State private var honours: [Honour] = []
    @State private var selectedTab: Int = 0
    
    var body: some View {
        VStack {
            Picker(selection: $selectedTab, label: Text("")) {
                Text("Info").tag(0)
                Text("Milestones").tag(1)
                Text("Honours").tag(2)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)
            
            if let playerStats = playerStats {
                            if selectedTab == 0 {
                                // Player Info view
                                playerInfoView(playerStats: playerStats)
                            } else if selectedTab == 1 {
                                // Milestones view
                                milestonesView(milestones: milestones)
                            } else {
                                // Honours view
                                honoursView(honours: honours)
                            }
                        } else {
                            ProgressView()
                        }
        }
        .onAppear {
            dataProvider.fetchPlayerStats(playerID: player.idPlayer) { result in
                switch result {
                case .success(let playerStats):
                    self.playerStats = playerStats.first
                case .failure(let error):
                    print(error)
                }
            }
            
            dataProvider.fetchPlayerMilestones(playerID: player.idPlayer) { result in
                switch result {
                case .success(let milestones):
                    self.milestones = milestones
                case .failure(let error):
                    print(error)
                }
            }
            
            dataProvider.fetchPlayerHonours(playerID: player.idPlayer) { result in
                switch result {
                case .success(let honours):
                    self.honours = honours
                case .failure(let error):
                    print(error)
                }
            }
        }
        .navigationTitle(player.strPlayer)
    }
    
    private func playerInfoView(playerStats: PlayerStats) -> some View {
        ScrollView {
            VStack {
                AsyncImage(url: player.strThumb.flatMap { URL(string: $0) }) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 150, height: 150)
                .clipShape(Circle())
                .overlay(
                    Circle().stroke(Color.primary, lineWidth: 4)
                )
                .shadow(radius: 10)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(player.strPlayer)
                        .font(.title)
                    Text("\(player.strPosition ?? "Unknown Position") | \(player.strTeam ?? "Unknown Team")")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Text("\(player.strSport ?? "Unknown Sport") | \(player.strNationality ?? "Unknown Nationality")")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding(.top, 8)
                
                Divider()
                
                Text(playerStats.strDescriptionEN ?? "No description available.")
                    .padding(.top, 8)
            }
            .padding()
        }
    }
    
    private func milestonesView(milestones: [Milestone]) -> some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))]) {
                if milestones.isEmpty {
                VStack {
                    Text("No milestones")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding(.bottom, 2)
                    Text("for this player")
                        .font(.title2)
                        .fontWeight(.semibold)
                }
                .padding()
                } else {
                    ForEach(milestones) { milestone in
                        VStack {
                            AsyncImage(url: URL(string: milestone.strMilestoneLogo)) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 100, height: 100)
                            
                            Text(milestone.strMilestone)
                                .font(.headline)
                                .multilineTextAlignment(.center)
                                .padding(.top, 4)
                            
                            Text(milestone.dateMilestone)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                                .multilineTextAlignment(.center)
                                .padding(.top, 2)
                        }
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .shadow(color: Color(.black).opacity(0.1), radius: 5, x: 0, y: 5)
                    }
                }
            }
            .padding()
        }
    }
    
    private func honoursView(honours: [Honour]) -> some View {
            ScrollView {
                if honours.isEmpty {
                VStack {
                    Text("No milestones")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding(.bottom, 2)
                    Text("for this player")
                        .font(.title2)
                        .fontWeight(.semibold)
                }
                .padding()
                } else {
                LazyVStack {
                    ForEach(honours) { honour in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(honour.strHonour)
                                    .font(.headline)
                                Text("Season: \(honour.strSeason)")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                            Text(honour.strTeam)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .shadow(color: Color(.black).opacity(0.1), radius: 5, x: 0, y: 5)
                        .padding(.bottom, 8)
                    }
                }
                .padding()
            }
        }
    }
}




//struct PlayerStatsView: View {
//    let player: Player
//    @EnvironmentObject private var dataProvider: MLBViewModel
//    @State private var playerStats: PlayerStats?
//    @State private var playerMilestones: [Milestone] = []
//    @State private var selectedTab = 0
//
//    var body: some View {
//        VStack {
//            if let playerStats = playerStats {
//                ScrollView {
//                    VStack {
//                        AsyncImage(url: player.strThumb.flatMap { URL(string: $0) }) { image in
//                            image
//                                .resizable()
//                                .aspectRatio(contentMode: .fit)
//                        } placeholder: {
//                            ProgressView()
//                        }
//                        .frame(width: 150, height: 150)
//                        .clipShape(Circle())
//                        .overlay(
//                            Circle().stroke(Color.primary, lineWidth: 4)
//                        )
//                        .shadow(radius: 10)
//
//                        VStack(alignment: .leading, spacing: 8) {
//                            Text(player.strPlayer)
//                                .font(.title)
//                            Text("\(player.strPosition ?? "Unknown Position") | \(player.strTeam ?? "Unknown Team")")
//                                .font(.subheadline)
//                                .foregroundColor(.secondary)
//                            Text("\(player.strSport ?? "Unknown Sport") | \(player.strNationality ?? "Unknown Nationality")")
//                                .font(.subheadline)
//                                .foregroundColor(.secondary)
//                        }
//                        .padding(.top, 8)
//
//                        Divider()
//
//                        Text(playerStats.strDescriptionEN ?? "No description available.")
//                            .padding(.top, 8)
//                    }
//                    .padding()
//                }
//            } else {
//                ProgressView()
//            }
//        }
//        .onAppear {
//            dataProvider.fetchPlayerStats(playerID: player.idPlayer) { result in
//                switch result {
//                case .success(let playerStats):
//                    self.playerStats = playerStats.first
//                case .failure(let error):
//                    print(error)
//                }
//            }
//        }
//        .navigationTitle(player.strPlayer)
//    }
//}


//struct PlayerStatsView: View {
//    let player: Player
//    @EnvironmentObject private var dataProvider: MLBViewModel
//    @State private var playerStats: PlayerStats?
//
//    var body: some View {
//        VStack {
//            if let playerStats = playerStats {
//                VStack {
//                    AsyncImage(url: player.strThumb.flatMap { URL(string: $0) }) { image in
//                        image
//                            .resizable()
//                            .aspectRatio(contentMode: .fit)
//                    } placeholder: {
//                        ProgressView()
//                    }
//                    .frame(width: 150, height: 150)
//
//                    VStack(alignment: .leading, spacing: 8) {
//                        Text(player.strPlayer)
//                            .font(.title)
//                        Text("\(player.strPosition ?? "Unknown Position") | \(player.strTeam ?? "Unknown Team")")
//                            .font(.subheadline)
//                        Text("\(player.strSport ?? "Unknown Sport") | \(player.strNationality ?? "Unknown Nationality")")
//                            .font(.subheadline)
//                    }
//                    .padding(.top, 8)
//
//                    Divider()
//
//                    ScrollView {
//                        Text(playerStats.strDescriptionEN ?? "No description available.")
//                            .padding(.top, 8)
//                            .frame(maxWidth: .infinity, alignment: .leading)
//                    }
//                }
//                .padding()
//            } else {
//                ProgressView()
//            }
//        }
//        .onAppear {
//            dataProvider.fetchPlayerStats(playerID: player.idPlayer) { result in
//                switch result {
//                case .success(let playerStats):
//                    self.playerStats = playerStats.first
//                case .failure(let error):
//                    print(error)
//                }
//            }
//        }
//        .navigationTitle(player.strPlayer)
//    }
//}

//struct PlayerStatsView: View {
//    let player: PlayerStats
//
//    var body: some View {
//        ScrollView {
//            VStack(alignment: .leading, spacing: 8) {
//                Text("Name: \(player.strPlayer)")
//                    .font(.headline)
//
//                Text("Position: \(player.strPosition)")
//                    .font(.headline)
//
//                Text("Team: \(player.strTeam)")
//                    .font(.headline)
//
//                Text("Sport: \(player.strSport)")
//                    .font(.headline)
//
//                Text("Nationality: \(player.strNationality)")
//                    .font(.headline)
//
//                Text("Description:")
//                    .font(.headline)
//
//                Text(player.strDescriptionEN)
//                    .font(.body)
//
//                Spacer()
//
//                if let url = URL(string: player.strThumb), let imageData = try? Data(contentsOf: url), let image = UIImage(data: imageData) {
//                    Image(uiImage: image)
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 150, height: 150)
//                }
//            }
//            .padding()
//        }
//        .navigationTitle("Player Stats")
//    }
//}

//struct PlayerStatsView: View {
//    let player: Player
//    @StateObject private var dataProvider = MLBViewModel()
//    @State private var playerStats: PlayerStats?
//
//    var body: some View {
//        VStack {
//            if let stats = playerStats {
//                VStack(alignment: .leading) {
//                    Text("Average: \(stats.avg)")
//                    Text("Slugging Percentage: \(stats.slg)")
//                    Text("OPS: \(stats.ops)")
//                    Text("Homeruns: \(stats.hr)")
//                    Text("RBIs: \(stats.rbi)")
//                    Text("Runs: \(stats.r)")
//                }
//                .padding()
//            } else {
//                Text("Loading player stats...")
//                    .padding()
//            }
//        }
//        .navigationTitle(player.fullName)
//        .onAppear {
//            dataProvider.fetchPlayerStats(playerID: player.id) { stats in
//                playerStats = stats
//            }
//        }
//    }
//}

//struct PlayerStatsView_Previews: PreviewProvider {
//    static var previews: some View {
//        PlayerStatsView(player: Player(id: 0, fullName: "Sample Player"))
//    }
//}
