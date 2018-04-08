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
    let row: Int
    let column: Int
    
    init(row: Int = 0, column: Int = 0){
        self.row = row
        self.column = column
    }
    //@TODO
    //change dimensions to be relative to baordsize
    func addNaught() -> SCNNode{
        let naughtNode = SCNNode()
        let naught = SCNTorus(ringRadius: 0.005, pipeRadius: 0.002)
        naught.firstMaterial?.diffuse.contents = UIColor.red
        
        naughtNode.geometry = naught
        naughtNode.transform = SCNMatrix4MakeRotation(-Float.pi / 2.0, 1.0, 0.0, 0.0)
        naughtNode.position = SCNVector3(0,0,0.006)
        
        return naughtNode
    }
    
    func addCross() -> SCNNode{
        let naughtNode = SCNNode()
        let naught = SCNTorus(ringRadius: 0.005, pipeRadius: 0.002)
        naught.firstMaterial?.diffuse.contents = UIColor.purple
        
        naughtNode.geometry = naught
        naughtNode.transform = SCNMatrix4MakeRotation(-Float.pi / 2.0, 1.0, 0.0, 0.0)
        naughtNode.position = SCNVector3(0,0,0.006)
        
        return naughtNode
    }


}
