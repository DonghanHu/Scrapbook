//
//  ColViewItem.swift
//  Scrapbook
//
//  Created by Donghan Hu on 2/11/20.
//  Copyright © 2020 Donghan Hu. All rights reserved.
//

import Cocoa

class ColViewItem: NSCollectionViewItem {
    
    @IBOutlet weak var screenshotImage: NSImageView!
    @IBOutlet weak var labelSaveImagePath: NSTextField!
    @IBOutlet weak var imageButton: NSButton!
    @IBOutlet weak var inputTextField: NSTextField!
    @IBOutlet weak var inputTitleField: NSTextField!
    
    override func viewDidLoad() {
        labelSaveImagePath.isHidden = true
        inputTitleField.isHidden = true
        labelSaveImagePath.stringValue = photonumber.photoPathList[photonumber.photonumberCounting]
        print("count in colviewitem", photonumber.photoPathList[photonumber.photonumberCounting])
        super.viewDidLoad()
        // self.view.frame
        let nsImage = NSImage(contentsOfFile: photonumber.photoPathList[photonumber.photonumberCounting])
        screenshotImage.image = nsImage
        screenshotImage.imageScaling = .scaleAxesIndependently
        imageButton.image = nsImage
        
        // print("textfield display:", photonumber.photonumberCounting = photonumber.photonumberCounting)
//        let height = nsImage?.size.height
//        let width = nsImage?.size.width
        
        // display the text body
        //inputTextField.stringValue = photonumber.inputRelatedMessage[photonumber.photonumberCounting]
        // display the title body
        inputTextField.stringValue = photonumber.inputRelatedTitle[photonumber.photonumberCounting]
        //inputTextField.stringValue = photonumber.inputRelatedMessage[photonumber.photonumberCounting]
        inputTitleField.stringValue = photonumber.inputRelatedTitle[photonumber.photonumberCounting]
        // screenshotImage.image = NSImage(named: "SKTT1.jpg")
        // Do view setup here.
    }

    @IBAction func imageButtonClickAction(_ sender: Any) {
    
        print("button clicked", inputTextField.stringValue)
        print("click seleted image", labelSaveImagePath.stringValue)
        screenshotInDetailedView.path = labelSaveImagePath.stringValue
        screenshotInDetailedView.text = inputTextField.stringValue
        screenshotInDetailedView.title = inputTitleField.stringValue

        
        // let detailedViewHandler = detailedView(labelSaveImagePath.stringValue, inputTextField.stringValue)
        
        
        readJsonFile()
        
        // newDetailedView
        let WindowHandler1 : NSViewController = newDetailedView()
        let subWindow1 = NSWindow(contentViewController:  WindowHandler1)

        let subWindowController1 = NSWindowController(window: subWindow1)

      
        subWindowController1.showWindow(nil)
        // subWindow1.orderFront((Any).self)
        // subWindow1.collectionBehavior = .canJoinAllSpaces
        //subWindow1.orderedIndex = 1
        subWindow1.level = NSWindow.Level(rawValue: Int(CGWindowLevelForKey(.mainMenuWindow)) + 2)
        // NSApplication.shared.modalWindow?.orderFrontRegardless()
        // subWindow1.makeKeyAndOrderFront(nil)
        
        
        
        
        // NSApp.activate(ignoringOtherApps: true)
        
        // self.window setCollectionBehavior: NSWindowCollectionBehaviorCanJoinAllSpaces

        // reset to zero
        detailedWiondwVariables.buttonCount = 0
        // print("corresponding dictionary", detailedWiondwVariables.detailedDictionary)
   
    }
    
    func readJsonFile(){
        
        _ = [String]()
        let url =  URL(fileURLWithPath: variables.jsonFilePathString)
        let rawData : NSData = try! NSData(contentsOf: url)
        do{
            let jsonDataDictionary = try JSONSerialization.jsonObject(with: rawData as Data, options: JSONSerialization.ReadingOptions.mutableContainers)as? NSDictionary
            let dictionaryOfReturnedJsonData = jsonDataDictionary as! Dictionary<String, AnyObject>
            let jsonarray = dictionaryOfReturnedJsonData["BasicInformation"] as! [[String: Any]]
            let length = jsonarray.count
            for i in 1..<length{
                let temp = jsonarray[i]["PhotoTime"] as! [String]
                if temp[1] == screenshotInDetailedView.path {
                    detailedWiondwVariables.detailedDictionary = jsonarray[i]
                    let applicationsDictionary = jsonarray[i]["Applications"] as! [String:[String]]
                    let applicationsNumber = applicationsDictionary.count
                    detailedWiondwVariables.buttonNumber = applicationsNumber
                    
//                    let applicationsDictionary = jsonarray[i]["Applications"] as! [String:[String]]
//                    let applicationsNumber = applicationsDictionary.count
//                    detailedViewControllerVariables.numberofRecordedApplication = applicationsNumber
//                    let keys: Array<String> = Array<String>(applicationsDictionary.keys)
//                    applicationNameStack = keys
//                    detailedViewControllerVariables.recordedApplicationNameStack = applicationNameStack
//                    detailedViewControllerVariables.recordedApplicationInformation = applicationsDictionary

                    break
                    
                }
            }
            
        }catch{print(error)}
    }
    
}