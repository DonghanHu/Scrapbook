//
//  testColViewItem.swift
//  Scrapbook
//
//  Created by Donghan Hu on 2/18/20.
//  Copyright © 2020 Donghan Hu. All rights reserved.
//

import Cocoa

class testColViewItem: NSCollectionViewItem {
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        let dictionary = variables.metaDataDictionaryTestOne["Applications"] as! [String:[String]]
        
        var applicationNameStack = [String]()
        let temp = variables.recordedApplicationNameStack
        let keys: Array<String> = Array<String>(dictionary.keys)
        applicationNameStack = keys
        
        let newBut = NSButton(frame: NSRect(x: 35, y: 0, width: 180, height: 30))
        newBut.alignment = .left
        newBut.contentTintColor = NSColor.green
        newBut.title = temp[alternativeUserInterfaceVariables.capturedApplicationCount]
        newBut.isBordered = false
        newBut.bezelStyle = NSButton.BezelStyle.regularSquare
        newBut.action = #selector(testViewController.firstInformationChange(_:))
//        newBut.action = #selector(testViewController.firstInformationChange())
        
        let checkBoxFrame = NSRect(x: 10, y: 10, width: 15, height: 15)
        let newCheckBut = NSButton.init(checkboxWithTitle: temp[alternativeUserInterfaceVariables.capturedApplicationCount], target: nil, action: #selector(testViewController.collectCheckBoxNumber(_:)))
        newCheckBut.frame = checkBoxFrame
        
        self.view.addSubview(newCheckBut)
        self.view.addSubview(newBut)
        // print("1")
        
        
        
        // print(testPushButton.title)
        // Do view setup here.
    }

    
    
    
}