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
                
        let newBut = NSButton(frame: NSRect(x: 25, y: 5, width: 120, height: 25))
        newBut.title = applicationNameStack[detailedWiondwVariables.buttonCount]
        newBut.bezelStyle = NSButton.BezelStyle.regularSquare
        newBut.action = #selector(newDetailedView.collectionViewButton(_:))

        let checkBoxFrame = NSRect(x: 5, y: 5, width: 15, height: 25)
        let newCheckBut = NSButton.init(checkboxWithTitle: applicationNameStack[detailedWiondwVariables.buttonCount], target: nil, action: #selector(newDetailedView.collectionViewCheckBox(_:)))
        newCheckBut.frame = checkBoxFrame
                
        self.view.addSubview(newCheckBut)
        self.view.addSubview(newBut)
        // Do view setup here.
    }
    
}
