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
    @IBOutlet weak var applicationName: NSTextField!
    @IBOutlet weak var applicationFirstFactor: NSTextField!
    @IBOutlet weak var applicationSecondFactor: NSTextField!
    
    // check box name list
    @IBOutlet weak var checkboxOne: NSButton!
    @IBOutlet weak var checkboxTwo: NSButton!
    @IBOutlet weak var checkboxThree: NSButton!
    @IBOutlet weak var checkboxFour: NSButton!
    @IBOutlet weak var checkboxFive: NSButton!
    @IBOutlet weak var checkboxSix: NSButton!
    @IBOutlet weak var checkboxSeven: NSButton!
    @IBOutlet weak var checkboxEight: NSButton!
    
    
    var checkboxStack = [NSButton]()
    
    
    override func viewWillAppear(){
        
        super.viewWillAppear()
        self.view.window?.title = "eidt window"
        checkboxStackGenerate()
        checkBoxAllHidden()
        for i in 0..<variables.numberofRecordedApplication{
            let temp = checkboxStack[i]
            temp.isHidden = false
        }
        
        
        displayLatestScreenshot()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do view setup here.
    }
    // func all check box are hidden at first
    func checkBoxAllHidden(){
        checkboxOne.isHidden = true
        checkboxTwo.isHidden = true
        checkboxThree.isHidden = true
        checkboxFour.isHidden = true
        checkboxFive.isHidden = true
        checkboxSix.isHidden = true
        checkboxSeven.isHidden = true
        checkboxEight.isHidden = true
        
    }
    // func put check box names in the stack
    func checkboxStackGenerate(){
        checkboxStack.append(checkboxOne)
        checkboxStack.append(checkboxTwo)
        checkboxStack.append(checkboxThree)
        checkboxStack.append(checkboxFour)
        checkboxStack.append(checkboxFive)
        checkboxStack.append(checkboxSix)
        checkboxStack.append(checkboxSeven)
        checkboxStack.append(checkboxEight)
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
