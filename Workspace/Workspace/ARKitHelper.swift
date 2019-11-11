//
//  ARKitHelper.swift
//  Workspace
//
//  Created by James touri on 11/10/19.
//  Copyright © 2019 jamestouri. All rights reserved.
//

import Foundation
import UIKit

var storedNodes: [NSValue] = []
var locationToStringName: [Int: String] = [:]

func ifLocationIsSelected(location: CGPoint) -> String {
    let nsLocation = NSValue(cgPoint: location)
    if storedNodes.contains(nsLocation) {
        print("in here \n\n\n\n\n")
        return ""
    } else {
        storedNodes.append(nsLocation)
        let nodeName = "Screen " + String(storedNodes.count)
        locationToStringName[storedNodes.count] = nodeName
        print("stored in there \n\n\n\n")
        return nodeName
    }
}
