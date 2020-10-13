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
    
    @IBOutlet weak var boundary: NSTextField!
    override func viewDidLoad() {
        labelSaveImagePath.isHidden = true
        inputTitleField.isHidden = true
        boundary.stringValue = ""
        //photonumber.photonumberCounting = photonumber.photonumberCounting - 1
        let totalImages = diaryInformationCollection.photoNameList.count - 1
        
//        labelSaveImagePath.stringValue = photonumber.photoPathList[photonumber.photonumberCounting]
//        print(photonumber.photonumberCounting)
        
        let orderValue = totalImages - photonumber.photonumberCounting
        print(orderValue)
        labelSaveImagePath.stringValue = photonumber.photoPathList[totalImages - photonumber.photonumberCounting]
        
        
        
        // in collection view, count the whole number of screenshots
        print(labelSaveImagePath.stringValue)
        // print("count in colviewitem", photonumber.photoPathList[photonumber.photonumberCounting])
        
        super.viewDidLoad()
        // 1
        self.view.layer?.borderColor = NSColor.black.cgColor
        // 2
        self.view.layer?.borderWidth = 10.0

        // self.view.frame
        //let nsImage = NSImage(contentsOfFile: photonumber.photoPathList[photonumber.photonumberCounting])
        
        
        let nsImage = NSImage(contentsOfFile: photonumber.photoPathList[totalImages - photonumber.photonumberCounting])
        screenshotImage.image = nsImage
        screenshotImage.isHidden = true
        //screenshotImage.imageScaling = .scaleAxesIndependently
        imageButton.image = nsImage
        
        // display the text body
        // display the title body
        // print("message again", photonumber.inputRelatedMessage[photonumber.photonumberCounting])
        // inputTextField.stringValue = photonumber.inputRelatedMessage[photonumber.photonumberCounting]
        // print("xxx+", inputTextField.stringValue)
        // inputTitleField.stringValue = photonumber.inputRelatedTitle[photonumber.photonumberCounting]
        
        // Do view setup here.
        //reverse title and text
        inputTitleField.stringValue = photonumber.inputRelatedMessage[photonumber.photonumberCounting]
        inputTextField.stringValue = photonumber.inputRelatedTitle[photonumber.photonumberCounting]
    }

    @IBAction func imageButtonClickAction(_ sender: Any) {
    
        print("button clicked", inputTextField.stringValue)
        print("click seleted image", labelSaveImagePath.stringValue)
        screenshotInDetailedView.path = labelSaveImagePath.stringValue
        
        
        // print("memo body", inputTextField.stringValue)
//        screenshotInDetailedView.text = inputTextField.stringValue
//        screenshotInDetailedView.title = inputTitleField.stringValue
        screenshotInDetailedView.text = inputTitleField.stringValue
        screenshotInDetailedView.title = inputTextField.stringValue
        
        // let detailedViewHandler = detailedView(labelSaveImagePath.stringValue, inputTextField.stringValue)
        
        
        readJsonFile()
        
        // perfect solution
        presentAsModalWindow(newDetailedView() as NSViewController)
        
//        let temp2 : NSViewController = newDetailedView()
//        let subWindow2 = NSWindow(contentViewController: temp2)
//        let subWindowController2 = NSWindowController(window: subWindow2)
//        subWindowController2.showWindow(nil)
        
        // NSApp.activate(ignoringOtherApps: true)
        
        // self.window setCollectionBehavior: NSWindowCollectionBehaviorCanJoinAllSpaces

        // reset to zero
        detailedWiondwVariables.buttonCount = 0
        // print("corresponding dictionary", detailedWiondwVariables.detailedDictionary)
   
    }
    
    func readJsonFile(){
    
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
