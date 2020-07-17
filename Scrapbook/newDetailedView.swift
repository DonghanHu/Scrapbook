//
//  newDetailedView.swift
//  Scrapbook
//
//  Created by Donghan Hu on 2/21/20.
//  Copyright © 2020 Donghan Hu. All rights reserved.
//

import Cocoa

extension NSUserInterfaceItemIdentifier {
    static let detailedItem = NSUserInterfaceItemIdentifier("detailedColViewItem")
}

class newDetailedView: NSViewController , NSCollectionViewDelegate, NSCollectionViewDataSource {
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        // temp return 10
        let buttonNumber = detailedWiondwVariables.buttonNumber
        return buttonNumber;
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        let item = collectionView.makeItem(withIdentifier: .detailedItem, for: indexPath)
        detailedWiondwVariables.buttonCount = detailedWiondwVariables.buttonCount + 1
        return item
    }
    
    @IBOutlet weak var detailedColView: NSCollectionView!
    
    @IBOutlet weak var screenshotDisplay: NSImageView!
    @IBOutlet weak var currentTimeLabel: NSTextField!
    
    
    @IBOutlet weak var detailedInformationFirst: NSTextField!
    @IBOutlet weak var detailedInformationSecond: NSTextField!
    @IBOutlet weak var detailedInformationThird: NSTextField!
    
    @IBOutlet weak var scrapbookTitle: NSTextField!
    @IBOutlet weak var scrapbookBody: NSTextField!
    @IBOutlet weak var editableTitle: NSTextField!
    
    @IBOutlet weak var openSelectedApplicationsButton: NSButton!
    @IBOutlet weak var openAllApplicationsButton: NSButton!
    
    @IBOutlet weak var saveEditButton: NSButton!
    
    var checkBoxCollection = [String]()
    
    @IBOutlet weak var LabelOne: NSTextField!
    @IBOutlet weak var LabelTwo: NSTextField!
    
    @IBOutlet weak var LabelThree: NSTextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        LabelOne.stringValue = "Application Name:"
        LabelTwo.isHidden = true
        LabelThree.isHidden = true
        
        let item = NSNib(nibNamed: "detailedColViewItem", bundle: nil)
        detailedColView.register(item, forItemWithIdentifier: .detailedItem)
        detailedColView.delegate = self
        detailedColView.dataSource = self
        
        openSelectedApplicationsButton.title = "Open Selected Applications"
        openAllApplicationsButton.title = "Open All Applications"
        saveEditButton.title = "Save Change"
        self.title = "Detailed Window"
        // Do view setup here.
        
        let nsImage = NSImage(contentsOfFile: screenshotInDetailedView.path)
        nsImage?.prefersColorMatch = false
        nsImage?.matchesOnMultipleResolution = true
        screenshotDisplay.image = nsImage
        scrapbookTitle.stringValue = screenshotInDetailedView.title
        scrapbookTitle.isHidden = true
        
        
        editableTitle.stringValue = screenshotInDetailedView.title
        scrapbookBody.stringValue = screenshotInDetailedView.text
        
        let timetemp = detailedWiondwVariables.detailedDictionary["PhotoTime"] as![String]
        
        currentTimeLabel.stringValue = timetemp[2]
        
        detailedInformationFirst.stringValue = "click application button to dispaly."
        detailedInformationSecond.stringValue = "click application button to display."
        detailedInformationThird.stringValue = "click application button to display."
        
    }
    
    @objc func collectionViewButton (_ sender: NSButton){
        
        LabelTwo.isHidden = false
        LabelThree.isHidden = false
        
        print("button title", sender.title)
        detailedInformationFirst.stringValue = sender.title
        let detailedDictionary = detailedWiondwVariables.detailedDictionary["Applications"] as! [String:[String]]
        let tempApplicationName = sender.title
        let tempApplicationMetaData = detailedDictionary[tempApplicationName]
        
        if tempApplicationMetaData![2] == "Safari" || tempApplicationMetaData![2] == "Google Chrome"{
                   LabelTwo.stringValue = "URL:"
                   LabelThree.stringValue = "Title:"
               }
               if tempApplicationMetaData![2] == "Prod1" || tempApplicationMetaData![2] == "Prod2" || tempApplicationMetaData![2] == "Xcode" || tempApplicationMetaData![2] == "Finder" {
                   LabelTwo.stringValue = "Path:"
                   LabelThree.stringValue = "Name:"
               }
               
               if tempApplicationMetaData![2] == "Others"{
                   LabelTwo.stringValue = "other one"
                   LabelThree.stringValue = "other two"
               }
        
        
        if tempApplicationMetaData![0] != "" {
            detailedInformationSecond.stringValue = (tempApplicationMetaData?[0])!
        }
        else {
            detailedInformationSecond.stringValue = "Nothing here"
        }
        if tempApplicationMetaData![1] != "" {
            detailedInformationThird.stringValue = (tempApplicationMetaData?[1])!
        }
        else {
            detailedInformationThird.stringValue = "Nothing here"
        }
    }
    
    @objc func collectionViewCheckBox (_ sender: NSButton){
        
        print("check box title", sender.title)
        if checkBoxCollection.contains(sender.title) {
            // print("checkboxcollection has already contained this application name")
        }
        else {
            checkBoxCollection.append(sender.title)
        }
    }
    
    
    @IBAction func openApplicationsButton(_ sender: Any) {
        print("this is checkbox collection: ", checkBoxCollection)
        
        let dictionary = detailedWiondwVariables.detailedDictionary["Applications"] as! [String:[String]]
        var applicationArray = [String]()
        let keys: Array<String> = Array<String>( dictionary.keys)
        applicationArray = keys
        let keyLength = keys.count
        for i in 0..<keyLength{
            if checkBoxCollection.contains(keys[i]) {
                let applicationsName = applicationArray[i]
                let category = readCSVtoGetCategory(applicationName: applicationsName)
                let applescript = readCSVtoGetApplescript(applicationCategory: category, applicationName: applicationsName, dic: dictionary)
                print("final applescript", applescript)
                
                let truescript = runApplescript(applescript: applescript)
                AppleScript(script: truescript)
            }
            else {
                print("this app is not selected, hence not opened")
            }
            

        }
    }
    
    
    @IBAction func openAllAppsAction(_ sender: Any) {
        let dictionary = detailedWiondwVariables.detailedDictionary["Applications"] as! [String:[String]]
        var applicationArray = [String]()
        let keys: Array<String> = Array<String>( dictionary.keys)
        applicationArray = keys
        let keyLength = keys.count
        for i in 0..<keyLength{
            let applicationsName = applicationArray[i]
            let category = readCSVtoGetCategory(applicationName: applicationsName)
            let applescript = readCSVtoGetApplescript(applicationCategory: category, applicationName: applicationsName, dic: dictionary)
            print("final applescript", applescript)
            
            let truescript = runApplescript(applescript: applescript)
            AppleScript(script: truescript)
        }
        
    }
    
   func readCSVtoGetCategory(applicationName : String) -> String{
       let filepath = Bundle.main.path(forResource: "applescriptNameCategory", ofType: "csv")!
       var contents = try! String(contentsOfFile: filepath, encoding: .utf8)
       contents = cleanRows(file: contents)
       let csvRows = csv(data: contents)
       for i in 0..<csvRows.count{
           if csvRows[i][0] == applicationName {
               return csvRows[i][1]
           }
       }
       return "Others"
   }
    func readCSVtoGetApplescript(applicationCategory : String, applicationName : String, dic : Dictionary<String, [String]>) -> String{
        let filepath = Bundle.main.path(forResource: "applescriptCategoryCode", ofType: "csv")!
        var contents = try! String(contentsOfFile: filepath, encoding: .utf8)
        contents = cleanRows(file: contents)
        let csvRows = csv(data: contents)
        for i in 0..<csvRows.count{
            if csvRows[i][0] == applicationCategory {
                var final = String()
                let pathORurl = dic[applicationName]![0]
                if (applicationCategory == "Productivity") {
                    let temp = pathORurl.replacingOccurrences(of: "file://", with: "")
                    final = temp.replacingOccurrences(of: "%20", with: " ")
                }
                else {
                    final = pathORurl
                }
                let applescriptCode = csvRows[i][1] + applicationName + csvRows[i][2] + final + csvRows[1][3]
                
                return applescriptCode
            }
        }
        return "tell application" + applicationName + "to activate \n end tell"
    }
    func cleanRows(file:String)->String{
        var cleanFile = file
        cleanFile = cleanFile.replacingOccurrences(of: "\r", with: "\n")
        cleanFile = cleanFile.replacingOccurrences(of: "\n\n", with: "\n")
        return cleanFile
    }
    func csv(data: String) -> [[String]] {
        var result: [[String]] = []
        let rows = data.components(separatedBy: "\n")
        for row in rows {
            let columns = row.components(separatedBy: ",")
            result.append(columns)
        }
        return result
    }
    func AppleScript(script : String){
        var error: NSDictionary?
        let scriptObject = NSAppleScript(source: script)
        scriptObject!.executeAndReturnError(&error)
        if (error != nil) {
            print("error: \(String(describing: error))")
        }
    }
    func runApplescript(applescript : String) -> String{
        var error: NSDictionary?
        let scriptObject = NSAppleScript(source: applescript)
        let output: NSAppleEventDescriptor = scriptObject!.executeAndReturnError(&error)
        // print("output", output)
        if (error != nil) {
            print("error: \(String(describing: error))")
        }
        if output.stringValue == nil{
            let empty = "the result is empty"
            return empty
        }
        else {
            return (output.stringValue?.description)!
        }
    }
    
    @IBAction func saveButton(_ sender: Any) {
        
        // var detailedDictionary = detailedWiondwVariables.detailedDictionary["Applications"] as! [String:[String]]
        let oldOne = detailedWiondwVariables.detailedDictionary
        detailedWiondwVariables.detailedDictionary["Title"] = [editableTitle.stringValue]
        detailedWiondwVariables.detailedDictionary["Text"] = [scrapbookBody.stringValue]
        let newOne = detailedWiondwVariables.detailedDictionary

//        variables.metaDataDictionaryTestOne["PhotoTime"] = [variables.latestScreenShotTime, variables.latesScreenShotPathString, variables.currentTimeInformation]
//        var tempDictionary = variables.metaDataDictionaryTestOne["Applications"] as! [String:[String]]
//        let dictionary = [String:[String]]()
//        let length = checkBoxCollection.count
//        let keys: Array<String> = Array<String>(tempDictionary.keys)
//        let keyLength = keys.count
//        for i in 0..<keyLength{
//            if checkBoxCollection.contains(keys[i]){
//
//            }
//            else {
//                tempDictionary.removeValue(forKey: keys[i])
//            }
//        }
//        variables.metaDataDictionaryTestOne["Applications"] = tempDictionary
//
        
        //writeAndReadMetaDataInformaionIntoJsonFileTest (metaData: detailedWiondwVariables.detailedDictionary)
        let val = detailedWiondwVariables.detailedDictionary["PhotoTime"] as! [String]
        let keyTime = val[0]
        print("key value time", keyTime)
        tempfuction(newOne: newOne, timeVal: keyTime,  title: [editableTitle.stringValue], text: [scrapbookBody.stringValue])
        // dialogOK(question: "Detailed has been changed ans saved successfully.", text: "Click OK to continue.")
        // variables.countNumber = variables.countNumber + 1
        self.view.window?.close()

        // dialogOK(question: "Detailed has been changed ans saved successfully.", text: "Click OK to continue.")
    }
    
    
    func dialogOK(question: String, text: String) -> Bool {
              let alert = NSAlert()
              alert.messageText = question
              alert.informativeText = text
              alert.alertStyle = .warning
              alert.addButton(withTitle: "OK")
              return alert.runModal() == .alertFirstButtonReturn
    }
    
    func tempfuction (newOne : Dictionary<String, Any>, timeVal : String, title : [String], text : [String]){
        do {
            let jsonData = try! JSONSerialization.data(withJSONObject: newOne, options: JSONSerialization.WritingOptions.prettyPrinted)
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
                        let number = jsonarray.count

                        innerLoop: for i in 0..<number{
                            var tempelement = jsonarray[i]
                            if tempelement["PhotoTime"] != nil {
                                let kss =  tempelement["PhotoTime"] as! [String]
                                if kss[0] == timeVal {
                                    print("index", i)
                                    print("target jsonarry", tempelement)
                                    tempelement["Title"] = title
                                    tempelement["Text"] = text
                                    //jsonarray.remove(at: i)
                                    // print("changed element", tempelement)
                                    jsonarray[i] = tempelement
                                    //jsonDataDictionary?.setValue(jsonarray, forKey: "BasicInformation")
                                    //print("jsonDataDictionary1", jsonDataDictionary as Any)
                                    break innerLoop
                                }
                            }
                            
                        }
//                        var keyValue = temp["PhotoTime"]![0]
//                        jsonarray.dictionaryObject?.removeValue(forKey: keyValue)
//                        jsonarray.append(newOne)
                        
                    // print jsonarry, josnarry contains the whole metadata
                    // print("jsonarray", jsonarray)
                    jsonDataDictionary?.setValue(jsonarray, forKey: "BasicInformation")
                        
                    // print jsondata dictionary, this is the who json data content, including hello world and image conut number
                    // print("jsonDataDictionary display", jsonDataDictionary)
                        
                        
                    let emptyText = ""
                    let tempFilePathString = "file://" + variables.jsonFilePathString
                    let tempFIlePathURL = URL(string: tempFilePathString)
                        
                    // print temp file path in the URL format
                    // print("tempFIlePathURL,", tempFIlePathURL)
                        
                        
                    do {
                        try emptyText.write(to: tempFIlePathURL!, atomically: false, encoding: .utf8)
                       } catch {
                         print(error)
                       }
                        
                    
                    let jsonData = try! JSONSerialization.data(withJSONObject : jsonDataDictionary, options: JSONSerialization.WritingOptions.prettyPrinted)
                    if let file = FileHandle(forWritingAtPath : variables.jsonFilePathString) {
                        
                        // tried to print json data in string format, bur after transmission, it prints our the size of json data, like 1225 bytes.
                        // print("json data", jsonData)
                        
                        
                        // rewrite json data into target file
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
    
        func writeAndReadMetaDataInformaionIntoJsonFileTest (metaData : Dictionary<String, Any>, temp: Dictionary<String, Any>){
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
                            let number = jsonarray.count

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

    // end of the class
}
