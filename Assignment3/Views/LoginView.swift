//
//  LoginView.swift
//  Assignment3
//
//  Created by Taylor Grafft on 4/25/23.
//

import SwiftUI
import FirebaseAuth

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var errorText: String = ""
    @EnvironmentObject var authViewModel: AuthViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            ZStack {
                Image("background")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Text("Login")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.bottom, 50)

                    VStack(alignment: .leading, spacing: 15) {
                        Text("Email")
                            .foregroundColor(.white)
                        TextField("Email", text: $email)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(5)
                        
                        Text("Password")
                            .foregroundColor(.white)
                        SecureField("Password", text: $password)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(5)
                    }
                    .padding(.horizontal, 32)
                    
                    if !errorText.isEmpty {
                        Text(errorText)
                            .foregroundColor(.red)
                            .padding(.top, 8)
                    }
                    
                    Button(action: {
                        loginUser()
                    }) {
                        Text("Log In")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.red)
                            .cornerRadius(5)
                    }
                    .padding(.top, 24)
                    .padding(.horizontal, 32)
                    
                    //Spacer()
                    
                    Button(action: {
                        signUpUser()
                    }) {
                        Text("Sign Up")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.black)
                            .cornerRadius(5)
                    }
                    .padding(.top, 8)
                    .padding(.horizontal, 32)

                    Spacer()
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    private func loginUser() {
        authViewModel.signIn(withEmail: email, password: password) { result in
            switch result {
            case .success():
                // Navigate to the PlayerListView
                authViewModel.isLoggedIn = true
            case .failure(let error):
                // Show an error message
                errorText = error.localizedDescription
            }
        }
    }
    
    private func signUpUser() {
        authViewModel.signUp(withEmail: email, password: password) { result in
            switch result {
            case .success():
                // Navigate to the PlayerListView
                authViewModel.isLoggedIn = true
            case .failure(let error):
                // Show an error message
                errorText = error.localizedDescription
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(AuthViewModel())
    }
}

