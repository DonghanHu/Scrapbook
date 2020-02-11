//
//  ViewController.swift
//  Scrapbook
//
//  Created by Donghan Hu on 12/26/19.
//  Copyright © 2019 Donghan Hu. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var QuitButton: NSButton!
    @IBOutlet weak var CaputerButton: NSButtonCell!
    
    var screenCaptureHandler = Screencapture()
    var softwareClassificationHandler = softwareClassify()
    var OverviewWindowHandler = OverviewWindow()
    
    @IBOutlet weak var CaptureMethodTwoButton: NSButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // softwareClassificationHandler.openingApplication()
        // softwareClassificationHandler.screenAboveWindowListPrint()

        
        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    @IBAction func CaptureScreenShotMethodTwo(_ sender: Any) {
        
        self.view.window?.close()
         screenCaptureHandler.screenCaptureFramework()
        // screenCaptureHandler.screenCaptureSwiftCodeMethod(folderName: "nil")
    }
    
    @IBAction func CaptureScreenshot(_ sender: Any) {
        self.view.window?.close()
        screenCaptureHandler.selectScreenCapture()
    }
    
    @IBAction func overviewWindowButtonAction(_ sender: Any) {
        if (overviewWindowVariables.windowOpenOrClose == false){
          let overViewWindowHandler = OverviewWindow()
          let sub1Window = NSWindow(contentViewController: overViewWindowHandler)
          overviewWindowVariables.subOverviewWindowController = NSWindowController(window: sub1Window)
          overviewWindowVariables.subOverviewWindowController?.showWindow(nil)
          overviewWindowVariables.windowOpenOrClose = true
      }
      else{
          overviewWindowVariables.subOverviewWindowController?.showWindow(nil)
      }

      self.view.window?.close()
    }
    
    
    @IBAction func QuitFunc(_ sender: Any) {
        exit(0)
    }
    
}

