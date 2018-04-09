//
//  Draughts.swift
//  ARGames
//
//  Created by james atkinson on 09/04/2018.
//  Copyright © 2018 james atkinson. All rights reserved.
//

import Foundation

class Draughts: Board{
    
    var gameState:DraughtsGameState
    
    init(height: Float = 0, width: Float = 0,length: Float = 0,x: Float = 0,y: Float = 0,z: Float = -0.2){
        gameState = DraughtsGameState(rows:8,columns:8)
        super.init(rows:8,columns:8,height: height,width: width,length: length,x: x,y: y,z: z)
        print(boardNode.position)
    }
    
    func movePiece(from: Int,to:Int){
        let legal = true
        print("begin move")
        if(legal){
            print(from)
            print(to)
            print(boardNode.childNodes[from].childNodes.count)
            //boardNode.childNodes[from].childNodes[0].removeFromParentNode()
            boardNode.childNodes[to].addChildNode(peices.addNaught())
        }
    }
    
    func putPiece(to:Int) -> Bool{
        let legal = gameState.isLegal(to:to) //testMove(to)
        if(legal){
            if(gameState.currentPlayer == 1){
                boardNode.childNodes[to].addChildNode(peices.addNaught())
            }else{
                boardNode.childNodes[to].addChildNode(peices.addCross())
            }
            gameState.addPiece(to: to)
        }
        return legal
    }
    
}
