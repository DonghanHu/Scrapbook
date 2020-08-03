//
//  testViewController.swift
//  Scrapbook
//
//  Created by Donghan Hu on 2/18/20.
//  Copyright © 2020 Donghan Hu. All rights reserved.
//

import Cocoa


extension NSUserInterfaceItemIdentifier {
    static let testItem = NSUserInterfaceItemIdentifier("testColViewItem")
}

class testViewController: NSViewController , NSCollectionViewDelegate, NSCollectionViewDataSource{
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return variables.recordedApplicationNameStack.count
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        let item = collectionView.makeItem(withIdentifier: .testItem, for: indexPath)
        
        alternativeUserInterfaceVariables.capturedApplicationCount = alternativeUserInterfaceVariables.capturedApplicationCount + 1
        
        return item
    }
    

    @IBOutlet weak var testColView: NSCollectionView!
    @IBOutlet weak var timeLabelDisplay: NSTextField!
    
    @IBOutlet weak var labelFirstInformation: NSTextField!
    @IBOutlet weak var labelSecondInformation: NSTextField!
    @IBOutlet weak var labelThirdInformation: NSTextField!
    
    @IBOutlet weak var screenshotDisplay: NSImageView!
    
    @IBOutlet weak var scrapbookTitle: NSTextField!
    @IBOutlet weak var scrapbookBody: NSTextField!
    
    @IBOutlet weak var saveButton: NSButton!
    @IBOutlet weak var deleteButton: NSButton!
    
    
    @IBOutlet weak var captionLabelOne: NSTextField!
    @IBOutlet weak var captionLabelTwo: NSTextField!
    @IBOutlet weak var captionLabelThree: NSTextField!
    
    
    var checkBoxCollection = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkBoxCollection = variables.capturedApplicationNameList
        
        let item = NSNib(nibNamed: "testColViewItem", bundle: nil)
        testColView.register(item, forItemWithIdentifier: .testItem)
        testColView.delegate = self
        testColView.dataSource = self
        self.title = "Capture View"
        
        timeLabelDisplay.stringValue = variables.currentTimeInformation
        
        captionLabelOne.stringValue = "Application Name:"
        captionLabelTwo.isHidden = true
        captionLabelThree.isHidden = true
        
        let date = Date()
        let calendar = Calendar.current
        let stringDay = calendar.component(.day, from: date)
        let intDay = Int(stringDay)
        if intDay != variables.tempDay {
            variables.countNumber = 1
        }
        
        
        
        let stringCountNumber = String(variables.countNumber)
        
        variables.defaultTitle = "Scrap #" + stringCountNumber + ": " + dateFromatGenerate()
        
        scrapbookTitle.placeholderString = "Scrap #" + stringCountNumber + ": " + dateFromatGenerate()
        
        //scrapbookTitle.stringValue = "Scrap #" + stringCountNumber + ": " + dateFromatGenerate()
        
        scrapbookBody.placeholderString = "Input your memo here..."
        
        displayLatestScreenshot()
        

        if (checkBoxCollection[0] != nil){
            let firstApplicationName = checkBoxCollection[0]
            labelFirstInformation.stringValue = firstApplicationName
            print("first application name in caputer view", firstApplicationName)
            let tempDictionary = variables.metaDataDictionaryTestOne["Applications"] as! [String:[String]]
            let tempApplicationMetaData = tempDictionary[firstApplicationName]
            print("tempApplicationMetaData![2]", tempApplicationMetaData![2])
            if tempApplicationMetaData![2] == "Safari" || tempApplicationMetaData![2] == "Google Chrome"{
                captionLabelTwo.isHidden = false
                captionLabelThree.isHidden = false
                captionLabelTwo.stringValue = "URL:"
                captionLabelThree.stringValue = "Title:"
            }
            else if tempApplicationMetaData![2] == "Prod1" || tempApplicationMetaData![2] == "Prod2" || tempApplicationMetaData![2] == "Xcode" || tempApplicationMetaData![2] == "Finder" {
                captionLabelTwo.isHidden = false
                captionLabelThree.isHidden = false
                captionLabelTwo.stringValue = "Path:"
                captionLabelThree.stringValue = "Name:"
            }

            else if tempApplicationMetaData![2] == "Others"{
                captionLabelTwo.isHidden = false
                captionLabelThree.isHidden = false
                captionLabelTwo.stringValue = "Infomation one"
                captionLabelThree.stringValue = "Information two"
            }
            
            
            print("tempApplicationMetaData![0]", tempApplicationMetaData![0])
            if tempApplicationMetaData![0] != "" {
                labelSecondInformation.stringValue = (tempApplicationMetaData?[0])!
            }
            else {
                labelSecondInformation.stringValue = "Nothing here"
            }
            
            print("tempApplicationMetaData![1]", tempApplicationMetaData![1])
            if tempApplicationMetaData![1] != "" {
                labelThirdInformation.stringValue = (tempApplicationMetaData?[1])!
            }
            else {
                labelThirdInformation.stringValue = "Nothing here"
            }



        }
        
        
        
        // Do view setup here.
    }
    
    @objc func firstInformationChange(_ sender: NSButton){
        // print(sender.title)
        
        
        captionLabelTwo.isHidden = false
        captionLabelThree.isHidden = false
        labelFirstInformation.stringValue = sender.title
        let tempDictionary = variables.metaDataDictionaryTestOne["Applications"] as! [String:[String]]
    
        // now, only have applications' information, stored in the dictionary
        // print photo times
        print(variables.metaDataDictionaryTestOne["PhotoTime"])
        // print tempdictionary body
        //print(tempDictionary)
        
        let tempApplicationName = sender.title
        let tempApplicationMetaData = tempDictionary[tempApplicationName]
        print(tempApplicationMetaData![2])
        if tempApplicationMetaData![2] == "Safari" || tempApplicationMetaData![2] == "Google Chrome"{
            captionLabelTwo.stringValue = "URL:"
            captionLabelThree.stringValue = "Title:"
        }
        if tempApplicationMetaData![2] == "Prod1" || tempApplicationMetaData![2] == "Prod2" || tempApplicationMetaData![2] == "Xcode" || tempApplicationMetaData![2] == "Finder" {
            captionLabelTwo.stringValue = "Path:"
            captionLabelThree.stringValue = "Name:"
        }
        
        if tempApplicationMetaData![2] == "Others"{
            captionLabelTwo.stringValue = "other one"
            captionLabelThree.stringValue = "other two"
        }
        
        if tempApplicationMetaData![0] != "" {
            labelSecondInformation.stringValue = (tempApplicationMetaData?[0])!
        }
        else {
            labelSecondInformation.stringValue = "Nothing here"
        }
        // labelSecondInformation.stringValue = tempApplicationMetaData?[0] ?? "Nothing here"
        if tempApplicationMetaData![1] != "" {
            labelThirdInformation.stringValue = (tempApplicationMetaData?[1])!
        }
        else {
            labelThirdInformation.stringValue = "Nothing here"
        }
        // labelThirdInformation.stringValue = tempApplicationMetaData?[1] ?? "Nothing here"
    }
    
    @objc func collectCheckBoxNumber(_ sender: NSButton){
        
        print("check box collection", checkBoxCollection)
        if (sender.state == .on && !checkBoxCollection.contains(sender.title)){
            checkBoxCollection.append(sender.title)
        }
        else if (sender.state == .off && checkBoxCollection.contains(sender.title)){
            let index = checkBoxCollection.firstIndex(of: sender.title)
            checkBoxCollection.remove(at: index!)
        }
      
        
        // previous code: double click will not remove application name from string array
        // hence, uncheck checkbox will still remain previous application name
//
//        if checkBoxCollection.contains(sender.title) {
//            // print("checkboxcollection has already contained this application name")
//        }
//        else {
//            checkBoxCollection.append(sender.title)
//        }
        
        
        
//        if sender.state == .on || checkBoxCollection.contains(sender.title){
//            
//        }
//        else if (sender.state == .on) || !(checkBoxCollection.contains(sender.title)){
//            checkBoxCollection.append(sender.title)
//        }
//        else if (sender.state == .off) || checkBoxCollection.contains(sender.title){
//            checkBoxCollection.removeAll{ $0 == sender.title }
//        }
//        else if (sender.state == .off) || !(checkBoxCollection.contains(sender.title)){
//
//        }
        print("check box collection", checkBoxCollection)
    }
    
    func displayLatestScreenshot() {
        screenshotDisplay.imageScaling = .scaleProportionallyUpOrDown
        // print(variables.latesScreenShotPathString)
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: variables.latesScreenShotPathString){
            print("imgae existed")
        }
        else {
            print("image not existed")
        }
        let currentScreenshot = NSImage(contentsOfFile: variables.latesScreenShotPathString)
        screenshotDisplay.image = currentScreenshot
        
    }
    
    func dateFromatGenerate() -> String{
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM d"
           //dateFormatter.dateFormat = "YYYY.MM.dd,HH:mm"
        let dateString = dateFormatter.string(from: date)
        return dateString
       }
    
    @IBAction func saveButtonAction(_ sender: Any) {
        
        
        print("this is checkbox collection: ", checkBoxCollection)
        
        if (scrapbookTitle.stringValue == "") {
            scrapbookTitle.stringValue = variables.defaultTitle
            variables.defaultTitle = ""
        }
        else {
            print("this is the customized title", scrapbookTitle.stringValue)
        }
        
        
        variables.metaDataDictionaryTestOne["Title"] = [scrapbookTitle.stringValue]
        variables.metaDataDictionaryTestOne["Text"] = [scrapbookBody.stringValue]
        // print("memo body", variables.metaDataDictionaryTestOne["Text"])
        
        variables.metaDataDictionaryTestOne["PhotoTime"] = [variables.latestScreenShotTime, variables.latesScreenShotPathString, variables.currentTimeInformation]
        var tempDictionary = variables.metaDataDictionaryTestOne["Applications"] as! [String:[String]]
        let dictionary = [String:[String]]()
        let length = checkBoxCollection.count
        let keys: Array<String> = Array<String>(tempDictionary.keys)
        let keyLength = keys.count
        for i in 0..<keyLength{
            if checkBoxCollection.contains(keys[i]){
                
            }
            else {
                tempDictionary.removeValue(forKey: keys[i])
            }
        }
        variables.metaDataDictionaryTestOne["Applications"] = tempDictionary
        
        writeAndReadMetaDataInformaionIntoJsonFileTest (metaData: variables.metaDataDictionaryTestOne)
        
        if (checkBoxCollection.count == 0){
            let result = dialogCheck(question: "No application has been selected to save.", text: "")
            if (result == true){
                dialogOK(question: "Information has been saved successfully without any metadata.", text: "Click OK to continue.")
                           variables.countNumber = variables.countNumber + 1
                           self.view.window?.close()
            }
            else {
                
            }
        }
        else {
            dialogOK(question: "Information has been saved successfully.", text: "Click OK to continue.")
            variables.countNumber = variables.countNumber + 1
            self.view.window?.close()
        }
        
    }
    
    func writeAndReadMetaDataInformaionIntoJsonFileTest (metaData : Dictionary<String, Any>){
        do {
            let jsonData = try! JSONSerialization.data(withJSONObject: metaData, options: JSONSerialization.WritingOptions.prettyPrinted)
                // here "decoded" is of type `Any`, decoded from JSON data
                // you can now cast it with the right type
            let url =  URL(fileURLWithPath: variables.jsonFilePathString)
            var fileSize : UInt64
            do {
                let attr = try FileManager.default.attributesOfItem(atPath: variables.jsonFilePathString)
                fileSize = attr[FileAttributeKey.size] as! UInt64
                if fileSize == 0{
                    print("json file is empty")
                    try jsonData.write(to: url, options : .atomic)
                }
                else{
                    let rawData : NSData = try! NSData(contentsOf: url)
                    do{
                        let jsonDataDictionary = try JSONSerialization.jsonObject(with : rawData as Data, options: JSONSerialization.ReadingOptions.mutableContainers)as? NSDictionary
                        let dictionaryOfReturnedJsonData = jsonDataDictionary as! Dictionary<String, AnyObject>
                        var jsonarray = dictionaryOfReturnedJsonData["BasicInformation"] as! [[String : Any]]
                        jsonarray.append(metaData)
                        jsonDataDictionary?.setValue(jsonarray, forKey: "BasicInformation")
                        let jsonData = try! JSONSerialization.data(withJSONObject : jsonDataDictionary, options: JSONSerialization.WritingOptions.prettyPrinted)
                        if let file = FileHandle(forWritingAtPath : variables.jsonFilePathString) {
                            file.write(jsonData)
                            file.closeFile()
                        }
                    }catch {print(error)}
                }
            } catch {
                print("preview Error: \(error)")
                }
            }
            catch{
                print(Error.self)
        }
    }
    
    @IBAction func deleteButtonAction(_ sender: Any) {
        variables.defaultTitle = ""
        let filePathString = variables.latesScreenShotPathString
        let fileURL = URL(fileURLWithPath: filePathString)
        do {
            try FileManager.default.removeItem(at: fileURL)
        } catch {
            print("delete screenshot error:", error)
        }
        dialogOK(question: "Information has been deleted successfully.", text: "Click OK to continue.")
        self.view.window?.close()
    }
    
    // func for pupup a alert window for saving and deleting
       func dialogOK(question: String, text: String) -> Bool {
           let alert = NSAlert()
           alert.messageText = question
           alert.informativeText = text
           alert.alertStyle = .warning
           alert.addButton(withTitle: "OK")
           return alert.runModal() == .alertFirstButtonReturn
       }
    
        func dialogCheck(question: String, text: String) -> Bool {
            let alert = NSAlert()
            alert.messageText = question
            alert.informativeText = text
            alert.alertStyle = .warning
            alert.addButton(withTitle: "Go ahead.")
            alert.addButton(withTitle: "Oh.")
            return alert.runModal() == .alertFirstButtonReturn
        }
        
}
