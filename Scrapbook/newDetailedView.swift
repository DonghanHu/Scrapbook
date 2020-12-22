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

let notificationKeyDetailedWindow = ".scrapbook.notificationKey"

class newDetailedView: NSViewController , NSCollectionViewDelegate, NSCollectionViewDataSource, NSWindowDelegate {
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
    
    
    // tableView items
    

    @IBOutlet weak var tableView: NSTableView!
    @IBOutlet weak var openAllButoon: NSButtonCell!
    @IBOutlet weak var openSelectedButton: NSButton!
    @IBOutlet weak var stringLabel: NSTextField!
    @IBOutlet weak var deleteButton: NSButton!
    
    // unused ubutton, or used for testing
    @IBOutlet weak var testButton: NSButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        // NotificationCenter.default.addObserver(self, selector: #selector(newDetailedView.updateNotification), name: NSNotification.Name(rawValue: notificationKeyDetailedWindow), object: nil)
        
        LabelOne.stringValue = "Application Name:"
        LabelTwo.isHidden = true
        LabelThree.isHidden = true
        
        let item = NSNib(nibNamed: "detailedColViewItem", bundle: nil)
        detailedColView.register(item, forItemWithIdentifier: .detailedItem)
        detailedColView.delegate = self
        detailedColView.dataSource = self
        
        openSelectedApplicationsButton.title = "Open Selected Applications"
        openAllApplicationsButton.title = "Open All Applications"
        //saveEditButton.title = "Save"
        saveEditButton.title = "Close"
        self.title = "Detailed Window"
        // Do view setup here.
        
        // hide old items
        openSelectedApplicationsButton.isHidden = true
        openAllApplicationsButton.isHidden = true
        detailedColView.isHidden = true
        
        testButton.isHidden = true
        
        let nsImage = NSImage(contentsOfFile: screenshotInDetailedView.path)
        nsImage?.prefersColorMatch = false
        nsImage?.matchesOnMultipleResolution = true
        screenshotDisplay.image = nsImage
        screenshotDisplay.imageScaling = .scaleProportionallyUpOrDown
        scrapbookTitle.stringValue = screenshotInDetailedView.title
        scrapbookTitle.isHidden = true
        
        
        editableTitle.stringValue = screenshotInDetailedView.title
        scrapbookBody.stringValue = screenshotInDetailedView.text
        
        let timetemp = detailedWiondwVariables.detailedDictionary["PhotoTime"] as![String]
        
        currentTimeLabel.stringValue = timetemp[2]
        
        detailedInformationFirst.stringValue = "click application button to dispaly."
        detailedInformationSecond.stringValue = "click application button to display."
        detailedInformationThird.stringValue = "click application button to display."
        
        
        // for tableview
        tableView.delegate = self
        tableView.dataSource = self
        tableView.target = self
        tableView.action = #selector(tableViewSingleClick(_:))
        openSelectedButton.title = "Open selected applications"
        openAllButoon.title = "Open all applications"
        deleteButton.title = "Delete"
        
    }
    
    @objc func updateNotification(){
        print("looks like that notification center worked")
    }
    
    @objc func collectionViewButton (_ sender: NSButton){
        
        print("sender frame", sender.frame)
        
        print("sender state 1", sender.state)
        
        
//        NSAnimationContext.runAnimationGroup({(context) -> Void in
//            context.duration = 5.0
//            sender.contentTintColor = NSColor.red
//
//            sender.animator().alphaValue = 1
//        }) {
//            print("Animation done")
//        }
        print(sender.font)
        sender.contentTintColor = NSColor.red
        sender.font = NSFont(name: "Monaco", size: 14.0)
        let secondsToDelay = 1.5
        DispatchQueue.main.asyncAfter(deadline: .now() + secondsToDelay) {
            print("This message is delayed")
           // Put any code you want to be delayed here
            sender.contentTintColor = NSColor.black
            sender.font = NSFont(name: "AppleSystemUIFont", size: 14.0)
        }
        print("change to red")
        //sender.contentTintColor = NSColor.black
        
//        NSAnimationContext.runAnimationGroup({ (context) in
//
//            context.duration = 10.0
//          // Use the value you want to animate to (NOT the starting value)
//            sender.animator().alphaValue = 0
//        })
        
        LabelTwo.isHidden = false
        LabelThree.isHidden = false
        
        // var attributedString = NSMutableAttributedString(string:sender.title)
        
        let appNameString = sender.title as NSString
        let tempNameString = sender.title as NSString
        let range = (appNameString as NSString).range(of: tempNameString as String)

        let attribute = NSMutableAttributedString.init(string: appNameString as String)
        attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: NSColor.red , range: range)
        // sender.font = NSFont(name: "Monaco", size: 12.0)
        print("attribute", attribute)
        sender.attributedStringValue = attribute
        
        let namelength = variables.detailedApplicationNameList.count
        
        sender.bezelColor = NSColor.red
    
       // sender.title.addAttribute(NSAttributedString.Key.foregroundColor, value: NSColor.red , range: range)
        
        
        
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
        print("sender state 2", sender.state)
        // checkbox states detection
        if (sender.state == .on && !checkBoxCollection.contains(sender.title)){
            checkBoxCollection.append(sender.title)
        }
        else if (sender.state == .off && checkBoxCollection.contains(sender.title)){
            let index = checkBoxCollection.firstIndex(of: sender.title)
            checkBoxCollection.remove(at: index!)
        }
          
        
