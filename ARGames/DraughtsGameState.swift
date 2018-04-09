//
//  DraughtsGameState.swift
//  ARGames
//
//  Created by james atkinson on 09/04/2018.
//  Copyright © 2018 james atkinson. All rights reserved.
//

import Foundation

class DraughtsGameState: GameState{
    
    override init(rows: Int = 0, columns: Int = 0){
        super.init(rows: rows, columns: columns)
        print(rows)
        print(columns)
        super.currentBoardState = Array(repeating: 0, count: (rows*columns))
        print(super.currentBoardState)
    }
    
    func isLegal(to:Int) -> Bool{
        print(to)
        print(super.currentBoardState)
        if(super.currentBoardState[to] == 0){
            return true
        }else{
            return false
        }
    }
    
    func addPiece(to: Int) {
        super.currentBoardState[to] = super.currentPlayer
        playerWon()
    }
    
    //win condition
    func playerWon(){
        
        for c in stride(from: 0, to: (rows*columns)-1, by: columns){
            //check horizontal victory
            if(currentBoardState[c] != 0 &&
                currentBoardState[c] == currentBoardState[c+1] &&
                currentBoardState[c+1] == currentBoardState[c+2]){
                print("h")
                isWinner = true
            }
        }
        for r in 0..<rows{
            //check vertical victory
            if(currentBoardState[r] != 0 &&
                currentBoardState[r] == currentBoardState[r+rows] &&
                currentBoardState[r+rows] == currentBoardState[r+(rows*2)]){
                print("v")
                isWinner = true
            }
        }
        //check bottom left - top right victory
        if(currentBoardState[0] != 0 &&
            currentBoardState[0] == currentBoardState[4] &&
            currentBoardState[4] == currentBoardState[8]){
            print("d1")
            isWinner = true
        }
        //check top left - bottom right victory
        if(currentBoardState[6] != 0 &&
            currentBoardState[6] == currentBoardState[4] &&
            currentBoardState[4] == currentBoardState[2]){
            print("d2")
            isWinner = true
        }
        print("\(isWinner)")
        if(!isWinner){
            print("change player")
            changePlayer()
        }
    }
    //changes the current player
    func changePlayer(){
        if(super.currentPlayer == 1){
            super.currentPlayer = 2
        }else{
            super.currentPlayer = 1
        }
    }
    
}
