//
// ContentView.swift : Assignment3
//
// Copyright © 2023 Auburn University.
// All Rights Reserved.


import SwiftUI

struct PlayerListView: View {
    @EnvironmentObject var dataProvider: MLBViewModel
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var searchQuery: String = ""

    var body: some View {
        NavigationView {
            VStack {
                Text("Search for sports figures")
                    .font(.headline)
                    .padding(.bottom, 8)

                HStack {
                    TextFieldWithClearButton(placeholder: "Enter last name", text: $searchQuery)
//                    TextField("Enter last name", text: $searchQuery)
//                        .padding(8)
//                        .background(Color(.systemGray6))
//                        .cornerRadius(8)
//                        .overlay(
//                            RoundedRectangle(cornerRadius: 8)
//                                .stroke(Color(.systemGray3), lineWidth: 1)
//                        )

                    Button(action: {
                        dataProvider.fetchPlayers(searchQuery: searchQuery)
                    }) {
                        Image(systemName: "magnifyingglass")
                            .font(.title)
                            .foregroundColor(.primary)
                    }
                }
                .padding(.bottom, 16)

                List(dataProvider.players) { player in
                    NavigationLink(destination: PlayerStatsView(player: player).environmentObject(dataProvider)) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(player.strPlayer)
                                .font(.headline)
                            Text("\(player.strPosition ?? "Unknown Position") | \(player.strTeam ?? "Unknown Team")")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
            .padding()
            .navigationTitle("Sports Wiki")
            .navigationBarItems(trailing: Button(action: {
                authViewModel.signOut()
            }, label: {
                Text("Sign Out")
            }))
        }
    }
}

struct TextFieldWithClearButton: View {
    var placeholder: String
    @Binding var text: String

    var body: some View {
        TextField(placeholder, text: $text)
            .padding(8)
            .background(Color(.systemGray6))
            .cornerRadius(8)
            .overlay(
                HStack {
                    Spacer()
                    if !text.isEmpty {
                        Button(action: {
                            text = ""
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.gray)
                                .padding(.trailing, 8)
                        }
                    }
                }
            )
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color(.systemGray3), lineWidth: 1)
            )
    }
}


//import SwiftUI
//
//struct PlayerListView: View {
//    @EnvironmentObject var dataProvider : MLBViewModel
//    @State private var searchQuery: String = ""
//
//    var body: some View {
//        NavigationView {
//            VStack {
//                Text("Search for sports figures by last name")
//                    .font(.headline)
//                    .padding(.bottom, 8)
//
//                HStack {
//                    TextField("Enter last name", text: $searchQuery)
//                        .textFieldStyle(RoundedBorderTextFieldStyle())
//
//                    Button(action: {
//                        dataProvider.fetchPlayers(searchQuery: searchQuery)
//                    }) {
//                        Image(systemName: "magnifyingglass")
//                            .font(.title)
//                            .foregroundColor(.primary)
//                    }
//                }
//                .padding(.bottom, 16)
//
//                List(dataProvider.players) { player in
//                    NavigationLink(destination: PlayerStatsView(player: player).environmentObject(dataProvider)) {
//                        Text(player.strPlayer)
//                    }
//                }
//            }
//            .padding()
//            .navigationTitle("Players")
//        }
//    }
//}
//
//
struct PlayerListView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerListView()
            .environmentObject(MLBViewModel())
    }
}
