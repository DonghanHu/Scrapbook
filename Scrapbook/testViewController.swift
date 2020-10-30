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


// previous one
// testViewController: NSViewController , NSCollectionViewDelegate, NSCollectionViewDataSource {
class testViewController: NSViewController , NSCollectionViewDelegate, NSCollectionViewDataSource, NSWindowDelegate {
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
    
    @IBOutlet weak var oldSaveImageButton: NSButton!
    
    
    // this is for the table view
    @IBOutlet weak var tableView: NSTableView!
    @IBOutlet weak var statusLabel: NSTextField!
    @IBOutlet weak var saveButtonForTableView: NSButton!
    @IBOutlet weak var testButtonForCheckbox: NSButton!
    
    @IBOutlet weak var checkBoxValues: NSButton!
    
    var checkBoxCollection = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let width = self.view.frame.size.width
        let height = self.view.frame.size.height
//        screenshotDisplay.frame.size.width
//        screenshotDisplay.frame.size.height
        let x = screenshotDisplay.frame.origin.x
        let y = screenshotDisplay.frame.origin.y
        let tempvalues = screenshotDisplay.frame
        
        
        checkBoxCollection = variables.capturedApplicationNameList
        
        let item = NSNib(nibNamed: "testColViewItem", bundle: nil)
        testColView.register(item, forItemWithIdentifier: .testItem)
        testColView.delegate = self
        testColView.dataSource = self
        self.title = "Capture View"
        
        // hide old items
        oldSaveImageButton.isHidden = true
        testColView.isHidden = true
        
        
        
        // for table view
        tableView.delegate = self
        tableView.dataSource = self
        tableView.target = self
        tableView.action = #selector(tableViewSingleClick(_:))
        saveButtonForTableView.title = "Save screenshot"
        
        timeLabelDisplay.stringValue = variables.currentTimeInformation
        
        captionLabelOne.stringValue = "Application Name:"
        captionLabelTwo.isHidden = true
        captionLabelThree.isHidden = true
        
        let date = Date()
        let calendar = Calendar.current
        let stringDay = calendar.component(.day, from: date)
        let intDay = Int(stringDay)
        if intDay != variables.tempDay {
            // variables.countNumber = 1
            variables.dateCountNumber = 1
        } else{
            // variables.dateCountNumber = 1
        }
        
        if (variables.dateCountNumber == nil){
            variables.dateCountNumber = 1
        }
        
        
        let stringCountNumber = String(variables.dateCountNumber)
        
        let defaultTitle = dateFormate() + " (" + stringCountNumber + ")"
        
        
        // old verison: Scrap #1: Oct 10th, 2020
//        variables.defaultTitle = "Scrap #" + stringCountNumber + ": " + dateFromatGenerate()
//        scrapbookTitle.placeholderString = "Scrap #" + stringCountNumber + ": " + dateFromatGenerate()
        // new version
        variables.defaultTitle = defaultTitle
        scrapbookTitle.placeholderString = defaultTitle
        
        //scrapbookTitle.stringValue = "Scrap #" + stringCountNumber + ": " + dateFromatGenerate()
        
        scrapbookBody.placeholderString = "Input your memo here..."
        
        displayLatestScreenshot()
        
        if (checkBoxCollection[0] == nil){
            let firstApplicationName = "No Application Name"
            labelFirstInformation.stringValue = firstApplicationName
            captionLabelTwo.isHidden = false
            captionLabelThree.isHidden = false
            captionLabelTwo.stringValue = "First Information:"
            captionLabelThree.stringValue = "Scond Information:"
        }

