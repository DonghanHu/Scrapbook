//
//  screenshotEditWindow.swift
//  Scrapbook
//
//  Created by Donghan Hu on 1/6/20.
//  Copyright © 2020 Donghan Hu. All rights reserved.
//

import Cocoa
import Foundation

class screenshotEditWindow: NSViewController {
    @IBOutlet weak var imageCellDisplay: NSImageCell!
    
    @IBOutlet weak var textEditField: NSTextField!
    
    
    override func viewWillAppear(){
        
        super.viewWillAppear()
        self.view.window?.title = "eidt window"
        displayLatestScreenshot()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do view setup here.
    }
    
    func displayLatestScreenshot() {
        imageCellDisplay.imageScaling = .scaleProportionallyUpOrDown
        print(variables.latesScreenShotPathString)
        
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: variables.latesScreenShotPathString){
            print("imgae existed")
        }
        else {
            print("image not existed")
        }
        

        let currentScreenshot = NSImage(contentsOfFile: variables.latesScreenShotPathString)
        imageCellDisplay.image = currentScreenshot
        
    }
}
