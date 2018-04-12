//
//  DraughtsGameState.swift
//  ARGames
//
//  Created by james atkinson on 09/04/2018.
//  Copyright © 2018 james atkinson. All rights reserved.
//

import Foundation

class DraughtsGameState: GameState{
    
    var possibleMoves: [Int]
    var possibleToRemove: [Int]
    var toRemove: [Int]
    
    override init(rows: Int = 0, columns: Int = 0){
        possibleMoves = []
        possibleToRemove = []
        toRemove = []
        super.init(rows: rows, columns: columns)
        currentBoardState = Array(repeating: 0, count: (rows*columns))
    }
    
    func isLegal(to:Int) -> Bool{
        if(super.currentBoardState[to] == 0){
            return true
        }else{
            return false
        }
    }
    
    func isLegal(from:Int,to:Int) -> Bool{
        for i in 0..<possibleMoves.count{
            if(currentPlayer == typeToPlayer(type: currentBoardState[from])){
                if(possibleMoves[i] == to){
                    return true
                }
            }
        }
        return false
    }
    func checkOneStepLeft(from: Int) -> Bool{
        return (from-1)%columns != (columns - 1)
    }
    func checkOneStepRight(from: Int) -> Bool{
        return (from+1)%columns != 0
    }
    func checkOneStepForward(from: Int) -> Bool{
        return (from+columns) < (rows*columns)
    }
    func checkOneStepBackward(from: Int) -> Bool{
        return (from-columns) > 0
    }
    func checkTwoStepLeft(from: Int) -> Bool{
        return checkOneStepLeft(from:from) && (from-2)%columns != (columns - 1)
    }
    func checkTwoStepRight(from: Int) -> Bool{
        return checkOneStepRight(from:from) && (from+2)%columns != (columns - 1)
    }
    func checkTwoStepForward(from: Int) -> Bool{
        return checkOneStepForward(from: from) && (from+(2*columns)) < (rows*columns)
    }
    func checkTwoStepBackward(from: Int) -> Bool{
        return checkOneStepBackward(from: from) && (from-(2*columns)) > 0
    }
    
    func initialMoveForward(from: Int, type: Int){
        print("initial from: \(from)")
        if(checkOneStepForward(from: from)){
            if(currentBoardState[(from+rows) - 1] != 0 && currentBoardState[(from+rows) - 1] != type && currentBoardState[(from+(2*rows) - 2)] == 0){
                possibleToRemove += [(from+rows) - 1]
                recursiveJumpForward(from: (from+(2*rows)) - 2, type: type)
            }else if(checkOneStepLeft(from: from) && checkOneStepForward(from: from) && currentBoardState[(from+rows) - 1] == 0 ){
                possibleMoves += [(from+rows-1)]
            }
            if(currentBoardState[(from+rows) + 1] != 0 && currentBoardState[(from+rows) + 1] != type && currentBoardState[(from+(2*rows) + 2)] == 0){
                possibleToRemove += [(from+rows) + 1]
               recursiveJumpForward(from: (from+(2*rows)) + 2, type: type)
            }else if(checkOneStepRight(from: from) && checkOneStepForward(from: from) && currentBoardState[(from+rows) + 1] == 0 ){
                possibleMoves += [(from+rows+1)]
            }
        }
    }
    
    func recursiveJumpForward(from: Int, type: Int){
        print("recursive from: \(from)")
        if(currentBoardState[from] == 0){
            possibleMoves += [from]
        }
        if(checkTwoStepForward(from: from)){
                if(currentBoardState[(from+rows) - 1] != type && currentBoardState[(from+rows) - 1] != 0){
                    possibleToRemove += [(from+rows) - 1]
                    recursiveJumpForward(from: (from+(2*rows) - 2), type: type)
                }
                if(currentBoardState[(from+rows) + 1] != type && currentBoardState[(from+rows) + 1] != 0){
                    possibleToRemove += [(from+rows) + 1]
                    recursiveJumpForward(from: (from+(2*rows) + 2), type: type)
                }
        }
    }
    
