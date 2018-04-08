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
    
    var boardNode: SCNNode
    var gameState: NaughtsAndCrossesGameState
    let peices = GamePieces()
    
    let degreeToRadians:Float = .pi/180
    
    init(height: Float = 0, width: Float = 0,length: Float = 0,x: Float = 0,y: Float = 0,z: Float = -0.2){
        boardNode = SCNNode()
        gameState = NaughtsAndCrossesGameState(rows: 3,columns: 3)
        
        super.init(rows:3,columns:3,height: height,width: width,length: length,x: x,y: y,z: z)
        
        var currentRow: Float = 0
        var currentColumn: Float = 0
        let columnOffset = super.width/Float(super.columns)
        let rowOffset = super.height/Float(super.rows)
        var alter = 0
        var currentSquare = 0
        
        let board = SCNBox(width: CGFloat(super.width), height: CGFloat(super.height),length: CGFloat(super.length), chamferRadius: 0)
        
        boardNode.geometry = board
        boardNode.transform = SCNMatrix4MakeRotation(-Float.pi / 2.0, 1.0, 0.0, 0.0)
        //boardNode.position = SCNVector3(super.x, super.y, super.z)
        boardNode.name = "board"
        
        let blackSquare = SCNBox(width: CGFloat(columnOffset),
                                 height: CGFloat(rowOffset),
                                 length: CGFloat(0.01), chamferRadius: 0)
        blackSquare.firstMaterial?.diffuse.contents = UIColor.black
        
        let whiteSquare = SCNBox(width: CGFloat(columnOffset),
                                 height: CGFloat(rowOffset),
                                 length: CGFloat(0.01), chamferRadius: 0)
        whiteSquare.firstMaterial?.diffuse.contents = UIColor.blue
        
        for _ in 1...super.rows{
            for _ in 1...super.columns{
                if(alter%2 == 0){
                    let blackSquareNode = SCNNode()
                    blackSquareNode.name = "\(currentSquare)"
                    blackSquareNode.geometry = blackSquare
                    blackSquareNode.position = SCNVector3(((-(width/2-columnOffset/2))+currentColumn),
                                                          ((-(height/2-rowOffset/2))+currentRow),
                                                          0.001)
                    boardNode.addChildNode(blackSquareNode)
                    alter = alter + 1
                    currentSquare = currentSquare + 1
                }else{
                    let whiteSquareNode = SCNNode()
                    whiteSquareNode.geometry = whiteSquare
                    whiteSquareNode.name = "\(currentSquare)"
                    whiteSquareNode.position = SCNVector3(((-(width/2-columnOffset/2))+currentColumn),
                                                          ((-(height/2-rowOffset/2))+currentRow),
                                                          0.001)
                    boardNode.addChildNode(whiteSquareNode)
                    alter = alter + 1
                    currentSquare = currentSquare + 1
                }
                currentColumn = currentColumn + columnOffset
            }
            if(super.columns%2 == 0){
                alter = alter + 1
            }
            currentRow = currentRow + rowOffset
            currentColumn = 0
        }
        
        //game state implementation
        
        print(boardNode.position)
    }
    
    func placeBoard(x: Float, y: Float, z: Float){
        boardNode.position = SCNVector3(x:x, y:y, z:z)
    }
    
    func movePiece(from: Int,to:Int){
        
        
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
