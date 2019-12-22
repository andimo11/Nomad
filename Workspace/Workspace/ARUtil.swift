//
//  ARUtil.swift
//  Workspace
//
//  Created by James touri on 12/1/19.
//  Copyright © 2019 jamestouri. All rights reserved.
//


// Various Structs and methods to put to retrieve to have a cleaner controller
import Foundation

// For the passing of data through segue to ARViewController
public func displayLayOut(numScreens: Int) -> [[Int]]{
    var display: [[Int]] = [[0, 0, 0]]
    switch(numScreens){
    case(1): return display
    case(2): display = [[-18, 0, -50],[18, 0, -50]]
    case(3): display = [[-18, 0, -50], [0, 0, 0], [18, 0, -50]]
    case(4): display = [[-18, 20, -50], [18, 20, -50], [-18, -20, -50], [18, -20, -50]]
    default: print("number of screens error")
    }
    return display
}

