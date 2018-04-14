//
//  Draughts.swift
//  ARGames
//
//  Created by james atkinson on 09/04/2018.
//  Copyright © 2018 james atkinson. All rights reserved.
//

import Foundation
import SceneKit

class Draughts: Board{
    
    var gameState:DraughtsGameState
    var boardMoves:[Int]
    
    init(height: Float = 0, width: Float = 0,length: Float = 0,x: Float = 0,y: Float = 0,z: Float = -0.2){
        boardMoves = []
        gameState = DraughtsGameState(rows:8,columns:8)
        super.init(rows:8,columns:8,height: height,width: width,length: length,x: x,y: y,z: z)
        print(boardNode.childNodes)
//        putPiece(to: 20, type: 3)
//        putPiece(to: 9, type: 2)
//        putPiece(to: 11, type: 2)
//        putPiece(to: 13, type: 2)
//        putPiece(to: 25, type: 2)
//        putPiece(to: 50, type: 2)
//        putPiece(to: 52, type: 2)
        //putPiece(to: 41, type: 2)
        print("--- board init --- ")
        print(gameState.currentBoardState)
        setBoard()
        
    }
    
    func setBoard(){
        for i in 0..<rows{
            for j in 0..<columns{
                if(i%2 == 0 && j%2 == 1){
                    if(i <= 2){
                        putPiece(to: (i*rows) + j, type: 1)
                    }else if(i >= 5){
                        putPiece(to: (i*rows) + j, type: 2)
                    }
                }else if(i%2 == 1 && j%2 == 0){
                    if(i <= 2){
                        putPiece(to: (i*rows) + j, type: 1)
                    }else if(i >= 5){
                        putPiece(to: (i*rows) + j, type: 2)
                    }
                }
            }
        }
    }
    
    func generatePossibleMoves(from: Int){
        gameState.generatePossibleMoves(from: from)
        boardMoves = gameState.possibleMoves
        for i in 0..<boardMoves.count{
            //print(gameState.possibleMoves[i])
            boardNode.childNodes[boardMoves[i]].geometry?.materials[0].diffuse.contents = UIColor.brown
        }
    }
    func revertPossibleMoves(from: Int){
        for i in 0..<boardMoves.count{
            boardNode.childNodes[boardMoves[i]].geometry?.materials[0].diffuse.contents = UIColor.blue
        }
        gameState.possibleMoves.removeAll()
        boardMoves.removeAll()
    }
    func putPiece(to:Int, type: Int) -> Bool{
        let legal = gameState.addPiece(to: to, type: type)
        if(legal){
            switch type{
            case 0:
                print("put not allowed by player")
            case 1:
                boardNode.childNodes[to].addChildNode(pieces.addWhiteDraught())
                gameState.addPiece(to: to, type: type)
            case 2:
                boardNode.childNodes[to].addChildNode(pieces.addBlackDraught())
                gameState.addPiece(to: to, type: type)
            case 3:
                boardNode.childNodes[to].addChildNode(pieces.addWhiteDraughtKing())
                gameState.addPiece(to: to, type: type)
            default:
                print("defualt put peices called")
            }
        }
        return legal
    }
    func movePiece(from: Int,to:Int){
        if(gameState.movePiece(from: from, to: to)){
            boardNode.childNodes[from].childNodes[0].removeFromParentNode()
            if(gameState.toRemove != 0){
                boardNode.childNodes[gameState.toRemove-1].childNodes[0].removeFromParentNode()
            }
            switch gameState.currentBoardState[to]{
            case 1:
                boardNode.childNodes[to].addChildNode(pieces.addWhiteDraught())
            case 2:
                boardNode.childNodes[to].addChildNode(pieces.addBlackDraught())
            case 3:
                boardNode.childNodes[to].addChildNode(pieces.addWhiteDraughtKing())
            case 4:
                boardNode.childNodes[to].addChildNode(pieces.addBlackDraughtKing())
            default:
                print("hmmmm")
            }
        }
        revertPossibleMoves(from: from)
    }
    
    
    
}
