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
    
    @IBOutlet weak var inputTextField: NSTextField!
    override func viewDidLoad() {
        print("count in colviewitem", photonumber.photoPathList[photonumber.photonumberCounting])
        super.viewDidLoad()
        let nsImage = NSImage(contentsOfFile: photonumber.photoPathList[photonumber.photonumberCounting])
        screenshotImage.image = nsImage
        print("textfield display:", photonumber.photonumberCounting = photonumber.photonumberCounting)
        inputTextField.stringValue = photonumber.inputRelatedMessage[photonumber.photonumberCounting]
        // screenshotImage.image = NSImage(named: "SKTT1.jpg")
        // Do view setup here.
    }
    
}
