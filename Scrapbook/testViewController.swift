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
        
        let item = NSNib(nibNamed: "testColViewItem", bundle: nil)
        testColView.register(item, forItemWithIdentifier: .testItem)
        testColView.delegate = self
        testColView.dataSource = self
        self.title = "Capture View"
        
        timeLabelDisplay.stringValue = variables.currentTimeInformation
        
        captionLabelOne.stringValue = "Application Name:"
        captionLabelTwo.isHidden = true
        captionLabelThree.isHidden = true
        scrapbookTitle.stringValue = "Scrap: " + dateFromatGenerate() + "(Default)"
        displayLatestScreenshot()
        
        // Do view setup here.
    }
    
    @objc func firstInformationChange(_ sender: NSButton){
        // print(sender.title)
        captionLabelTwo.isHidden = false
        captionLabelThree.isHidden = false
        labelFirstInformation.stringValue = sender.title
        let tempDictionary = variables.metaDataDictionaryTestOne["Applications"] as! [String:[String]]
        // print(tempDictionary)
        let tempApplicationName = sender.title
        let tempApplicationMetaData = tempDictionary[tempApplicationName]
        print(tempApplicationMetaData![2])
        if tempApplicationMetaData![2] == "Safari" || tempApplicationMetaData![2] == "Google Chrome"{
            captionLabelTwo.stringValue = "url:"
            captionLabelThree.stringValue = "title:"
        }
        if tempApplicationMetaData![2] == "Prod1" || tempApplicationMetaData![2] == "Prod2" || tempApplicationMetaData![2] == "Xcode" || tempApplicationMetaData![2] == "Finder" {
            captionLabelTwo.stringValue = "path:"
            captionLabelThree.stringValue = "name:"
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
        if checkBoxCollection.contains(sender.title) {
            // print("checkboxcollection has already contained this application name")
        }
        else {
            checkBoxCollection.append(sender.title)
        }
        
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
           dateFormatter.dateFormat = "YYYY.MM.dd,HH:mm"
           let dateString = dateFormatter.string(from: date)
           return dateString
       }
    
    @IBAction func saveButtonAction(_ sender: Any) {
        print("this is checkbox collection: ", checkBoxCollection)
        
        variables.metaDataDictionaryTestOne["Title"] = [scrapbookTitle.stringValue]
        variables.metaDataDictionaryTestOne["Text"] = [scrapbookBody.stringValue]
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
        dialogOK(question: "Information has been saved successfully.", text: "Click OK to continue.")
        self.view.window?.close()
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
    
}