        if (checkBoxCollection[0] != nil){
            let firstApplicationName = checkBoxCollection[0]
            labelFirstInformation.stringValue = firstApplicationName
            print("first application name in caputer view", firstApplicationName)
            let tempDictionary = variables.metaDataDictionaryTestOne["Applications"] as! [String:[String]]
            let tempApplicationMetaData = tempDictionary[firstApplicationName]
            // print("tempApplicationMetaData![2]", tempApplicationMetaData![2])
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
        
        self.tableView.allowsMultipleSelection = true
        self.tableView.selectAll(nil)
        // self.tableView.allowsMultipleSelectionDuringEditing = true
        
        
        // Do view setup here.
    }
    
    override func viewDidAppear() {
        self.view.window?.delegate = self
        
    }
    
    func windowWillClose(_ notification: Notification) {
        print("hhhh")
        if autosaveSet.autosaveFlag == true{
            autosaveSet.autosaveFlag = false
        }
        else{
            autosaveFunctionWhenClose()
        }
        
        
        // dont know the reason why autosaveFunctionClose() has to be exactly below this function
        // cant add the line of code: self.close in autosaveFunctionclose()
        // this will cause the fact of keep sending notification
    }
    
    func interruptfunc(){
        print("interruptions")
    }
    
    public func autosaveFunctionWhenClose(){
        var applicationNameTotal = [""]
        // check checkboxInformationCaptureWindoe.checkboxNameStack or variables.recordedApplicationNameStack
        if checkboxInformationCaptureWindoe.clickstatus == 1 {
            // checkbox clicked, use checkboxInformationCaptureWindoe.checkboxNameStack
            applicationNameTotal = checkboxInformationCaptureWindoe.checkboxNameStack
        }
        else {
            applicationNameTotal = variables.recordedApplicationNameStack
        }
        
        
        let stackLen = applicationNameTotal.count
        var emptyCount = 0
        for k in 0..<stackLen{
            if applicationNameTotal[k] == "Empty"{
                emptyCount = emptyCount + 1
            }
        }
        if (emptyCount == stackLen){
            if (scrapbookTitle.stringValue == "") {
                scrapbookTitle.stringValue = variables.defaultTitle
                variables.defaultTitle = ""
            }
            else {
                print("this is the customized title", scrapbookTitle.stringValue)
            }
            variables.metaDataDictionaryTestOne["Title"] = [scrapbookTitle.stringValue]
            variables.metaDataDictionaryTestOne["Text"] = [scrapbookBody.stringValue]
            
            variables.metaDataDictionaryTestOne["PhotoTime"] = [variables.latestScreenShotTime, variables.latesScreenShotPathString, variables.currentTimeInformation]
            var tempDictionary = variables.metaDataDictionaryTestOne["Applications"] as! [String:[String]]
            let dictionary = [String:[String]]()
            let length = applicationNameTotal.count
            let keys: Array<String> = Array<String>(tempDictionary.keys)
            let keyLength = keys.count
            for i in 0..<keyLength{
                if applicationNameTotal.contains(keys[i]){
                    
                }
                else {
                    tempDictionary.removeValue(forKey: keys[i])
                }
            }
            variables.metaDataDictionaryTestOne["Applications"] = tempDictionary
            
            writeAndReadMetaDataInformaionIntoJsonFileTest (metaData: variables.metaDataDictionaryTestOne)
            variables.countNumber = variables.countNumber + 1
            variables.dateCountNumber = variables.dateCountNumber + 1
            checkboxInformationCaptureWindoe.clickstatus = 0
        }
        else {
            print("this is checkbox collection: ", applicationNameTotal)
            
            if (scrapbookTitle.stringValue == "") {
                scrapbookTitle.stringValue = variables.defaultTitle
                variables.defaultTitle = ""
            }
            else {
                print("this is the customized title", scrapbookTitle.stringValue)
            }
            variables.metaDataDictionaryTestOne["Title"] = [scrapbookTitle.stringValue]
            variables.metaDataDictionaryTestOne["Text"] = [scrapbookBody.stringValue]
            
            variables.metaDataDictionaryTestOne["PhotoTime"] = [variables.latestScreenShotTime, variables.latesScreenShotPathString, variables.currentTimeInformation]
            var tempDictionary = variables.metaDataDictionaryTestOne["Applications"] as! [String:[String]]
            let dictionary = [String:[String]]()
            let length = applicationNameTotal.count
            let keys: Array<String> = Array<String>(tempDictionary.keys)
            let keyLength = keys.count
            for i in 0..<keyLength{
                if applicationNameTotal.contains(keys[i]){
                    
                }
                else {
                    tempDictionary.removeValue(forKey: keys[i])
                }
            }
            variables.metaDataDictionaryTestOne["Applications"] = tempDictionary
            
            writeAndReadMetaDataInformaionIntoJsonFileTest (metaData: variables.metaDataDictionaryTestOne)
            variables.countNumber = variables.countNumber + 1
            variables.dateCountNumber = variables.dateCountNumber + 1
            checkboxInformationCaptureWindoe.clickstatus = 0
        }
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
    
    func dateFormate() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        
        let ordinalFormatter = NumberFormatter()
        ordinalFormatter.numberStyle = .ordinal
        let day = Calendar.current.component(.day, from: date)
        let dayOrdinal = ordinalFormatter.string(from: NSNumber(value: day))!
        
        // dateFormatter.dateFormat = "yyyy, MMM d"
        dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "MMM. d, yyyy", options: 0, locale: dateFormatter.locale)?.replacingOccurrences(of: "d", with: "'\(dayOrdinal)'")
        // dateFormatter.dateFormat = "EEEE, MMM d"
           //dateFormatter.dateFormat = "YYYY.MM.dd,HH:mm"
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
    
