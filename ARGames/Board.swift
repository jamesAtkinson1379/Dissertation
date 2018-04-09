//
//  Board.swift
//  ARGames
//
//  Created by james atkinson on 03/04/2018.
//  Copyright © 2018 james atkinson. All rights reserved.
//

import Foundation
import SceneKit

class Board{
    
    let rows: Int
    let columns: Int
    var height: Float
    var width: Float
    var length: Float
    var x: Float
    var y: Float
    var z: Float
    
    var boardNode: SCNNode
    let peices = GamePieces()
    
    init(rows: Int = 0, columns: Int = 0,height: Float = 0.1, width: Float = 0.1,length: Float = 0.01,
        x: Float = 0, y: Float = 0, z: Float = -0.2 ){
        self.rows = rows
        self.columns = columns
        self.height = height
        self.width = width
        self.length = length
        self.x = x
        self.y = y
        self.z = z
        
        boardNode = SCNNode()
        
        var currentRow: Float = 0
        var currentColumn: Float = 0
        let columnOffset = width/Float(columns)
        let rowOffset = height/Float(rows)
        var alter = 0
        var currentSquare = 0
        
        let board = SCNBox(width: CGFloat(width), height: CGFloat(height),length: CGFloat(length), chamferRadius: 0)
        
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
        
        for _ in 1...rows{
            for _ in 1...columns{
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
            if(columns%2 == 0){
                alter = alter + 1
            }
            currentRow = currentRow + rowOffset
            currentColumn = 0
        }
        
    }
    
    func placeBoard(x: Float, y: Float, z: Float){
        boardNode.position = SCNVector3(x:x, y:y, z:z)
    }
    
}
