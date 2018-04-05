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
    }
    
    
}