//        print("check box title", sender.title)
//        if checkBoxCollection.contains(sender.title) {
//            // print("checkboxcollection has already contained this application name")
//        }
//        else {
//            checkBoxCollection.append(sender.title)
//        }
        
    }
    
    
    @IBAction func openApplicationsButton(_ sender: Any) {
        print("this is checkbox collection: ", checkBoxCollection)
        
        let dictionary = detailedWiondwVariables.detailedDictionary["Applications"] as! [String:[String]]
        var applicationArray = [String]()
        let keys: Array<String> = Array<String>( dictionary.keys)
        applicationArray = keys
        let keyLength = keys.count
        print("key length", keyLength)

        for i in 0..<keyLength{
            if checkBoxCollection.contains(keys[i]) {
                let applicationsName = applicationArray[i]
                let category = readCSVtoGetCategory(applicationName: applicationsName)
                var applescript = ""
                var index = " "
                var localpath = " "
                if (applicationsName == "Acrobat Reader"){
                    applescript = readCSVtoGetApplescript(applicationCategory: category, applicationName: "Adobe Acrobat Reader DC", dic: dictionary)[0]
                    index = readCSVtoGetApplescript(applicationCategory: category, applicationName: "Adobe Acrobat Reader DC", dic: dictionary)[1]
                    localpath = readCSVtoGetApplescript(applicationCategory: category, applicationName: "Adobe Acrobat Reader DC", dic: dictionary)[2]
                }
                else {
                    applescript = readCSVtoGetApplescript(applicationCategory: category, applicationName: applicationsName, dic: dictionary)[0]
                    index = readCSVtoGetApplescript(applicationCategory: category, applicationName: applicationsName, dic: dictionary)[1]
                    localpath = readCSVtoGetApplescript(applicationCategory: category, applicationName: applicationsName, dic: dictionary)[2]
                }
                
                print("first final applescript", applescript)
                if index == "1" {
                    let truescript = runApplescript(applescript: applescript)
                    print("after transmitted", truescript)
                    AppleScript(script: truescript)
                }
                else if index == "0"{
                    let alert = NSAlert.init()
                    alert.messageText = "Hi"
                    let inforstring = "No file found, you may have changed the file name, move to another folder or delte the orginal file.\n " + "This is the saved path: " + localpath
                    alert.informativeText = inforstring
                    alert.addButton(withTitle: "OK")
                    //alert.addButton(withTitle: "Cancel")
                    alert.runModal()
                }
//                let truescript = runApplescript(applescript: applescript)
//                print("after transmitted", truescript)
//                AppleScript(script: truescript)
                
                
            }
            else {
                let alert = NSAlert.init()
                alert.messageText = "Hi"
                let inforstring = "You have not selected any application. Please check again."
                alert.informativeText = inforstring
                alert.addButton(withTitle: "OK")
                //alert.addButton(withTitle: "Cancel")
                alert.runModal()
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
            let applescript = readCSVtoGetApplescript(applicationCategory: category, applicationName: applicationsName, dic: dictionary)[0]
            let index = readCSVtoGetApplescript(applicationCategory: category, applicationName: applicationsName, dic: dictionary)[1]
            let localpath = readCSVtoGetApplescript(applicationCategory: category, applicationName: applicationsName, dic: dictionary)[2]
            print("second final applescript", applescript)
            if index == "1" {
                let truescript = runApplescript(applescript: applescript)
                AppleScript(script: truescript)
            }
            else if index == "0" {
                let alert = NSAlert.init()
                alert.messageText = "Hi"
                let inforstring = "No file found, you may have changed the file name, move to another folder or delte the orginal file.\n" + "This is the saved path: " + localpath
                alert.informativeText = inforstring
                
                alert.addButton(withTitle: "OK")
                //alert.addButton(withTitle: "Cancel")
                alert.runModal()
            }
            
            
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
    // code here
    func readCSVtoGetApplescript(applicationCategory : String, applicationName : String, dic : Dictionary<String, [String]>) -> [String]{
        var applicationNameWithRank = applicationName
        let cutString = "#"
        var newApplicationNameArray = applicationName.components(separatedBy: cutString)
        var OriginapplicationName = newApplicationNameArray[0]
        
        let filepath = Bundle.main.path(forResource: "applescriptCategoryCode", ofType: "csv")!
        var contents = try! String(contentsOfFile: filepath, encoding: .utf8)
        contents = cleanRows(file: contents)
        let csvRows = csv(data: contents)
        if OriginapplicationName == "Adobe Acrobat Reader DC" {
            OriginapplicationName = "Acrobat Reader"
        }
        var applescriptStrings = [String]()
        for i in 0..<csvRows.count{

            if csvRows[i][0] == applicationCategory {
                var final = String()
                let pathORurl = dic[applicationName]![0]
                // let pathORurl = dic[tempapplicationName]![0]
                if (applicationCategory == "Productivity" || applicationCategory == "Acrobat Reader" || applicationCategory == "Finder") {
                    let temp = pathORurl.replacingOccurrences(of: "file://", with: "")
                    final = temp.replacingOccurrences(of: "%20", with: " ")
                }
                else {
                    final = pathORurl
                }
                var applescriptCode = csvRows[i][1] + OriginapplicationName + csvRows[i][2] + final + csvRows[i][3]
                applescriptStrings.append(applescriptCode)
                // final is the document path
                if (applicationCategory == "Productivity" || applicationCategory == "Acrobat Reader" || applicationCategory == "Finder"){
                    if FileManager.default.fileExists(atPath: final){
                        let index = "1"
                        applescriptStrings.append(index)
                    }
                    else{
                        let index = "0"
                        applescriptStrings.append(index)
//                        let alert = NSAlert.init()
//                        alert.messageText = "Hi"
//                        alert.informativeText = "No file found, you may have changed the file name, move to another folder or delte the orginal file."
//                        alert.addButton(withTitle: "OK")
//                        //alert.addButton(withTitle: "Cancel")
//                        alert.runModal()
                    }
                }
                else {
                    let index = "1"
                    applescriptStrings.append(index)
                }
                applescriptStrings.append(final)
                return applescriptStrings
                // return applescriptCode
            }
        }
        // return "tell application " + applicationName + "\n activate \n end tell"
        let tempstring = "tell application " + OriginapplicationName + " to activate \n end tell"
        var tempresult = [String]()
        tempresult.append(tempstring)
        // 2 means nothing to reopen or retrieve
        tempresult.append("2")
        //return "tell application " + applicationName + " to activate \n end tell"
        return tempresult
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
        print("applescript result", scriptObject)
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
        
        //writeAndReadMetaDataInformaionIntoJsonFileTest (metaData: detailedWiondwVariables.detailedDictionary)
        let val = detailedWiondwVariables.detailedDictionary["PhotoTime"] as! [String]
        let keyTime = val[0]
        print("key value time", keyTime)
        // code here, cant save new title and memo
        tempfuction(newOne: newOne, timeVal: keyTime,  title: [editableTitle.stringValue], text: [scrapbookBody.stringValue])
        
        // the saving action is automatice, so dont display this popup window
        // dialogOK(question: "Detailed has been changed ans saved successfully.", text: "Click OK to continue.")
        
        
        // variables.countNumber = variables.countNumber + 1
        self.view.window?.close()

        
        // the saving action is automatice, so dont display this popup window
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
    
    func dialogDelete(question: String, text: String) -> Bool{
        let alert = NSAlert()
        alert.messageText = question
        alert.informativeText = text
        alert.alertStyle = .warning
        alert.addButton(withTitle: "Delete.")
        alert.addButton(withTitle:"Cancel.")
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
                                    // print("target jsonarry", tempelement)
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

    // action for the delete button
    @IBAction func deleteButtonAction(_ sender: Any) {
        
        // sending notification here
        // NotificationCenter.default.post(name: NSNotification.Name(rawValue: notificationKeyDetailedWindow), object: self)
        
        
        
        
        // delete the screenshot(image)
        let value = dialogDelete(question: "Are you sure that you wan to delete this recording?", text: "This recording will be deleted permanently and this action cannot be undone!")
        // wait a minute return false, yes return true
        // print(value, "value")
        
        if value == true{
            let filePathString = screenshotInDetailedView.path!
            let fileURL = URL(fileURLWithPath: filePathString)
            do {
                try FileManager.default.removeItem(at: fileURL)
            } catch {
                print("delete screenshot error:", error)
            }
            
            // delete the json file data
            let detailedInfor = detailedWiondwVariables.detailedDictionary["PhotoTime"] as! [String]
            let timeInfor = detailedInfor[0]
            let url =  URL(fileURLWithPath: variables.jsonFilePathString)
            var fileSize : UInt64
            do {
                let attr = try FileManager.default.attributesOfItem(atPath: variables.jsonFilePathString)
                fileSize = attr[FileAttributeKey.size] as! UInt64
                if fileSize == 0{
                    print("json file is empty")
                }
                else{
                    let rawData : NSData = try! NSData(contentsOf: url)
                    do{
                        let jsonDataDictionary = try JSONSerialization.jsonObject(with : rawData as Data, options: JSONSerialization.ReadingOptions.mutableContainers)as? NSDictionary
                        
                        let dictionaryOfReturnedJsonData = jsonDataDictionary as! Dictionary<String, AnyObject>
                        
                        var jsonarray = dictionaryOfReturnedJsonData["BasicInformation"] as! [[String : Any]]
                        
                        let tempDic : [String : Any] = ["Text"             :   String(),
                                                        "Title"            :   String(),
                                                        "PhotoTime"        :   [String](),
                                                        "screenshotPath"   :   [String](),
                                                        "Applications"     :   [String:[String]](),
                                                        "Coordinates"      :   [String:[String]]()
                                                        ]
                        let number = jsonarray.count
                        innerLoop: for i in 0..<number{
                            var tempelement = jsonarray[i]
                            if tempelement["PhotoTime"] != nil {
                                let kss =  tempelement["PhotoTime"] as! [String]
                                if kss[0] == timeInfor {
                                    print("index", i)
                                    // print the target json information
                                    //print("target jsonarry", tempelement)
                                    jsonarray.remove(at: i)
                                    break innerLoop
                                }
                            }
                            
                        }
                        // print("new json", jsonarray)
                        jsonDataDictionary?.setValue(jsonarray, forKey: "BasicInformation")
                        let emptyText = ""
                        let tempFilePathString = "file://" + variables.jsonFilePathString
                        let tempFIlePathURL = URL(string: tempFilePathString)
                        do {
                            try emptyText.write(to: tempFIlePathURL!, atomically: false, encoding: .utf8)
                        } catch {
                             print(error)
                        }
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
                    
            variables.countNumber = variables.countNumber - 1
            
            //change here
            // diaryInformationCollection.photoNameFirstInformation = diaryInformationCollection.photoNameFirstInformation - 1
            
            // variables.dateCountNumber = variables.dateCountNumber - 1
            getAllAvailableScrapbookList()
            divideIntoTwoArray(stringArray: diaryInformationCollection.photoNameList)
            // the count was not mins 1

            print(diaryInformationCollection.photoNameList.count)
            photoNameListGenerate()
            // print(detailedInfor)
            
            // dont display this popup window
            // dialogOK(question: "Information has been deleted successfully.", text: "Click OK to continue.")
            
            
            // automatically refresh collection view here
            
    //        let handler = collectionViewController()
    //        handler.alternativeRefreshAction()
            
            
            
            // refresh the collection view here
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: notificationValues.notificationKey), object: (Any).self)
            
            // close the self window
            self.view.window?.close()
        }

        else{
            // noting happened here is click wait a minute
            // no deleteing

        }
        

        NotificationCenter.default.post(name: NSNotification.Name(rawValue: notificationValues.notificationKey), object: (Any).self)
        
        //collectionViewController.alternativeRefreshAction(collectionViewController)

        
    }
    
    @IBAction func testButton(_ sender: Any) {
        self.view.window?.close()
        
        // collectionViewController().testPrint()
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
                // print json array after deletion
                // print("after delete, json array", jsonarray)
                // print(jsonarray.count)
                
                let length = jsonarray.count
                // length cant be less than 1
                if (length == 1){
                // if (photonumber.inputRelatedMessage.count == length || length == 1 || length == 0){
                    print("nothing happen")
                    // diaryInformationCollection.photoNameList = [[""]]
                    //photonumber.inputRelatedMessage = [""]
                    //photonumber.inputRelatedTitle = [""]
                    
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
                    }
                    photonumber.inputRelatedMessage = inputMessageList
                    photonumber.inputRelatedTitle   = inputMessageTitleList
                }

            // end of do judgement
            }
        } catch {
            print("preview Error: \(error)")
        }
    }
    
    func divideIntoTwoArray(stringArray: [[String]]){
        var arrayOfFirstInformation = [String]()
        var arrayOfSecondInformation = [String]()
        let length = stringArray.count
        if stringArray != [[""]] {
            for i in 0..<length{
                arrayOfFirstInformation.append(stringArray[i][0])
                arrayOfSecondInformation.append(stringArray[i][1])
            }
        }
        diaryInformationCollection.photoNameFirstInformation = arrayOfFirstInformation
        diaryInformationCollection.photoNameSecondInformation = arrayOfSecondInformation
    }
    
    func photoNameListGenerate(){
        for i in 0..<diaryInformationCollection.photoNameSecondInformation.count{
            if photonumber.photoPathList.contains(diaryInformationCollection.photoNameSecondInformation[i]){
            }
            else {
                photonumber.photoPathList.append(diaryInformationCollection.photoNameSecondInformation[i])
            }
        }
    }
    
    
    // functions for tableview
    func updateStatus() {
      
        let text: String

        // 1
        let itemsSelected = tableView.selectedRowIndexes.count

        // 2
        if(itemsSelected == 0) {
        text = "\(variables.recordedApplicationNameStack.count) items"
        }
        else {
        text = "\(itemsSelected) of \(variables.detailedApplicationNameList.count) selected"
        }
        // 3
        stringLabel.stringValue = text
    }
    
    @IBAction func openAllApplications(_ sender: Any) {
        let dictionary = detailedWiondwVariables.detailedDictionary["Applications"] as! [String:[String]]
        var applicationArray = [String]()
        let keys: Array<String> = Array<String>(dictionary.keys)
        applicationArray = keys
        let keyLength = keys.count
        for i in 0..<keyLength{
            let applicationsNameWithRank = applicationArray[i]
            // code here
            let applicationsName = applicationsNameWithRank
            let applicationsNameForCategory = dictionary[applicationsNameWithRank]![3]
            // till here
            
            let category = readCSVtoGetCategory(applicationName: applicationsNameForCategory)
            let temp = readCSVtoGetApplescript(applicationCategory: category, applicationName: applicationsName, dic: dictionary)
            let applescript = readCSVtoGetApplescript(applicationCategory: category, applicationName: applicationsName, dic: dictionary)[0]
            let index = readCSVtoGetApplescript(applicationCategory: category, applicationName: applicationsName, dic: dictionary)[1]
            let localpath = readCSVtoGetApplescript(applicationCategory: category, applicationName: applicationsName, dic: dictionary)[2]
            print("second final applescript", applescript)
            if index == "1" {
                let truescript = runApplescript(applescript: applescript)
                AppleScript(script: truescript)
            }
            else if index == "0" {
                let alert = NSAlert.init()
                alert.messageText = "Hi"
                let inforstring = "No file found, you may have changed the file name, move to another folder or delte the orginal file.\n" + "This is the saved path: " + localpath
                alert.informativeText = inforstring
                
                alert.addButton(withTitle: "OK")
                //alert.addButton(withTitle: "Cancel")
                alert.runModal()
            }
            
            
        }
    }
    func openSelectedAppCheckBox(){
        let dictionary = detailedWiondwVariables.detailedDictionary["Applications"] as! [String:[String]]
        var applicationArray = [String]()
        let keys: Array<String> = Array<String>( dictionary.keys)
        applicationArray = keys
        let keyLength = keys.count
        var tempNameStack = [""]
        if checkboxInformationCaptureWindoe.clickstatusDetailedWindow == 0{
            tempNameStack = variables.detailedApplicationNameList
        }else{
            tempNameStack = checkboxInformationCaptureWindoe.checkboxNameStackDetailedWindow
        }
        let nameStackLen = tempNameStack.count
        var emptyCount = 0
        for j in 0..<nameStackLen{
            if tempNameStack[j] == "Empty"{
                emptyCount = emptyCount + 1
            }
        }
        var nilEmptyCount = nameStackLen - emptyCount
        if (nilEmptyCount == 0){
            let alert = NSAlert.init()
            alert.messageText = "Hi"
            let inforstring = "No applications have been selected now. Please check your choices again. Thank you!"
            alert.informativeText = inforstring
            alert.addButton(withTitle: "OK")
            alert.runModal()
        }
        else{
            for i in 0..<keyLength{
                if tempNameStack.contains(keys[i]) {
                    let applicationsName = applicationArray[i]
                    let category = readCSVtoGetCategory(applicationName: applicationsName)
                    var applescript = ""
                    var index = " "
                    var localpath = " "
                    if (applicationsName == "Acrobat Reader"){
                        applescript = readCSVtoGetApplescript(applicationCategory: category, applicationName: "Adobe Acrobat Reader DC", dic: dictionary)[0]
                        index = readCSVtoGetApplescript(applicationCategory: category, applicationName: "Adobe Acrobat Reader DC", dic: dictionary)[1]
                        localpath = readCSVtoGetApplescript(applicationCategory: category, applicationName: "Adobe Acrobat Reader DC", dic: dictionary)[2]
                    }
                    else {
                        applescript = readCSVtoGetApplescript(applicationCategory: category, applicationName: applicationsName, dic: dictionary)[0]
                        index = readCSVtoGetApplescript(applicationCategory: category, applicationName: applicationsName, dic: dictionary)[1]
                        localpath = readCSVtoGetApplescript(applicationCategory: category, applicationName: applicationsName, dic: dictionary)[2]
                    }
                    
                    print("first final applescript", applescript)
                    if index == "1" {
                        let truescript = runApplescript(applescript: applescript)
                        print("after transmitted", truescript)
                        AppleScript(script: truescript)
                    }
                    else if index == "0"{
                        let alert = NSAlert.init()
                        alert.messageText = "Hi"
                        let inforstring = "No file found, you may have changed the file name, move to another folder or delte the orginal file.\n " + "This is the saved path: " + localpath
                        alert.informativeText = inforstring
                        alert.addButton(withTitle: "OK")
                        //alert.addButton(withTitle: "Cancel")
                        alert.runModal()
                    }
                    
                }// end if tempNameStack.contains(keys[i])
            }//end for loop
        }
    }
    
    @IBAction func openSelectedApplications(_ sender: Any) {
//        let dictionary = detailedWiondwVariables.detailedDictionary["Applications"] as! [String:[String]]
//        var applicationArray = [String]()
//        let keys: Array<String> = Array<String>( dictionary.keys)
//        applicationArray = keys
//        let keyLength = keys.count
//        var selectionCollection = [Int]()
//        var selectionCollectionNames = [String]()
//        for (name, index) in tableView.selectedRowIndexes.enumerated() {
//            print(index)
//            selectionCollection.append(index)
//            let temp = variables.detailedApplicationNameList[index]
//            selectionCollectionNames.append(temp)
//        }
//        let totalCount = selectionCollection.count
//        if(totalCount == 0){
//            let alert = NSAlert.init()
//            alert.messageText = "Hi"
//            let inforstring = "No applications have been selected now. Please check your choices again. Thank you!"
//            alert.informativeText = inforstring
//            alert.addButton(withTitle: "OK")
//            alert.runModal()
//        }else {
//            for i in 0..<keyLength{
//                if selectionCollectionNames.contains(keys[i]) {
//                    let applicationsName = applicationArray[i]
//                    let category = readCSVtoGetCategory(applicationName: applicationsName)
//                    var applescript = ""
//                    var index = " "
//                    var localpath = " "
//                    if (applicationsName == "Acrobat Reader"){
//                        applescript = readCSVtoGetApplescript(applicationCategory: category, applicationName: "Adobe Acrobat Reader DC", dic: dictionary)[0]
//                        index = readCSVtoGetApplescript(applicationCategory: category, applicationName: "Adobe Acrobat Reader DC", dic: dictionary)[1]
//                        localpath = readCSVtoGetApplescript(applicationCategory: category, applicationName: "Adobe Acrobat Reader DC", dic: dictionary)[2]
//                    }
//                    else {
//                        applescript = readCSVtoGetApplescript(applicationCategory: category, applicationName: applicationsName, dic: dictionary)[0]
//                        index = readCSVtoGetApplescript(applicationCategory: category, applicationName: applicationsName, dic: dictionary)[1]
//                        localpath = readCSVtoGetApplescript(applicationCategory: category, applicationName: applicationsName, dic: dictionary)[2]
//                    }
//                    print("first final applescript", applescript)
//                    if index == "1" {
//                        let truescript = runApplescript(applescript: applescript)
//                        print("after transmitted", truescript)
//                        AppleScript(script: truescript)
//                    }
//                    else if index == "0"{
//                        let alert = NSAlert.init()
//                        alert.messageText = "Hi"
//                        let inforstring = "No file found, you may have changed the file name, move to another folder or delte the orginal file.\n " + "This is the saved path: " + localpath
//                        alert.informativeText = inforstring
//                        alert.addButton(withTitle: "OK")
//                        alert.runModal()
//                    }
//                }
//            }
//        }
        let dictionary = detailedWiondwVariables.detailedDictionary["Applications"] as! [String:[String]]
        var applicationArray = [String]()
        let keys: Array<String> = Array<String>( dictionary.keys)
        applicationArray = keys
        let keyLength = keys.count
        var tempNameStack = [""]
        if checkboxInformationCaptureWindoe.clickstatusDetailedWindow == 0{
            tempNameStack = variables.detailedApplicationNameList
        }else{
            tempNameStack = checkboxInformationCaptureWindoe.checkboxNameStackDetailedWindow
        }
        let nameStackLen = tempNameStack.count
        var emptyCount = 0
        for j in 0..<nameStackLen{
            if tempNameStack[j] == "Empty"{
                emptyCount = emptyCount + 1
            }
        }
        var nilEmptyCount = nameStackLen - emptyCount
        if (nilEmptyCount == 0){
            let alert = NSAlert.init()
            alert.messageText = "Hi"
            let inforstring = "No applications have been selected now. Please check your choices again. Thank you!"
            alert.informativeText = inforstring
            alert.addButton(withTitle: "OK")
            alert.runModal()
        }
        else{
            for i in 0..<keyLength{
                
                if tempNameStack.contains(keys[i]) {
                    // new
                    let applicationsNameWithRank = applicationArray[i]
                    let applicationsName = dictionary[applicationsNameWithRank]![3]
                    
                    
                    // till here
                    // old one
                    // let applicationsName = applicationArray[i]
                    // second method
//                    let temp = applicationArray[i]
//                    var delimiter = "#"
//                    let originName = temp.components(separatedBy: delimiter)
                    //
                    
                    let category = readCSVtoGetCategory(applicationName: applicationsName)
                    var applescript = ""
                    var index = " "
                    var localpath = " "
                    if (applicationsName == "Acrobat Reader"){
                        applescript = readCSVtoGetApplescript(applicationCategory: category, applicationName: "Adobe Acrobat Reader DC", dic: dictionary)[0]
                        index = readCSVtoGetApplescript(applicationCategory: category, applicationName: "Adobe Acrobat Reader DC", dic: dictionary)[1]
                        localpath = readCSVtoGetApplescript(applicationCategory: category, applicationName: "Adobe Acrobat Reader DC", dic: dictionary)[2]
                    }
                    else {
                        applescript = readCSVtoGetApplescript(applicationCategory: category, applicationName: applicationsName, dic: dictionary)[0]
                        index = readCSVtoGetApplescript(applicationCategory: category, applicationName: applicationsName, dic: dictionary)[1]
                        localpath = readCSVtoGetApplescript(applicationCategory: category, applicationName: applicationsName, dic: dictionary)[2]
                    }
                    
                    print("first final applescript", applescript)
                    if index == "1" {
                        let truescript = runApplescript(applescript: applescript)
                        print("after transmitted", truescript)
                        AppleScript(script: truescript)
                    }
                    else if index == "0"{
                        let alert = NSAlert.init()
                        alert.messageText = "Hi"
                        let inforstring = "No file found, you may have changed the file name, move to another folder or delte the orginal file.\n " + "This is the saved path: " + localpath
                        alert.informativeText = inforstring
                        alert.addButton(withTitle: "OK")
                        //alert.addButton(withTitle: "Cancel")
                        alert.runModal()
                    }
                    
                }// end if tempNameStack.contains(keys[i])
            }//end for loop
        }

    }
    
    @objc func tableViewSingleClick(_ sender:AnyObject){
        LabelOne.isHidden = false
        if (tableView.selectedRowIndexes.count == 1){
            // variables.detailedApplicationNameList
            detailedInformationFirst.stringValue = variables.detailedApplicationNameList[tableView.selectedRow]
            let detailedDictionary = detailedWiondwVariables.detailedDictionary["Applications"] as! [String:[String]]
            let tempApplicationName = variables.detailedApplicationNameList[tableView.selectedRow]
            let tempApplicationMetaData = detailedDictionary[tempApplicationName]
            
            if tempApplicationMetaData![2] == "Safari" || tempApplicationMetaData![2] == "Google Chrome"{
                    LabelTwo.isHidden = false
                    LabelThree.isHidden = false
                    LabelTwo.stringValue = "URL:"
                    LabelThree.stringValue = "Title:"
                   }
                   if tempApplicationMetaData![2] == "Prod1" || tempApplicationMetaData![2] == "Prod2" || tempApplicationMetaData![2] == "Xcode" || tempApplicationMetaData![2] == "Finder" {
                        LabelTwo.isHidden = false
                        LabelThree.isHidden = false
                        LabelTwo.stringValue = "Path:"
                        LabelThree.stringValue = "Name:"
                   }
                   
                   if tempApplicationMetaData![2] == "Others"{
                        LabelTwo.isHidden = false
                        LabelThree.isHidden = false
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
    }
    
    @objc func checkBoxInteraction(_ sender: NSButton){
        print(sender.title)
        if !checkboxInformationCaptureWindoe.checkboxNameStackDetailedWindow.contains("Empty"){
            checkboxInformationCaptureWindoe.checkboxNameStackDetailedWindow = variables.detailedApplicationNameList
        }
        let length = checkboxInformationCaptureWindoe.checkboxNameStackDetailedWindow.count
        if (sender.state == .off){
            for i in 0..<length{
                if checkboxInformationCaptureWindoe.checkboxNameStackDetailedWindow[i] == sender.title{
                    checkboxInformationCaptureWindoe.checkboxNameStackDetailedWindow[i] = "Empty"
                    break
                }
            }
        }else {
                if !checkboxInformationCaptureWindoe.checkboxNameStackDetailedWindow.contains(sender.title){
                    let len = variables.detailedApplicationNameList.count
                    for j in 0..<len{
                        if variables.detailedApplicationNameList[j] == sender.title{
                            checkboxInformationCaptureWindoe.checkboxNameStackDetailedWindow[j] = sender.title
                        }
                    }
                    // checkboxInformationCaptureWindoe.checkboxNameStack.append(sender.title)
            }
        }
        print("current name stack", checkboxInformationCaptureWindoe.checkboxNameStackDetailedWindow)
        checkboxInformationCaptureWindoe.clickstatusDetailedWindow = 1
    }
    
    
    //edit close button interaction
    override func viewDidAppear() {
        view.window?.level = .floating
        self.view.window?.delegate = self
        
    }
    func windowWillClose(_ notification: Notification) {
        print("hhhh")
        autosaveFunction()
    }
    
    // save changeing when users click close button
    func autosaveFunction(){
        let oldOne = detailedWiondwVariables.detailedDictionary
        detailedWiondwVariables.detailedDictionary["Title"] = [editableTitle.stringValue]
        detailedWiondwVariables.detailedDictionary["Text"] = [scrapbookBody.stringValue]
        let newOne = detailedWiondwVariables.detailedDictionary
        let val = detailedWiondwVariables.detailedDictionary["PhotoTime"] as! [String]
        let keyTime = val[0]
        print("key value time", keyTime)
        tempfuction(newOne: newOne, timeVal: keyTime,  title: [editableTitle.stringValue], text: [scrapbookBody.stringValue])
        // dont show a dialog pop window
        
        //dialogOK(question: "Detailed has been changed ans saved successfully.", text: "Click OK to continue.")
    }
    // end of the class
}

extension newDetailedView: NSTableViewDataSource {
  
  func numberOfRows(in tableView: NSTableView) -> Int {
    // return the number of application names
    let dictionary = detailedWiondwVariables.detailedDictionary["Applications"] as! [String:[String]]
    
    var applicationNameStack = [String]()
    let keys: Array<String> = Array<String>(dictionary.keys)
    applicationNameStack = keys
    
    variables.detailedApplicationNameList = applicationNameStack
    
    let temp = variables.detailedApplicationNameList
    print("name list in detailed view table view", temp)
    // print(diaryInformationCollection.photoNameFirstInformation.count)
    return variables.detailedApplicationNameList.count
  }

}
extension newDetailedView: NSTableViewDelegate {

    fileprivate enum CellIdentifiers {
        static let NameCell = "NameCellID"
        static let CheckBoxCell = "CheckboxCellID"
    }

    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {

    var image: NSImage?
    var text: String = ""
    var cellIdentifier: String = ""

    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .long
    dateFormatter.timeStyle = .long

    let item = variables.detailedApplicationNameList[row]

    //    guard let item = directoryItems?[row] else {
    //      return nil
    //    }

    // 2
    if tableColumn == tableView.tableColumns[1] {
      // image = item.icon
        text = item
        cellIdentifier = CellIdentifiers.NameCell
        if let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: cellIdentifier), owner: nil) as? NSTableCellView {
            print("text", text)
          cell.textField?.stringValue = text
          // cell.imageView?.image = image ?? nil
          return cell
        }
        
    } else if tableColumn == tableView.tableColumns[0]{
        text = ""
        cellIdentifier = CellIdentifiers.CheckBoxCell
        
        let checkBoxFrame = NSRect(x: 10, y: 8, width: 25, height: 25)
        let newCheckBut = NSButton.init(checkboxWithTitle: item, target: nil, action: #selector(newDetailedView.checkBoxInteraction(_:)))
        newCheckBut.frame = checkBoxFrame
               
        newCheckBut.state = .on
        
        return newCheckBut
    }
    
    else{
        print("nothing here for the second clomun currently")
    }

    // 3
//    if let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: cellIdentifier), owner: nil) as? NSTableCellView {
//        print("text", text)
//      cell.textField?.stringValue = text
//      // cell.imageView?.image = image ?? nil
//      return cell
//    }
    return nil
    }
    
    func tableViewSelectionDidChange(_ notification: Notification) {
      updateStatus()
    }



}

