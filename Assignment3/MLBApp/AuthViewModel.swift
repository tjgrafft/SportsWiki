//
//  AuthViewModel.swift
//  Assignment3
//
//  Created by Taylor Grafft on 4/25/23.
//
import SwiftUI
import FirebaseAuth

class AuthViewModel: ObservableObject {
    
    @Published var isLoggedIn: Bool = false
    var onLoggedIn: (() -> Void)?
    
    // Log in
    func signIn(withEmail email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }

    // Sign up
    func signUp(withEmail email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }

    // Log out
    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            print("Error signing out: \(error.localizedDescription)")
        }
    }
}