    func initialMoveBackward(from: Int, type: Int){
        print("initial from: \(from)")
        if(checkOneStepBackward(from: from)){
            if(currentBoardState[(from-rows) - 1] != 0 && currentBoardState[(from-rows) - 1] != type &&
                currentBoardState[(from-(2*rows) - 2)] == 0){
                possibleToRemove += [(from-rows) - 1]
                recursiveJumpBackward(from: (from-(2*rows)) - 2, type: type)
            }else if(checkOneStepLeft(from: from) && checkOneStepBackward(from: from) && currentBoardState[(from-rows) - 1] == 0){
                possibleMoves += [(from-rows-1)]
            }
            if(currentBoardState[(from-rows) + 1] != 0 && currentBoardState[(from-rows) + 1] != type &&
                currentBoardState[(from-(2*rows) + 2)] == 0){
                possibleToRemove += [(from-rows) + 1]
                recursiveJumpBackward(from: (from-(2*rows)) + 2, type: type)
            }else if(checkOneStepRight(from: from) && checkOneStepBackward(from: from) && currentBoardState[(from-rows) + 1] == 0){
                possibleMoves += [(from-rows+1)]
            }
        }
    }
    
    func recursiveJumpBackward(from: Int, type: Int){
        print("recursive from: \(from)")
        if(currentBoardState[from] == 0 ){
            possibleMoves += [from]
        }
        if(checkTwoStepBackward(from: from)){
            if(currentBoardState[(from-rows) - 1] != type && currentBoardState[(from-rows) - 1] != 0){
                possibleToRemove += [(from-rows) - 1]
                recursiveJumpBackward(from: (from-(2*rows) - 2), type: type)
            }
            if(currentBoardState[(from-rows) + 1] != type && currentBoardState[(from-rows) + 1] != 0){
                possibleToRemove += [(from-rows) + 1]
                recursiveJumpBackward(from: (from-(2*rows) + 2), type: type)
            }
        }
    }
    
    func initialMoveKing(from: Int, type: Int){
        if(checkOneStepForward(from: from)){
            if(currentBoardState[(from+rows) - 1] != 0 && currentBoardState[(from+rows) - 1] != type && currentBoardState[(from+(2*rows) - 2)] == 0){
                possibleToRemove += [(from+rows) - 1]
                //recursiveJumpKing(from: (from+(2*rows)) - 2, type: type)
            }else if(checkOneStepLeft(from: from) && checkOneStepForward(from: from) && currentBoardState[(from+rows) - 1] == 0 ){
                possibleMoves += [(from+rows-1)]
            }
            if(currentBoardState[(from+rows) + 1] != 0 && currentBoardState[(from+rows) + 1] != type && currentBoardState[(from+(2*rows) + 2)] == 0){
                possibleToRemove += [(from+rows) + 1]
                //recursiveJumpKing(from: (from+(2*rows)) + 2, type: type)
            }else if(checkOneStepRight(from: from) && checkOneStepForward(from: from) && currentBoardState[(from+rows) + 1] == 0 ){
                possibleMoves += [(from+rows+1)]
            }
        }
        if(checkOneStepBackward(from: from)){
            if(currentBoardState[(from-rows) - 1] != 0 && currentBoardState[(from-rows) - 1] != type &&
                currentBoardState[(from-(2*rows) - 2)] == 0){
                possibleToRemove += [(from-rows) - 1]
                recursiveJumpKing(previous: from,from: (from-(2*rows)) - 2, type: type)
            }else if(checkOneStepLeft(from: from) && checkOneStepBackward(from: from) && currentBoardState[(from-rows) - 1] == 0){
                possibleMoves += [(from-rows-1)]
            }
            if(currentBoardState[(from-rows) + 1] != 0 && currentBoardState[(from-rows) + 1] != type &&
                currentBoardState[(from-(2*rows) + 2)] == 0){
                possibleToRemove += [(from-rows) + 1]
                //recursiveJumpKing(from: (from-(2*rows)) + 2, type: type)
            }else if(checkOneStepRight(from: from) && checkOneStepBackward(from: from) && currentBoardState[(from-rows) + 1] == 0){
                possibleMoves += [(from-rows+1)]
            }
        }
    }
    func recursiveJumpKing(previous: Int,from: Int, type: Int){
        if(currentBoardState[from] == 0){
            possibleMoves += [from]
        }
        if(checkTwoStepForward(from: from)){
            if(checkTwoStepLeft(from:from) && currentBoardState[(from+rows) - 1] != type && currentBoardState[(from+rows) - 1] != 0 && (from+(2*rows)-1) != previous){
                possibleToRemove += [(from+rows) - 1]
                recursiveJumpKing(previous: from, from: (from+(2*rows) - 2), type: type)
            }
            if(checkTwoStepRight(from:from) && currentBoardState[(from+rows) + 1] != type && currentBoardState[(from+rows) + 1] != 0 && (from+(2*rows)+1) != previous){
                possibleToRemove += [(from+rows) + 1]
                recursiveJumpKing(previous: from,from: (from+(2*rows) + 2), type: type)
            }
        }
        if(checkTwoStepBackward(from: from)){
            if(checkTwoStepLeft(from:from) && currentBoardState[(from-rows) - 1] != type && currentBoardState[(from-rows) - 1] != 0 && (from-(2*rows)-1) != previous){
                possibleToRemove += [(from-rows) - 1]
                recursiveJumpKing(previous: from,from: (from-(2*rows) - 2), type: type)
            }
            if(checkTwoStepRight(from:from) && currentBoardState[(from-rows) + 1] != type && currentBoardState[(from-rows) + 1] != 0 && (from-(2*rows)+1) != previous){
                possibleToRemove += [(from-rows) + 1]
                recursiveJumpKing(previous: from,from: (from-(2*rows) + 2), type: type)
            }
        }
    }
    
