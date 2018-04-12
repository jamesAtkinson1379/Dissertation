//
//  NaughtsAndCrosses.swift
//  ARGames
//
//  Created by james atkinson on 03/04/2018.
//  Copyright © 2018 james atkinson. All rights reserved.
//

import Foundation
import SceneKit

class NaughtsAndCrosses: Board{
    
    var gameState:NaughtsAndCrossesGameState
    
    init(height: Float = 0, width: Float = 0,length: Float = 0,x: Float = 0,y: Float = 0,z: Float = -0.2){
        gameState = NaughtsAndCrossesGameState(rows:3,columns:3)
        super.init(rows:3,columns:3,height: height,width: width,length: length,x: x,y: y,z: z)
        //game state implementation
        print(boardNode.position)
    }
    
    func movePiece(from: Int,to:Int){
        
    }
    
    func putPiece(to:Int) -> Bool{
        let legal = gameState.addPiece(to: to)
        if(legal){
            if(gameState.currentPlayer == 1){
                boardNode.childNodes[to].addChildNode(pieces.addNaught())
            }else{
                boardNode.childNodes[to].addChildNode(pieces.addCross())
            }
        }
        return legal
    }
    
}

extension SCNNode{
    var type: String{
        guard let temp = self.geometry?.name else {return "nil"}
        return temp
    }
}

