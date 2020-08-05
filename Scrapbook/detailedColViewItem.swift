//
//  detailedColViewItem.swift
//  Scrapbook
//
//  Created by Donghan Hu on 2/21/20.
//  Copyright © 2020 Donghan Hu. All rights reserved.
//

import Cocoa

class detailedColViewItem: NSCollectionViewItem {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let dictionary = detailedWiondwVariables.detailedDictionary["Applications"] as! [String:[String]]
        
        var applicationNameStack = [String]()
        let keys: Array<String> = Array<String>(dictionary.keys)
        applicationNameStack = keys
        
        variables.detailedApplicationNameList = applicationNameStack
        
                
        let newBut = NSButton(frame: NSRect(x: 35, y: 2, width: 180, height: 30))
        newBut.contentTintColor = NSColor.black
        newBut.title = applicationNameStack[detailedWiondwVariables.buttonCount]
        newBut.font = NSFont(name: "AppleSystemUIFont", size: 14.0)
        newBut.bezelStyle = NSButton.BezelStyle.regularSquare
        newBut.alignment = .left
        newBut.isBordered = false
        newBut.action = #selector(newDetailedView.collectionViewButton(_:))

        let checkBoxFrame = NSRect(x: 10, y: 8, width: 19, height: 19)
        let newCheckBut = NSButton.init(checkboxWithTitle: applicationNameStack[detailedWiondwVariables.buttonCount], target: nil, action: #selector(newDetailedView.collectionViewCheckBox(_:)))
        newCheckBut.frame = checkBoxFrame
        // newCheckBut.isBordered = true
        
        let underline = NSButton(frame: NSRect(x: 5, y: 6, width: 200, height: 1))
        underline.isBordered = true
                
        self.view.addSubview(newCheckBut)
        self.view.addSubview(newBut)
        self.view.addSubview(underline)
        // Do view setup here.
        
    }
    
}
