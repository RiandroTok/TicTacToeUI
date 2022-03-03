//
//  Alerts.swift
//  TicTacToeUI
//
//  Created by Riandro Proença on 22/02/22.
//

import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    var title: Text
    var message: Text
    var buttonTitle: Text
}
struct AlertContext {
    static let humanWin = AlertItem(title: Text("Voce Ganhou"),
                             message: Text("Parabens voce ganhou da AI"),
                             buttonTitle: Text("Jogar Novamente"))
    
    static let computerWin = AlertItem(title: Text("Voce Perdeu =("),
                                message: Text("A inteligencia Artificial ira dominar o mundo"),
                                buttonTitle: Text("Jogar novamente"))
    
    static let draw = AlertItem(title: Text("O jogo Empatou"),
                         message: Text("Empate"),
                         buttonTitle: Text("Jogar novamente"))
}