    func generatePossibleMoves(from: Int){
        print("--- generatePossibleMove ---")
        switch currentBoardState[from]{
        case 0:
            print("empty")
        case 1:
            initialMoveForward(from: from, type: typeToPlayer(type: currentBoardState[from]))
            print("white draught")
        case 2:
            initialMoveBackward(from: from, type: typeToPlayer(type: currentBoardState[from]))
            print("black draught")
        case 3:
            initialMoveKing(from: from, type: typeToPlayer(type: currentBoardState[from]))
            print("white draught king")
        case 4:
            initialMoveKing(from: from,type: typeToPlayer(type: currentBoardState[from]))
            print("black draught king")
        default:
            print("hmmmm")
        }
    }
    
    func removePiece(from: Int,to: Int){
        var current = to
        while(current != from){
            for i in 0..<possibleToRemove.count{
                if((current-columns-1) == possibleToRemove[i]){
                    toRemove += [current-columns-1]
                    current = (current-(2*columns)) - 2
                }else if((current-columns+1) == possibleToRemove[i]){
                    toRemove += [current-columns+1]
                    current = (current-(2*columns)) + 2
                }else if((current+columns-1) == possibleToRemove[i]){
                    toRemove += [current+columns-1]
                    current = (current+(2*columns)) - 2
                }else if((current+columns+1) == possibleToRemove[i]){
                    toRemove += [current+columns+1]
                    current = (current+(2*columns)) + 2
                }
            }
        }
    }
    func removePieceBackward(from: Int,to: Int){
        var current = to
        while(current != from){
            for i in 0..<possibleToRemove.count{
                if((current+columns-1) == possibleToRemove[i]){
                    toRemove += [current+columns-1]
                    current = (current+(2*columns)) - 2
                }else if((current+columns+1) == possibleToRemove[i]){
                    toRemove += [current+columns+1]
                    current = (current+(2*columns)) + 2
                }
            }
        }
    }
    
    func removePieces(){
        if(toRemove != []){
            for i in 0..<toRemove.count{
                currentBoardState[toRemove[i]] = 0
            }
        }
    }
    
    func addPiece(to: Int, type: Int) -> Bool{
        let legal = isLegal(to: to)
        if(legal){
            currentBoardState[to] = type
            //playerWon()
        }
        return legal
    }
    
    func movePiece(from: Int, to: Int) -> Bool{
        let legal = isLegal(from: from, to: to)
        if(legal){
            let type = currentBoardState[from]
            if(typeToPlayer(type: type) == 1 && to >= ((rows-1)*columns)){
                currentBoardState[from] = 0
                addPiece(to: to, type: 3)
            }else if(typeToPlayer(type: type) == 2 && to < columns){
                currentBoardState[from] = 0
                addPiece(to: to, type: 4)
            }else{
                currentBoardState[from] = 0
                currentBoardState[to] = type
            }
            playerWon()
        }
        return legal
    }
    //win condition
    func playerWon(){
        var whitePieces = 0
        var blackPieces = 0
        
        for i in 0..<currentBoardState.count{
            if(typeToPlayer(type: currentBoardState[i])==1){
                whitePieces += 1
            }else if(typeToPlayer(type: currentBoardState[i])==2){
                blackPieces += 1
            }
        }
        if(whitePieces == 0 || blackPieces == 0){
            print("none of one piece")
            isWinner = true
        }
        print("Player \(currentPlayer): \(isWinner)")
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
    func typeToPlayer(type: Int) -> Int{
        if(type == 1 || type == 3){
            return 1
        }
        return 2
    }
    
}
