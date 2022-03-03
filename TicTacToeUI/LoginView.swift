//
//  LoginView.swift
//  TicTacToeUI
//
//  Created by Riandro Proença on 23/02/22.
//

import SwiftUI

struct LoginView : View {
    
    @State var username: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                TextView()
                TextField("Nome", text: $username)
                    .padding()
                    .background(UIColor.lightGreyColor)
                    .cornerRadius(5.0)
                    .padding([.bottom, .trailing, .leading], 20)
                NavigationLink(destination: GameView()) {
                    LoginButtonContent()
                }
            }
        }
    }
}
   

struct TextView: View {
    var body: some View {
        Text("Jogo Da Velha!")
            .font(.largeTitle)
            .fontWeight(.semibold)
            .padding(.bottom, 40)
            .offset(y: -200)
        
    }
}

struct LoginButtonContent : View {
    var body: some View {
        return Text("Jogar")
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(width: 220, height: 60)
            .background(Color.green)
            .cornerRadius(15.0)
    }
}

struct UIColor  {
    static let lightGreyColor = Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0)
}

