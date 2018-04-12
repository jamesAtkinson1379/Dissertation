//
//  GamePieces.swift
//  ARGames
//
//  Created by james atkinson on 06/04/2018.
//  Copyright © 2018 james atkinson. All rights reserved.
//

import Foundation
import SceneKit

class GamePieces{
    
    let degreeToRadians:Float = .pi/180
    let rows: Int
    let columns: Int
    let width: Float
    let height: Float
    let length: Float
    let relativeSize: CGFloat
    
    //initilises the board pieces with board measurments
    init(rows: Int = 0, columns: Int = 0, width: Float = 0, height: Float = 0,length: Float =  0){
        self.rows = rows
        self.columns = columns
        self.width = width
        self.height = height
        self.length = length
        
        self.relativeSize = (CGFloat(width)/CGFloat(columns))/4
        
    }
    //creates a naught shaped piece
    func addNaught() -> SCNNode{
        let naughtNode = SCNNode()
        let naught = SCNTorus(ringRadius: relativeSize, pipeRadius: relativeSize/2)
        naught.firstMaterial?.diffuse.contents = UIColor.red
        
        naughtNode.geometry = naught
        naughtNode.transform = SCNMatrix4MakeRotation(-Float.pi / 2.0, 1.0, 0.0, 0.0)
        naughtNode.position = SCNVector3(0,0,relativeSize)
        naughtNode.name = "naught"
        
        return naughtNode
    }
    //@TODO
    //creates a cross shaped piece
    func addCross() -> SCNNode{
        let naughtNode = SCNNode()
        let naught = SCNTorus(ringRadius: relativeSize, pipeRadius: relativeSize/2)
        naught.firstMaterial?.diffuse.contents = UIColor.purple
        
        naughtNode.geometry = naught
        naughtNode.transform = SCNMatrix4MakeRotation(-Float.pi / 2.0, 1.0, 0.0, 0.0)
        naughtNode.position = SCNVector3(0,0,relativeSize)
        naughtNode.name = "cross"
        
        return naughtNode
    }
    //create a white draught
    func addWhiteDraught() -> SCNNode{
        let whiteDraughtNode = SCNNode()
        let whiteDraught = SCNCylinder(radius: relativeSize, height: relativeSize/2)
        whiteDraught.firstMaterial?.diffuse.contents = UIColor.lightGray
        
        whiteDraughtNode.geometry = whiteDraught
        whiteDraughtNode.transform = SCNMatrix4MakeRotation(-Float.pi / 2.0, 1.0, 0.0, 0.0)
        whiteDraughtNode.position = SCNVector3(0,0,relativeSize)
        whiteDraughtNode.name = "whiteDraught"
        return whiteDraughtNode
    }
    //creates a black draught
    func addBlackDraught() -> SCNNode{
        let blackDraughtNode = SCNNode()
        let blackDraught = SCNCylinder(radius: relativeSize, height: relativeSize/2)
        blackDraught.firstMaterial?.diffuse.contents = UIColor.green
        
        blackDraughtNode.geometry = blackDraught
        blackDraughtNode.transform = SCNMatrix4MakeRotation(-Float.pi / 2.0, 1.0, 0.0, 0.0)
        blackDraughtNode.position = SCNVector3(0,0,relativeSize)
        blackDraughtNode.name = "blackDraught"
        return blackDraughtNode
    }
    //creates a white draught king
    func addWhiteDraughtKing() -> SCNNode{
        let whiteDraughtNodeKing = SCNNode()
        let whiteDraughtKing = SCNCylinder(radius: relativeSize, height: relativeSize)
        whiteDraughtKing.firstMaterial?.diffuse.contents = UIColor.blue
        
        whiteDraughtNodeKing.geometry = whiteDraughtKing
        whiteDraughtNodeKing.transform = SCNMatrix4MakeRotation(-Float.pi / 2.0, 1.0, 0.0, 0.0)
        whiteDraughtNodeKing.position = SCNVector3(0,0,relativeSize)
        whiteDraughtNodeKing.name = "whiteDraughtKing"
        return whiteDraughtNodeKing
    }
    //creates a black draught king
    func addBlackDraughtKing() -> SCNNode{
        let blackDraughtNodeKing = SCNNode()
        let blackDraughtKing = SCNCylinder(radius: relativeSize, height: relativeSize)
        blackDraughtKing.firstMaterial?.diffuse.contents = UIColor.purple
        
        blackDraughtNodeKing.geometry = blackDraughtKing
        blackDraughtNodeKing.transform = SCNMatrix4MakeRotation(-Float.pi / 2.0, 1.0, 0.0, 0.0)
        blackDraughtNodeKing.position = SCNVector3(0,0,relativeSize)
        blackDraughtNodeKing.name = "blackDraught"
        return blackDraughtNodeKing
    }


}
