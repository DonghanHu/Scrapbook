//
//  ViewController.swift
//  Scrapbook
//
//  Created by Donghan Hu on 12/26/19.
//  Copyright © 2019 Donghan Hu. All rights reserved.
//

import Cocoa

class Book: NSObject {
    @objc dynamic var firstInformation: String
    @objc dynamic var secondInformation: String
    
    init(firstInformation: String, secondInformation: String){
        self.firstInformation = firstInformation
        self.secondInformation = secondInformation
    }
}

class ViewController: NSViewController {

    @IBOutlet weak var QuitButton: NSButton!
    @IBOutlet weak var CaputerButton: NSButtonCell!
    
    var screenCaptureHandler = Screencapture()
    var softwareClassificationHandler = softwareClassify()
    
    @IBOutlet weak var CaptureMethodTwoButton: NSButton!
    
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getAllAvailableScrapbookList()
        divideIntoTwoArray(stringArray: diaryInformationCollection.photoNameList)
        photoNameListGenerate()
        CaputerButton.title = "Capture"
        // print("photo path list:", photonumber.photoPathList)
        // print("photo text list:", photonumber.inputRelatedMessage)


        
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
    
//    @IBAction func overviewWindowButtonAction(_ sender: Any) {
//        if (overviewWindowVariables.windowOpenOrClose == false){
//          let overViewWindowHandler = OverviewWindow()
//          let sub1Window = NSWindow(contentViewController: overViewWindowHandler)
//          overviewWindowVariables.subOverviewWindowController = NSWindowController(window: sub1Window)
//          overviewWindowVariables.subOverviewWindowController?.showWindow(nil)
//          overviewWindowVariables.windowOpenOrClose = true
//      }
//      else{
//          overviewWindowVariables.subOverviewWindowController?.showWindow(nil)
//      }
//
//      self.view.window?.close()
//    }
    
    
    func getAllAvailableScrapbookList(){
        let url =  URL(fileURLWithPath: variables.jsonFilePathString)
        var photoNameList = [[String]]()
        var inputMessageList = [String]()
        var inputMessageTitleList = [String]()
        do {
            let rawData : NSData = try! NSData(contentsOf: url)
            do{
                let jsonDataDictionary = try JSONSerialization.jsonObject(with : rawData as Data, options: JSONSerialization.ReadingOptions.mutableContainers)as? NSDictionary
                let dictionaryOfReturnedJsonData = jsonDataDictionary as! Dictionary<String, AnyObject>
                let jsonarray = dictionaryOfReturnedJsonData["BasicInformation"] as! [[String : Any]]
                // print("jsonarray", jsonarray)
                let length = jsonarray.count
                
                
                // print the number of message
                //print("message count:", photonumber.inputRelatedMessage.count)
                
                
                if (photonumber.inputRelatedMessage.count == length || length == 1){
                    print("nothing happen")
                }
                else {
                    for i in 1..<length{
                        let photoname = jsonarray[i]["PhotoTime"] as! [String]
                            photoNameList.append(photoname)
                    // end of for loop
                    }
                    diaryInformationCollection.photoNameList = photoNameList
                    for j in 1..<length{
                        let inputRelatedText = jsonarray[j]["Text"] as! [String]
                        inputMessageList.append(inputRelatedText[0])
        
                        let relatedTitle = jsonarray[j]["Title"] as! [String]
                        inputMessageTitleList.append(relatedTitle[0])
//                        photonumber.inputRelatedMessage.append(inputRelatedText[0])
                    }
                    photonumber.inputRelatedMessage = inputMessageList
                    
                    // print the memo of this page of scrapbook
                    // print("message", photonumber.inputRelatedMessage)
                    
                    photonumber.inputRelatedTitle   = inputMessageTitleList
                    
                    //print the title of this page of scrapbook
                    // print("title", photonumber.inputRelatedTitle)
                    
                }

            // end of do judgement
            }
        } catch {
            print("preview Error: \(error)")
        }
        
        // print the memo body as text information
        // print("text information is:", photonumber.inputRelatedMessage)

    }
    
    func divideIntoTwoArray(stringArray: [[String]]){
        var arrayOfFirstInformation = [String]()
        var arrayOfSecondInformation = [String]()
        // print("stringArray", stringArray)
        let length = stringArray.count
        if stringArray != [[""]] {
            for i in 0..<length{
                // print("[i][0]", stringArray[i][0])
                // print("[i][1]", stringArray[i][1])
                arrayOfFirstInformation.append(stringArray[i][0])
                arrayOfSecondInformation.append(stringArray[i][1])
            }
        }
//        if length > 1{
//            for i in 0..<length{
//                // print("[i][0]", stringArray[i][0])
//                // print("[i][1]", stringArray[i][1])
//                arrayOfFirstInformation.append(stringArray[i][0])
//                arrayOfSecondInformation.append(stringArray[i][1])
//            }
//        }

        diaryInformationCollection.photoNameFirstInformation = arrayOfFirstInformation
        diaryInformationCollection.photoNameSecondInformation = arrayOfSecondInformation
    }
    
    func photoNameListGenerate(){
        
        
        // print the number of photo information
        // print("second information count",diaryInformationCollection.photoNameSecondInformation.count)
        
        for i in 0..<diaryInformationCollection.photoNameSecondInformation.count{
            // print("i", i)
            // print("second information", diaryInformationCollection.photoNameSecondInformation[i])
            if photonumber.photoPathList.contains(diaryInformationCollection.photoNameSecondInformation[i]){
                
            }
            else {
                photonumber.photoPathList.append(diaryInformationCollection.photoNameSecondInformation[i])
            }
            
        }
        // print("photolistgenerate", photonumber.photoPathList)
    }
    func inputTextGenerate(){
        
    }
    
    
    
    
    
    @IBAction func QuitFunc(_ sender: Any) {
        exit(0)
    }
    // end of the class
}

