//
//  GameViewModel.swift
//  TicTacToeUI
//
//  Created by Riandro Proença on 22/02/22.
//

import SwiftUI
final class GameViewModel: ObservableObject {
    
    @Published var moves: [Move?]  = Array(repeating: nil, count: 9)
    @Published var isGameBoardDisable = false
    @Published var alertItem: AlertItem?
        
    let columns: [GridItem] = [GridItem(.flexible()),
                               GridItem(.flexible()),
                               GridItem(.flexible()),]
    
    func processPlayerMove(for position: Int) {
        if isSquareOcupaed(in: moves, forIndex: position) { return }
        moves[position] = Move(player:  .human, boardIndex: position)
        
        // logica para vitoria, empate ou derrota
        if checkWinCondition(for: .human, in: moves) {
            alertItem = AlertContext.humanWin
            return
        }
        
        if checkForDraw(in: moves) {
            alertItem = AlertContext.draw
            return
        }
        isGameBoardDisable = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5 ) { [self] in
            let computerPosition = determinComputerMovePosition(in: moves)
            moves[computerPosition] = Move(player:  .computer, boardIndex: computerPosition)
            isGameBoardDisable = false
            
            if checkWinCondition(for: .computer, in: moves) {
                alertItem = AlertContext.computerWin
                return
            }
            if checkForDraw(in: moves) {
                alertItem = AlertContext.draw
                return
            }
        }
    }
    
    func isSquareOcupaed(in moves:[Move?], forIndex index: Int) -> Bool {
        return moves.contains(where: { $0?.boardIndex == index })
    }
    
    func determinComputerMovePosition(in moves: [Move?]) -> Int {
        
        // se o IA conseguir vencer ela ira ganhar
        let winPatterns: Set<Set<Int>> = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
        
        let computerMoves = moves.compactMap { $0 }.filter { $0.player == .computer }
        let computerPositions = Set(computerMoves.map { $0.boardIndex })
        
        for pattern in winPatterns {
            let winPositions = pattern.subtracting(computerPositions)
            
            if winPositions.count == 1 {
                let isAlavailable = !isSquareOcupaed(in: moves, forIndex: winPositions.first!)
                if isAlavailable { return winPositions.first! }
            }
        }
        // se o IA nao conseguir finalizar o jogo ela ira bloquear
        let humanMoves = moves.compactMap { $0 }.filter { $0.player == .human }
        let humanPositions = Set(humanMoves.map { $0.boardIndex })
        
        for pattern in winPatterns {
            let winPositions = pattern.subtracting(humanPositions)
            
            if winPositions.count == 1 {
                let isAlavailable = !isSquareOcupaed(in: moves, forIndex: winPositions.first!)
                if isAlavailable { return winPositions.first! }
            }
        }
        // sempre pegar o block do meio
        let middleSquare = 4
        if !isSquareOcupaed(in: moves, forIndex: middleSquare) {
            return middleSquare
        }
        
        
        // se o IA nao conseguir pegar a possicao 5 ela pegara uma possicao alearoria
        var movePosition = Int.random(in: 0..<9)
        while isSquareOcupaed(in: moves, forIndex: movePosition) {
            movePosition = Int.random(in: 0..<9)
        }
        return movePosition
    }
    func checkWinCondition(for player: Player, in moves:[Move?]) -> Bool {
        let winPatterns: Set<Set<Int>> = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
        
        let playerMoves = moves.compactMap({ $0 }).filter { $0.player == player }
        let playerPositions = Set(playerMoves.map { $0.boardIndex })
        
        for pattern in winPatterns where pattern.isSubset(of: playerPositions) {return true}
        return false
    }
    func checkForDraw(in moves: [Move?]) -> Bool {
        return moves.compactMap { $0 }.count == 9
        
    }
    func resetGame() {
        moves = Array(repeating: nil, count: 9)
    }
}
