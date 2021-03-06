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
    @IBOutlet weak var cancelButton: NSButton!
    
    var screenCaptureHandler = Screencapture()
    var wholeScreenCaptureHandler = Screencapture()
    var softwareClassificationHandler = softwareClassify()
    
    @IBOutlet weak var CaptureMethodTwoButton: NSButton!
    
    var eventMonitorViewConroller : EventMonitor?
    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    
    
    // typealias FinishedClose = () -> ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.view.window?.close()
        if (checkDetailedWiondowOpenOrNot.openOrNot == true){
            self.view.window?.close()
        }
        else {
            getAllAvailableScrapbookList()
            divideIntoTwoArray(stringArray: diaryInformationCollection.photoNameList)
            photoNameListGenerate()
            CaputerButton.title = "Capture Selected Screen (S)"
            cancelButton.title = "Go Back"
            // get the screen width and height
            getScreenInfor()
        }
        
//        getAllAvailableScrapbookList()
//        divideIntoTwoArray(stringArray: diaryInformationCollection.photoNameList)
//        photoNameListGenerate()
//        CaputerButton.title = "Capture Selected Screen (S)"
//        // print("photo path list:", photonumber.photoPathList)
//        // print("photo text list:", photonumber.inputRelatedMessage)
//
//        cancelButton.title = "Go Back"
//        // get the screen width and height
//        getScreenInfor()
        //self.view.window?.makeKeyAndOrderFront(self)
        //self.view.window?.makeMain()
        
        //print("rawvalue", self.view.window?.level.rawValue)
        
        
        
        // Do any additional setup after loading the view.
    }

//    override var representedObject: Any? {
//        didSet {
//        // Update the view, if already loaded.
//        }
//    }
    
    
    override func viewWillAppear() {
        super.viewWillAppear()
        if (checkDetailedWiondowOpenOrNot.openOrNot == true){
            self.view.window?.close()
        }
    }
    
    @IBAction func CaptureScreenShotMethodTwo(_ sender: Any) {
        
        self.view.window?.close()
        print("button 1 is clicked")
        
        do {
            sleep(UInt32(1.1))
        }
        
        wholeScreenCaptureHandler.wholeScreenCapture()
    }
    
    
    
    @IBAction func CaptureScreenshot(_ sender: Any) {
        self.view.window?.close()
        screenCaptureHandler.selectScreenCapture()
        
        
    }
    

    
    
    @IBAction func collectionViewWindowOpen(_ sender: Any) {
        // this function does not run
        performSegue(withIdentifier: "collectionViewID", sender: sender)
        // performSegue(withIdentifier: "collectionViewID", sender: (Any).self)
        
        self.view.window?.close()
        // presentAsModalWindow(collectionViewController() as NSViewController)
        
        print("collectionview window is opened, and this window closed")
    }
    
    
    func getScreenInfor(){
        let screen = NSScreen.main
        let rect = screen!.frame
        let height = rect.size.height
        let width = rect.size.width
        capturedApplicationsCoordinates.screenWidth = Int(width)
        capturedApplicationsCoordinates.screenHeight = Int(height)
    }
    
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
    
    @IBAction func cancelButtonAction(_ sender: Any) {
        print("cancel button")
        performSegue(withIdentifier: "collectionwindow", sender: sender)
        self.view.window?.close()
    }
    
    
    
    
    @IBAction func QuitFunc(_ sender: Any) {
        exit(0)
    }
    
    
    // end of the class
}


extension ViewController {
  // MARK: Storyboard instantiation
  static func freshController() -> ViewController {
    //1.
    let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: nil)
    //2.
    let identifier = NSStoryboard.SceneIdentifier("ViewController")
    //3.
    guard let viewcontroller = storyboard.instantiateController(withIdentifier: identifier) as? ViewController else {
      fatalError("Why cant i find QuotesViewController? - Check Main.storyboard")
    }
    return viewcontroller
  }
}