    func dateFromatGenerate() -> String{
        let date = Date()
        let dateFormatter = DateFormatter()
        
        let ordinalFormatter = NumberFormatter()
        ordinalFormatter.numberStyle = .ordinal
        let day = Calendar.current.component(.day, from: date)
        let dayOrdinal = ordinalFormatter.string(from: NSNumber(value: day))!
        
        // dateFormatter.dateFormat = "yyyy, MMM d"
        dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "MMM d, yyyy", options: 0, locale: dateFormatter.locale)?.replacingOccurrences(of: "d", with: "'\(dayOrdinal)'")
        // dateFormatter.dateFormat = "EEEE, MMM d"
           //dateFormatter.dateFormat = "YYYY.MM.dd,HH:mm"
        let dateString = dateFormatter.string(from: date)
        return dateString
       }
    
    @IBAction func saveButtonAction(_ sender: Any) {
        
        if (checkBoxCollection.count == 0){
            let result = dialogCheck(question: "No application has been selected to save.", text: "")
            if (result == true){
                print("go ahead")
                dialogOK(question: "Information has been saved successfully without any metadata.", text: "Click OK to continue.")
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
                variables.countNumber = variables.countNumber + 1
                variables.dateCountNumber = variables.dateCountNumber + 1
                checkboxInformationCaptureWindoe.clickstatus = 0
                self.view.window?.close()
            }
            else {
                print("oh")
            }
        }
        else {
            dialogOK(question: "Information has been saved successfully.", text: "Click OK to continue.")
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
            variables.countNumber = variables.countNumber + 1
            variables.dateCountNumber = variables.dateCountNumber + 1
            checkboxInformationCaptureWindoe.clickstatus = 0
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
        checkboxInformationCaptureWindoe.clickstatus = 0
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

    public func dialogCheck(question: String, text: String) -> Bool {
        let alert = NSAlert()
        alert.messageText = question
        alert.informativeText = text
        alert.alertStyle = .warning
        alert.addButton(withTitle: "Go ahead.")
        alert.addButton(withTitle: "Oh.")
        return alert.runModal() == .alertFirstButtonReturn
    }
    
    func dialogCollectionView(question: String, text: String) -> Bool{
        let alert = NSAlert()
        alert.messageText = question
        alert.informativeText = text
        alert.alertStyle = .warning
        alert.addButton(withTitle: "That's all")
        alert.addButton(withTitle: "collectionview")
        return alert.runModal() == .alertFirstButtonReturn
    }
    
    // interaction with table view for multiple selections
    func updateStatus() {
      
        let text: String

        // 1
        let itemsSelected = tableView.selectedRowIndexes.count

        // 2
        if(itemsSelected == 0) {
        text = "\(variables.recordedApplicationNameStack.count) items"
        }
        else {
        text = "\(itemsSelected) of \(variables.recordedApplicationNameStack.count) selected"
        }
        // 3
        statusLabel.stringValue = text
    }
    
    @IBAction func testForCheckbox(_ sender: Any) {
        
        // tableView.tableColumns[0].dataCell(forRow: <#T##Int#>)
        // tableView.tableColumns[0].datacell
        
    }
    func updateCheckboxStatus() {
        //tableView.tableColumns[0].
        // tableView.validateUserInterfaceItem(rawvalue = singlecheckbox)
        
    }
    // interation with table view to display detailed information
    
    @objc func tableViewSingleClick(_ sender:AnyObject){
        captionLabelOne.isHidden = false
        if (tableView.selectedRowIndexes.count == 1){
            // print("selected row == 1", tableView.selectedRowIndexes)
            // print("next", tableView.selectedRow)
            let applicationName = variables.recordedApplicationNameStack[tableView.selectedRow]
            labelFirstInformation.stringValue = applicationName
            // print("first application name in caputer view", applicationName)
            let tempDictionary = variables.metaDataDictionaryTestOne["Applications"] as! [String:[String]]
            let tempApplicationMetaData = tempDictionary[applicationName]
            // print("tempApplicationMetaData![2]", tempApplicationMetaData![2])
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
            
            
            // print("tempApplicationMetaData![0]", tempApplicationMetaData![0])
            if tempApplicationMetaData![0] != "" {
                labelSecondInformation.stringValue = (tempApplicationMetaData?[0])!
            }
            else {
                labelSecondInformation.stringValue = "Nothing here"
            }
            
            // print("tempApplicationMetaData![1]", tempApplicationMetaData![1])
            if tempApplicationMetaData![1] != "" {
                labelThirdInformation.stringValue = (tempApplicationMetaData?[1])!
            }
            else {
                labelThirdInformation.stringValue = "Nothing here"
            }
        }
    }


    
    
    @IBAction func buttonForTableView(_ sender: Any) {
        
        var applicationNameTotal = [""]
        
        // check checkboxInformationCaptureWindoe.checkboxNameStack or variables.recordedApplicationNameStack
        if checkboxInformationCaptureWindoe.clickstatus == 1 {
            // checkbox clicked, use checkboxInformationCaptureWindoe.checkboxNameStack
            applicationNameTotal = checkboxInformationCaptureWindoe.checkboxNameStack
        }
        else {
            applicationNameTotal = variables.recordedApplicationNameStack
        }
        //
        let stackLen = applicationNameTotal.count
        var emptyCount = 0
        for k in 0..<stackLen{
            if applicationNameTotal[k] == "Empty"{
                emptyCount = emptyCount + 1
            }
        }
        if (emptyCount == stackLen){
        // if (applicationNameTotal.count == 0){
            let result = dialogCheck(question: "No application has been selected to save.", text: "")
            if (result == true){
                print("go ahead")
                dialogOK(question: "Information has been saved successfully without any metadata.", text: "Click OK to continue.")
                print("this is checkbox collection: ", applicationNameTotal)
                
                if (scrapbookTitle.stringValue == "") {
                    scrapbookTitle.stringValue = variables.defaultTitle
                    variables.defaultTitle = ""
                }
                else {
                    print("this is the customized title", scrapbookTitle.stringValue)
                }
                
                
                variables.metaDataDictionaryTestOne["Title"] = [scrapbookTitle.stringValue]
                variables.metaDataDictionaryTestOne["Text"] = [scrapbookBody.stringValue]
                
                variables.metaDataDictionaryTestOne["PhotoTime"] = [variables.latestScreenShotTime, variables.latesScreenShotPathString, variables.currentTimeInformation]
                var tempDictionary = variables.metaDataDictionaryTestOne["Applications"] as! [String:[String]]
                let dictionary = [String:[String]]()
                let length = applicationNameTotal.count
                let keys: Array<String> = Array<String>(tempDictionary.keys)
                let keyLength = keys.count
                for i in 0..<keyLength{
                    if applicationNameTotal.contains(keys[i]){
                        
                    }
                    else {
                        tempDictionary.removeValue(forKey: keys[i])
                    }
                }
                variables.metaDataDictionaryTestOne["Applications"] = tempDictionary
                
                writeAndReadMetaDataInformaionIntoJsonFileTest (metaData: variables.metaDataDictionaryTestOne)
                variables.countNumber = variables.countNumber + 1
                variables.dateCountNumber = variables.dateCountNumber + 1
                checkboxInformationCaptureWindoe.clickstatus = 0
                autosaveSet.autosaveFlag = true
                self.view.window?.close()
            }
            else {
                print("oh")
            }
        }
        else {
            dialogOK(question: "Information has been saved successfully.", text: "Click OK to continue.")
            print("this is checkbox collection: ", applicationNameTotal)
            
            if (scrapbookTitle.stringValue == "") {
                scrapbookTitle.stringValue = variables.defaultTitle
                variables.defaultTitle = ""
            }
            else {
                print("this is the customized title", scrapbookTitle.stringValue)
            }
            
            
            variables.metaDataDictionaryTestOne["Title"] = [scrapbookTitle.stringValue]
            variables.metaDataDictionaryTestOne["Text"] = [scrapbookBody.stringValue]
            
            variables.metaDataDictionaryTestOne["PhotoTime"] = [variables.latestScreenShotTime, variables.latesScreenShotPathString, variables.currentTimeInformation]
            var tempDictionary = variables.metaDataDictionaryTestOne["Applications"] as! [String:[String]]
            let dictionary = [String:[String]]()
            let length = applicationNameTotal.count
            let keys: Array<String> = Array<String>(tempDictionary.keys)
            let keyLength = keys.count
            for i in 0..<keyLength{
                if applicationNameTotal.contains(keys[i]){
                    
                }
                else {
                    tempDictionary.removeValue(forKey: keys[i])
                }
            }
            variables.metaDataDictionaryTestOne["Applications"] = tempDictionary
            
            writeAndReadMetaDataInformaionIntoJsonFileTest (metaData: variables.metaDataDictionaryTestOne)
            variables.countNumber = variables.countNumber + 1
            variables.dateCountNumber = variables.dateCountNumber + 1
            checkboxInformationCaptureWindoe.clickstatus = 0
            autosaveSet.autosaveFlag = true
            self.view.window?.close()
        }
    
       
        // for checkbox selections

//        let temp = tableView.selectedRowIndexes
//        let name = ""
//        for (name, index) in tableView.selectedRowIndexes.enumerated() {
//            print(index)
//        }
//        if (tableView.selectedRowIndexes.count == 0){
//            let result = dialogCheck(question: "No application has been selected to save.", text: "")
//            if (result == true){
//                print("go ahead")
//                dialogOK(question: "Information has been saved successfully without any metadata.", text: "Click OK to continue.")
//                print("this is checkbox collection: ", checkBoxCollection)
//
//                if (scrapbookTitle.stringValue == "") {
//                    scrapbookTitle.stringValue = variables.defaultTitle
//                    variables.defaultTitle = ""
//                }
//                else {
//                    print("this is the customized title", scrapbookTitle.stringValue)
//                }
//
//
//                variables.metaDataDictionaryTestOne["Title"] = [scrapbookTitle.stringValue]
//                variables.metaDataDictionaryTestOne["Text"] = [scrapbookBody.stringValue]
//
//                variables.metaDataDictionaryTestOne["PhotoTime"] = [variables.latestScreenShotTime, variables.latesScreenShotPathString, variables.currentTimeInformation]
//                var tempDictionary = variables.metaDataDictionaryTestOne["Applications"] as! [String:[String]]
//                let dictionary = [String:[String]]()
//                let length = tableView.selectedRowIndexes.count
//                var tempIndexStack = [Int]()
//                var tempValueStack = [String]()
//                for (name, index) in tableView.selectedRowIndexes.enumerated() {
//                    tempIndexStack.append(index)
//                    tempValueStack.append(variables.recordedApplicationNameStack[index])
//                }
//                let keys: Array<String> = Array<String>(tempDictionary.keys)
//                let keyLength = keys.count
//                for i in 0..<keyLength{
//                    if tempValueStack.contains(keys[i]){
//
//                    }
//                    else {
//                        tempDictionary.removeValue(forKey: keys[i])
//                    }
//                }
//                variables.metaDataDictionaryTestOne["Applications"] = tempDictionary
//
//                writeAndReadMetaDataInformaionIntoJsonFileTest (metaData: variables.metaDataDictionaryTestOne)
//                variables.countNumber = variables.countNumber + 1
//                variables.dateCountNumber = variables.dateCountNumber + 1
//                checkboxInformationCaptureWindoe.clickstatus = 0
//                self.view.window?.close()
//            }
//            else {
//                print("oh, if this appear, plz check, i dont know what happened here actually")
//            }
//        }
//        else {
//            dialogOK(question: "Information has been saved successfully.", text: "Click OK to continue.")
//            if (scrapbookTitle.stringValue == "") {
//                scrapbookTitle.stringValue = variables.defaultTitle
//                variables.defaultTitle = ""
//            }
//            else {
//                print("this is the customized title", scrapbookTitle.stringValue)
//            }
//
//            variables.metaDataDictionaryTestOne["Title"] = [scrapbookTitle.stringValue]
//            variables.metaDataDictionaryTestOne["Text"] = [scrapbookBody.stringValue]
//
//            variables.metaDataDictionaryTestOne["PhotoTime"] = [variables.latestScreenShotTime, variables.latesScreenShotPathString, variables.currentTimeInformation]
//            var tempDictionary = variables.metaDataDictionaryTestOne["Applications"] as! [String:[String]]
//            let dictionary = [String:[String]]()
//            let length = tableView.selectedRowIndexes.count
//            var tempIndexStack = [Int]()
//            var tempValueStack = [String]()
//            for (name, index) in tableView.selectedRowIndexes.enumerated() {
//                tempIndexStack.append(index)
//                tempValueStack.append(variables.recordedApplicationNameStack[index])
//            }
//
//            let keys: Array<String> = Array<String>(tempDictionary.keys)
//            let keyLength = keys.count
//
//            for i in 0..<keyLength{
//                if tempValueStack.contains(keys[i]){
//
//                }
//                else {
//                    tempDictionary.removeValue(forKey: keys[i])
//                }
//            }
//            variables.metaDataDictionaryTestOne["Applications"] = tempDictionary
//
//            writeAndReadMetaDataInformaionIntoJsonFileTest (metaData: variables.metaDataDictionaryTestOne)
//            variables.countNumber = variables.countNumber + 1
//            variables.dateCountNumber = variables.dateCountNumber + 1
//            checkboxInformationCaptureWindoe.clickstatus = 0
//            self.view.window?.close()
//        }
        
    }
    @objc func checkBoxInteraction(_ sender: NSButton){
        // print(sender.state)
        let temp = sender.title
        if !checkboxInformationCaptureWindoe.checkboxNameStack.contains("Empty"){
            checkboxInformationCaptureWindoe.checkboxNameStack = variables.recordedApplicationNameStack
        }
        let length = checkboxInformationCaptureWindoe.checkboxNameStack.count
        if (sender.state == .off){
            for i in 0..<length{
                if checkboxInformationCaptureWindoe.checkboxNameStack[i] == sender.title{
                    checkboxInformationCaptureWindoe.checkboxNameStack[i] = "Empty"
                    break
                }
            }
        }else {
                if !checkboxInformationCaptureWindoe.checkboxNameStack.contains(sender.title){
                    let len = variables.recordedApplicationNameStack.count
                    for j in 0..<len{
                        if variables.recordedApplicationNameStack[j] == sender.title{
                            checkboxInformationCaptureWindoe.checkboxNameStack[j] = sender.title
                        }
                    }
                    // checkboxInformationCaptureWindoe.checkboxNameStack.append(sender.title)
            }
        }
        print("current name stack", checkboxInformationCaptureWindoe.checkboxNameStack)
        checkboxInformationCaptureWindoe.clickstatus = 1
        
    }
    
        // end of the class
}

extension NSUserInterfaceItemIdentifier {
    static let check = NSUserInterfaceItemIdentifier(rawValue: "singlecheckbox")
}

extension testViewController: NSTableViewDataSource {
  
  func numberOfRows(in tableView: NSTableView) -> Int {
    // return the number of application names
    let temp = variables.recordedApplicationNameStack
    print(temp)
    // print(diaryInformationCollection.photoNameFirstInformation.count)
    return variables.recordedApplicationNameStack.count
  }

}

extension testViewController: NSTableViewDelegate {

  fileprivate enum CellIdentifiers {
    static let NameCell = "NameCellID"
    static let CheckboxCell = "CheckboxCellID"
  }

  func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {

    var image: NSImage?
    var text: String = ""
    var cellIdentifier: String = ""

    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .long
    dateFormatter.timeStyle = .long
    
    let item = variables.recordedApplicationNameStack[row]
    
//    guard let item = directoryItems?[row] else {
//      return nil
//    }

    // 2
    if tableColumn == tableView.tableColumns[1] {
      // image = item.icon
        text = item
        cellIdentifier = CellIdentifiers.NameCell
        if let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: cellIdentifier), owner: nil) as? NSTableCellView {
            cell.textField?.stringValue = text
          return cell
        }
    } else if tableColumn == tableView.tableColumns[0]{
        text = "123"
        cellIdentifier = CellIdentifiers.CheckboxCell
        // let newBut = NSButton(frame: NSRect(x: 0, y: 2, width: 10, height: 30))
        let checkBoxFrame = NSRect(x: 10, y: 8, width: 25, height: 25)
        let newCheckBut = NSButton.init(checkboxWithTitle: item, target: nil, action: #selector(testViewController.checkBoxInteraction(_:)))
        newCheckBut.frame = checkBoxFrame
               
        newCheckBut.state = .on
        
        return newCheckBut
        
//        if let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: cellIdentifier), owner: tableView) as? NSButton {
//            cell.title = "test"
//            return cell
//        }
    }
    
    else{
        print("nothing here for the second clomun currently")
        if let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: cellIdentifier), owner: nil) as? NSTableCellView {
            cell.textField?.stringValue = text
          return cell
        }
    }

    // 3

//    if let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: cellIdentifier) as? NSButton {
//        cell.textField?.stringValue = text
//        return cell
//    }
    
//    if let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: cellIdentifier), owner: nil) as? NSTableCellView {
//        cell.textField?.stringValue = text
//      return cell
//    }
    
    return nil
  }
    
//    func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any? {
//        <#code#>
//        let object = [String]()
//        if tableColumn?.identifier == NSUserInterfaceItemIdentifier(rawValue: "checkboxColumn" ){
//
//        }
//    }
    
    func tableViewSelectionDidChange(_ notification: Notification) {
        updateStatus()
        updateCheckboxStatus()
        // displayInformation()
    }
    


}
