//
//  checkBoxViewItem.swift
//  Scrapbook
//
//  Created by Donghan Hu on 2/17/20.
//  Copyright © 2020 Donghan Hu. All rights reserved.
//

import Cocoa

class checkBoxViewItem: NSCollectionViewItem {
    
    @IBOutlet weak var checkBox: NSButton!
    @IBOutlet weak var pushBUtton: NSButton!
    @IBOutlet weak var imageButton: NSButton!
    
    override func viewWillAppear() {
        
        // pushBUtton.title = applicationNameStack[index]
    }
    
    override func viewDidLoad() {
        var applicationNameStack = [String]()
        let tempDictionary = variables.metaDataDictionaryTestOne["Applications"] as! [String:[String]]
        let keys: Array<String> = Array<String>(tempDictionary.keys)
        applicationNameStack = keys
        let index = alternativeUserInterfaceVariables.capturedApplicationCount
        print("index", index)
        print("button title", applicationNameStack[index])
        // print(self.pushBUtton.title)
        super.viewDidLoad()
        
        
        // imageButton.image = NSImage(named: "SKTT1.jpg")
        // Do view setup here.
    }
    @IBAction func displayInformationButton(_ sender: Any) {
        
    }
    
}
