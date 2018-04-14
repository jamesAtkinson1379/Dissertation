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
    var toRemove = 0
    var lastPieceMoved = 0
    var firstMove = true
    
    override init(rows: Int = 0, columns: Int = 0){
        possibleMoves = []
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
                print(possibleMoves[i])
                print("to: \(to)")
                print(lastPieceMoved)
                if(possibleMoves[i] == to && (lastPieceMoved == 0 || lastPieceMoved == from)){
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
        if(checkOneStepForward(from: from)){
            if(currentBoardState[(from+rows) - 1] != 0 && currentBoardState[(from+rows) - 1] != type && currentBoardState[(from+(2*rows) - 2)] == 0){
                possibleMoves += [(from+(2*rows)) - 2]
                //recursiveJumpForward(from: (from+(2*rows)) - 2, type: type)
            }else if(checkOneStepLeft(from: from) && checkOneStepForward(from: from) && currentBoardState[(from+rows) - 1] == 0 && firstMove){
                possibleMoves += [(from+rows-1)]
            }
            if(currentBoardState[(from+rows) + 1] != 0 && currentBoardState[(from+rows) + 1] != type && currentBoardState[(from+(2*rows) + 2)] == 0){
                possibleMoves += [(from+(2*rows)) + 2]
               //recursiveJumpForward(from: (from+(2*rows)) + 2, type: type)
            }else if(checkOneStepRight(from: from) && checkOneStepForward(from: from) && currentBoardState[(from+rows) + 1] == 0 && firstMove){
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
                    recursiveJumpForward(from: (from+(2*rows) - 2), type: type)
                }
                if(currentBoardState[(from+rows) + 1] != type && currentBoardState[(from+rows) + 1] != 0){
                    recursiveJumpForward(from: (from+(2*rows) + 2), type: type)
                }
        }
    }
    
    func initialMoveBackward(from: Int, type: Int){
        print("initial from: \(from)")
        if(checkOneStepBackward(from: from)){
            if(checkTwoStepBackward(from:from) && currentBoardState[(from-rows) - 1] != 0 && currentBoardState[(from-rows) - 1] != type && currentBoardState[(from-(2*rows) - 2)] == 0){
                possibleMoves += [(from-(2*rows)) - 2]
                //recursiveJumpBackward(from: (from-(2*rows)) - 2, type: type)
            }else if(checkOneStepLeft(from: from) && checkOneStepBackward(from: from) && currentBoardState[(from-rows) - 1] == 0 && firstMove){
                possibleMoves += [(from-rows-1)]
            }
            if(currentBoardState[(from-rows) + 1] != 0 && currentBoardState[(from-rows) + 1] != type &&
                currentBoardState[(from-(2*rows) + 2)] == 0){
                possibleMoves += [(from-(2*rows)) + 2]
                //recursiveJumpBackward(from: (from-(2*rows)) + 2, type: type)
            }else if(checkOneStepRight(from: from) && checkOneStepBackward(from: from) && currentBoardState[(from-rows) + 1] == 0 && firstMove){
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
                recursiveJumpBackward(from: (from-(2*rows) - 2), type: type)
            }
            if(currentBoardState[(from-rows) + 1] != type && currentBoardState[(from-rows) + 1] != 0){
                recursiveJumpBackward(from: (from-(2*rows) + 2), type: type)
            }
        }
    }
    
    func initialMoveKing(from: Int, type: Int){
        if(checkOneStepForward(from: from)){
            if(currentBoardState[(from+rows) - 1] != 0 && currentBoardState[(from+rows) - 1] != type && currentBoardState[(from+(2*rows) - 2)] == 0){
                possibleMoves += [(from+(2*rows)) - 2]
                //recursiveJumpKing(previous: from,current: (from+(2*rows)) - 2, type: type)
            }else if(checkOneStepLeft(from: from) && checkOneStepForward(from: from) && currentBoardState[(from+rows) - 1] == 0 && firstMove){
                possibleMoves += [(from+rows-1)]
            }
            if(currentBoardState[(from+rows) + 1] != 0 && currentBoardState[(from+rows) + 1] != type && currentBoardState[(from+(2*rows) + 2)] == 0){
                possibleMoves += [(from+(2*rows)) + 2]
                //recursiveJumpKing(previous: from,current: (from+(2*rows)) + 2, type: type)
            }else if(checkOneStepRight(from: from) && checkOneStepForward(from: from) && currentBoardState[(from+rows) + 1] == 0 && firstMove){
                possibleMoves += [(from+rows+1)]
            }
        }
        if(checkOneStepBackward(from: from)){
            if(currentBoardState[(from-rows) - 1] != 0 && currentBoardState[(from-rows) - 1] != type &&
                currentBoardState[(from-(2*rows) - 2)] == 0){
                possibleMoves += [(from-(2*rows)) - 2]
                //recursiveJumpKing(previous: from,current: (from-(2*rows)) - 2, type: type)
            }else if(checkOneStepLeft(from: from) && checkOneStepBackward(from: from) && currentBoardState[(from-rows) - 1] == 0 && firstMove){
                possibleMoves += [(from-rows-1)]
            }
            if(currentBoardState[(from-rows) + 1] != 0 && currentBoardState[(from-rows) + 1] != type &&
                currentBoardState[(from-(2*rows) + 2)] == 0){
                possibleMoves += [(from-(2*rows)) + 2]
                //recursiveJumpKing(previous: from,current: (from-(2*rows)) + 2, type: type)
            }else if(checkOneStepRight(from: from) && checkOneStepBackward(from: from) && currentBoardState[(from-rows) + 1] == 0 && firstMove){
                possibleMoves += [(from-rows+1)]
            }
        }
    }
    func recursiveJumpKing(previous: Int,current: Int, type: Int){
        print("previous: \(previous), current: \(current), type:\(type) ")
        print(possibleMoves)
        if(currentBoardState[current] == 0){
            possibleMoves += [current]
        }
        if(checkTwoStepForward(from: current)){
            if(checkTwoStepLeft(from: current) && currentBoardState[(current+rows) - 1] != type && currentBoardState[(current+rows) - 1] != 0 && !possibleMoves.contains(current+(2*rows)-2)){
                //recursiveJumpKing(previous: current, current: (current+(2*rows) - 2), type: type)
            }
            if(checkTwoStepRight(from:current) && currentBoardState[(current+rows) + 1] != type && currentBoardState[(current+rows) + 1] != 0 && !possibleMoves.contains(current+(2*rows)+2)){
                //recursiveJumpKing(previous: current,current: (current+(2*rows) + 2), type: type)
            }
        }
        if(checkTwoStepBackward(from: current)){
            if(checkTwoStepLeft(from:current) && currentBoardState[(current-rows) - 1] != type && currentBoardState[(current-rows) - 1] != 0 && !possibleMoves.contains(current-(2*rows)-2)){
                //recursiveJumpKing(previous: current,current: (current-(2*rows) - 2), type: type)
            }
            if(checkTwoStepRight(from:current) && currentBoardState[(current-rows) + 1] != type && currentBoardState[(current-rows) + 1] != 0 && !possibleMoves.contains(current-(2*rows)+2)){
                //recursiveJumpKing(previous: current,current: (current-(2*rows) + 2), type: type)
            }
        }
    }
    
    func generatePossibleMoves(from: Int){
        print("--- generatePossibleMove ---")
        print(possibleMoves)
        switch currentBoardState[from]{
        case 0:
            print("empty")
        case 1:
            initialMoveForward(from: from, type: typeToPlayer(type: currentBoardState[from]))
            //print("white draught")
        case 2:
            initialMoveBackward(from: from, type: typeToPlayer(type: currentBoardState[from]))
            //print("black draught")
        case 3:
            initialMoveKing(from: from, type: typeToPlayer(type: currentBoardState[from]))
            //print("white draught king")
        case 4:
            initialMoveKing(from: from,type: typeToPlayer(type: currentBoardState[from]))
            //print("black draught king")
        default:
            print("hmmmm")
        }
    }
    func removePieces(from: Int, to: Int){
        if(from+(2*columns)-2 == to){
            toRemove = from+columns-1+1
            currentBoardState[from+columns-1] = 0
        }else if(from+(2*columns)+2 == to){
            toRemove = from+columns+1+1
            currentBoardState[from+columns+1] = 0
        }else if(from-(2*columns)-2 == to){
            toRemove = from-columns-1+1
            currentBoardState[from-columns-1] = 0
        }else if(from-(2*columns)+2 == to){
            toRemove = from-columns+1+1
            currentBoardState[from-columns+1] = 0
        }else{
            toRemove = 0
        }
    }
    
    func addPiece(to: Int, type: Int) -> Bool{
        let legal = isLegal(to: to)
        if(legal){
            currentBoardState[to] = type
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
            removePieces(from: from, to: to)
            lastPieceMoved = to
            playerWon(current: to)
        }
        return legal
    }
    //win condition
    func playerWon(current: Int){
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
            possibleMoves.removeAll()
            generatePossibleMoves(from: current)
            print("first move: \(firstMove)")
            if(firstMove){
                print("change player first move")
                changePlayer()
            }else if(!firstMove && possibleMoves == []){
                print("change player second move")
                changePlayer()
            }else{
                print("player not changed")
                firstMove = false
            }

        }
    }
    //changes the current player
    func changePlayer(){
        firstMove = true
        lastPieceMoved = 0
        if(currentPlayer == 1){
            currentPlayer = 2
        }else{
            currentPlayer = 1
        }
    }
    func typeToPlayer(type: Int) -> Int{
        if(type == 1 || type == 3){
            return 1
        }
        return 2
    }
    
}
