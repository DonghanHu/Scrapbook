//
//  SoftwareClassification.swift
//  Scrapbook
//
//  Created by Donghan Hu on 1/2/20.
//  Copyright © 2020 Donghan Hu. All rights reserved.
//

import Foundation
import AppKit

class softwareClassify : NSObject {
    
    func currentMousePosition (){
        let xMoustLoaction = Int(NSEvent.mouseLocation.x)
        let yMouseLocation = Int(NSEvent.mouseLocation.y)
        // x and y are current mouse location of the major monitor
        
    }
    
    func frontmostApplication(){
        let frontMostApplicationName = NSWorkspace.shared.frontmostApplication?.localizedName?.description
        print("current front most application is:", frontMostApplicationName!)
        
    }
    
    
}
