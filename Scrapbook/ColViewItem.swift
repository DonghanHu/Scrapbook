//
//  ColViewItem.swift
//  Scrapbook
//
//  Created by Donghan Hu on 2/11/20.
//  Copyright © 2020 Donghan Hu. All rights reserved.
//

import Cocoa

class ColViewItem: NSCollectionViewItem {


//    @IBOutlet weak var screenshotImage: NSImageView!
//
//    @IBOutlet weak var inputtextField: NSTextField!
    
    @IBOutlet weak var screenshotImage: NSImageView!
    
    @IBOutlet weak var labelSaveImagePath: NSTextField!
    @IBOutlet weak var imageButton: NSButton!
    @IBOutlet weak var inputTextField: NSTextField!
    override func viewDidLoad() {
        labelSaveImagePath.isHidden = true
        labelSaveImagePath.stringValue = photonumber.photoPathList[photonumber.photonumberCounting]
        print("count in colviewitem", photonumber.photoPathList[photonumber.photonumberCounting])
        super.viewDidLoad()
        let nsImage = NSImage(contentsOfFile: photonumber.photoPathList[photonumber.photonumberCounting])
        screenshotImage.image = nsImage
        imageButton.image = nsImage
        print("textfield display:", photonumber.photonumberCounting = photonumber.photonumberCounting)
        inputTextField.stringValue = photonumber.inputRelatedMessage[photonumber.photonumberCounting]
        // screenshotImage.image = NSImage(named: "SKTT1.jpg")
        // Do view setup here.
    }

    @IBAction func imageButtonClickAction(_ sender: Any) {
    
        
        print("button clicked", inputTextField.stringValue)
        print("click seleted image", labelSaveImagePath.stringValue)
        screenshotInDetailedView.path = labelSaveImagePath.stringValue
        screenshotInDetailedView.text = inputTextField.stringValue
        // let detailedViewHandler = detailedView(labelSaveImagePath.stringValue, inputTextField.stringValue)
        let WindowHandler : NSViewController = detailedView()
        let subWindow = NSWindow(contentViewController:  WindowHandler)
        let subWindowController = NSWindowController(window: subWindow)
        subWindowController.showWindow(nil)
   
    }
    
}
