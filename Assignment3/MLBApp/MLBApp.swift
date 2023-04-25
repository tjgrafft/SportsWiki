//
// Assignment3App.swift : Assignment3
//
// Copyright © 2023 Auburn University.
// All Rights Reserved.


import SwiftUI
import FirebaseCore
import FirebaseAuth

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct MLBApp: App {
    @StateObject private var dataProvider = MLBViewModel()
    @StateObject private var authViewModel = AuthViewModel()
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @Environment(\.scenePhase) private var scenePhase


    var body: some Scene {
        WindowGroup {
            if authViewModel.isLoggedIn {
                PlayerListView()
                    .environmentObject(dataProvider)
                    .environmentObject(authViewModel)
            } else {
                LoginView()
                    .environmentObject(authViewModel)
            }
        }
        .onChange(of: scenePhase) { newScenePhase in
            if newScenePhase == .active {
                configureAuthListener()
            }
        }
    }

    private func configureAuthListener() {
        Auth.auth().addStateDidChangeListener { auth, user in
            authViewModel.isLoggedIn = user != nil
        }
    }
}


