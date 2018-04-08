//
//  GameState.swift
//  ARGames
//
//  Created by james atkinson on 05/04/2018.
//  Copyright © 2018 james atkinson. All rights reserved.
//

import Foundation

class GameState{
    
    //CURRENT PLAYER
    var currentPlayer: Int
    //PREVIOUS TURNS
    //var previousTurns: [Int]
    //current state of board (array)
    var currentBoardState:[Int]
    //generate list of possible moves?
    //win condition
    //legal moves func
    var rows: Int
    var columns: Int
    var isWinner: Bool
    
    init(rows: Int = 0, columns: Int = 0){
        self.rows = rows
        self.columns = columns
        currentPlayer = 1
        currentBoardState = [0]
        isWinner = false
    }
    
    func addPiece(){
        
    }
    func movePiece(){
        
    }
    
}
