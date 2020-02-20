//
//  detailedView.swift
//  Scrapbook
//
//  Created by Donghan Hu on 2/13/20.
//  Copyright © 2020 Donghan Hu. All rights reserved.
//

import Cocoa

struct screenshotInDetailedView {
    static var path: String!
    static var text = ""
}


class detailedView: NSViewController {
    @IBOutlet weak var imageDisplayView: NSImageView!
    @IBOutlet weak var inputMessageDisplay: NSTextField!
    
    @IBOutlet weak var checkBoxOne: NSButton!
    @IBOutlet weak var checkBoxTwo: NSButton!
    @IBOutlet weak var checkBoxThree: NSButton!
    @IBOutlet weak var checkBoxFour: NSButton!
    @IBOutlet weak var checkBoxFive: NSButton!
    @IBOutlet weak var checkBoxSix: NSButton!
    @IBOutlet weak var checkBoxSeven: NSButton!
    @IBOutlet weak var checkBoxEight: NSButton!
    
    @IBOutlet weak var buttonOne: NSButton!
    @IBOutlet weak var buttonTwo: NSButton!
    @IBOutlet weak var buttonThree: NSButton!
    @IBOutlet weak var buttonFour: NSButton!
    @IBOutlet weak var buttonFive: NSButton!
    @IBOutlet weak var buttonSix: NSButton!
    @IBOutlet weak var buttonSeven: NSButton!
    @IBOutlet weak var buttonEight: NSButton!
    
    @IBOutlet weak var textInformationDisplayOne: NSTextField!
    @IBOutlet weak var textInformationDisplayTwo: NSTextField!
    @IBOutlet weak var textInformationDisplayThree: NSTextField!
    
    @IBOutlet weak var openButton: NSButton!
    
    
     var checkBoxStack = [NSButton]()
     var buttonStack = [NSButton]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkBoxAllHidden()
        buttonAllHidden()
        checkBoxAllUnselected()
        
        checkBoxStackGenerate()
        buttonStackGenerate()
        textInformationDisplayOne.stringValue = ""
        textInformationDisplayTwo.stringValue = ""
        textInformationDisplayThree.stringValue = ""
        
        openButton.title = "Open Selected Applications"
        self.title = "Detailed Window"
        // Do view setup here.
        
        let nsImage = NSImage(contentsOfFile: screenshotInDetailedView.path)
        imageDisplayView.image = nsImage
        inputMessageDisplay.stringValue = screenshotInDetailedView.text
        
        readJsonFile()
        
        for i in 0..<detailedViewControllerVariables.numberofRecordedApplication{
            let temp = checkBoxStack[i]
            temp.title = detailedViewControllerVariables.recordedApplicationNameStack[i]
            temp.isHidden = false
            temp.state = .on
        }
        for j in 0..<detailedViewControllerVariables.numberofRecordedApplication{
            let temp = buttonStack[j]
            temp.title = detailedViewControllerVariables.recordedApplicationNameStack[j]
            temp.isHidden = false
        }
        
        
    }


    // func all check boxes are unselected at first
    func checkBoxAllUnselected(){
        checkBoxOne.state = .off
        checkBoxTwo.state = .off
        checkBoxThree.state = .off
        checkBoxFour.state = .off
        checkBoxFive.state = .off
        checkBoxSix.state = .off
        checkBoxSeven.state = .off
        checkBoxEight.state = .off
    }
    
    // func all check box are hidden at first
    func checkBoxAllHidden(){
        checkBoxOne.isHidden = true
        checkBoxTwo.isHidden = true
        checkBoxThree.isHidden = true
        checkBoxFour.isHidden = true
        checkBoxFive.isHidden = true
        checkBoxSix.isHidden = true
        checkBoxSeven.isHidden = true
        checkBoxEight.isHidden = true
        
    }
    // func put check box names in the stack
    func checkBoxStackGenerate(){
        checkBoxStack.append(checkBoxOne)
        checkBoxStack.append(checkBoxTwo)
        checkBoxStack.append(checkBoxThree)
        checkBoxStack.append(checkBoxFour)
        checkBoxStack.append(checkBoxFive)
        checkBoxStack.append(checkBoxSix)
        checkBoxStack.append(checkBoxSeven)
        checkBoxStack.append(checkBoxEight)
    }
    // func all button are hidden at first
    func buttonAllHidden(){
        buttonOne.isHidden = true
        buttonTwo.isHidden = true
        buttonThree.isHidden = true
        buttonFour.isHidden = true
        buttonFive.isHidden = true
        buttonSix.isHidden = true
        buttonSeven.isHidden = true
        buttonEight.isHidden = true
        
    }
    
    // func put button names in the stack
    func buttonStackGenerate(){
        buttonStack.append(buttonOne)
        buttonStack.append(buttonTwo)
        buttonStack.append(buttonThree)
        buttonStack.append(buttonFour)
        buttonStack.append(buttonFive)
        buttonStack.append(buttonSix)
        buttonStack.append(buttonSeven)
        buttonStack.append(buttonEight)
        
    }
    
    func readJsonFile(){
        
        var applicationNameStack = [String]()
        let url =  URL(fileURLWithPath: variables.jsonFilePathString)
        let rawData : NSData = try! NSData(contentsOf: url)
        do{
            let jsonDataDictionary = try JSONSerialization.jsonObject(with: rawData as Data, options: JSONSerialization.ReadingOptions.mutableContainers)as? NSDictionary
            let dictionaryOfReturnedJsonData = jsonDataDictionary as! Dictionary<String, AnyObject>
            var jsonarray = dictionaryOfReturnedJsonData["BasicInformation"] as! [[String: Any]]
            let length = jsonarray.count
            //print(length)
            //the first is initial information, which should not be considered
            for i in 1..<length{
                let temp = jsonarray[i]["PhotoTime"] as! [String]
                if temp[1] == screenshotInDetailedView.path {
                    let applicationsDictionary = jsonarray[i]["Applications"] as! [String:[String]]
                    // print("applicationDictionary", applicationsDictionary)
                    let applicationsNumber = applicationsDictionary.count
                    // print("applicaions count", applicationsNumber)
                    detailedViewControllerVariables.numberofRecordedApplication = applicationsNumber
                    // print(applicationsDictionary.keys)
                    let keys: Array<String> = Array<String>(applicationsDictionary.keys)
                    applicationNameStack = keys
                    detailedViewControllerVariables.recordedApplicationNameStack = applicationNameStack
                    // print("name stack", applicationNameStack)
                    detailedViewControllerVariables.recordedApplicationInformation = applicationsDictionary
                    // print("detailedViewControllerVariables.recordedApplicationInformation", detailedViewControllerVariables.recordedApplicationInformation)
                    break
                    
                }
            }
            
        }catch{print(error)}
    }
    
    @IBAction func buttonActionOne(_ sender: Any) {
        let keyValue = detailedViewControllerVariables.recordedApplicationNameStack[0]
        textInformationDisplayOne.stringValue = keyValue
        if detailedViewControllerVariables.recordedApplicationInformation[keyValue] != nil{
            let temp = detailedViewControllerVariables.recordedApplicationInformation[keyValue]
            textInformationDisplayTwo.stringValue = temp![0]
            textInformationDisplayThree.stringValue = temp![1]
        }
        else {
            textInformationDisplayTwo.stringValue = "No recording"
            textInformationDisplayThree.stringValue = "No recording"
        }
    }
    
    @IBAction func buttonActionTwo(_ sender: Any) {
        let keyValue = detailedViewControllerVariables.recordedApplicationNameStack[1]
        textInformationDisplayOne.stringValue = keyValue
        if detailedViewControllerVariables.recordedApplicationInformation[keyValue] != nil{
            let temp = detailedViewControllerVariables.recordedApplicationInformation[keyValue]
            textInformationDisplayTwo.stringValue = temp![0]
            textInformationDisplayThree.stringValue = temp![1]
        }
        else {
            textInformationDisplayTwo.stringValue = "No recording"
            textInformationDisplayThree.stringValue = "No recording"
        }
    }
    
    @IBAction func buttonActionThree(_ sender: Any) {
        let keyValue = detailedViewControllerVariables.recordedApplicationNameStack[2]
        textInformationDisplayOne.stringValue = keyValue
        if detailedViewControllerVariables.recordedApplicationInformation[keyValue] != nil{
            let temp = detailedViewControllerVariables.recordedApplicationInformation[keyValue]
            textInformationDisplayTwo.stringValue = temp![0]
            textInformationDisplayThree.stringValue = temp![1]
        }
        else {
            textInformationDisplayTwo.stringValue = "No recording"
            textInformationDisplayThree.stringValue = "No recording"
        }
    }
    @IBAction func buttonActionFour(_ sender: Any) {
        let keyValue = detailedViewControllerVariables.recordedApplicationNameStack[3]
        textInformationDisplayOne.stringValue = keyValue
        if detailedViewControllerVariables.recordedApplicationInformation[keyValue] != nil{
            let temp = detailedViewControllerVariables.recordedApplicationInformation[keyValue]
            textInformationDisplayTwo.stringValue = temp![0]
            textInformationDisplayThree.stringValue = temp![1]
        }
        else {
            textInformationDisplayTwo.stringValue = "No recording"
            textInformationDisplayThree.stringValue = "No recording"
        }
    }
    @IBAction func buttonActionFive(_ sender: Any) {
        let keyValue = detailedViewControllerVariables.recordedApplicationNameStack[4]
        textInformationDisplayOne.stringValue = keyValue
        if detailedViewControllerVariables.recordedApplicationInformation[keyValue] != nil{
            let temp = detailedViewControllerVariables.recordedApplicationInformation[keyValue]
            textInformationDisplayTwo.stringValue = temp![0]
            textInformationDisplayThree.stringValue = temp![1]
        }
        else {
            textInformationDisplayTwo.stringValue = "No recording"
            textInformationDisplayThree.stringValue = "No recording"
        }
    }
    @IBAction func buttonActionSix(_ sender: Any) {
        let keyValue = detailedViewControllerVariables.recordedApplicationNameStack[5]
        textInformationDisplayOne.stringValue = keyValue
        if detailedViewControllerVariables.recordedApplicationInformation[keyValue] != nil{
            let temp = detailedViewControllerVariables.recordedApplicationInformation[keyValue]
            textInformationDisplayTwo.stringValue = temp![0]
            textInformationDisplayThree.stringValue = temp![1]
        }
        else {
            textInformationDisplayTwo.stringValue = "No recording"
            textInformationDisplayThree.stringValue = "No recording"
        }
    }
    @IBAction func buttonActionSeven(_ sender: Any) {
        let keyValue = detailedViewControllerVariables.recordedApplicationNameStack[6]
        textInformationDisplayOne.stringValue = keyValue
        if detailedViewControllerVariables.recordedApplicationInformation[keyValue] != nil{
            let temp = detailedViewControllerVariables.recordedApplicationInformation[keyValue]
            textInformationDisplayTwo.stringValue = temp![0]
            textInformationDisplayThree.stringValue = temp![1]
        }
        else {
            textInformationDisplayTwo.stringValue = "No recording"
            textInformationDisplayThree.stringValue = "No recording"
        }
    }
    
    @IBAction func buttonActionEight(_ sender: Any) {
        let keyValue = detailedViewControllerVariables.recordedApplicationNameStack[7]
        textInformationDisplayOne.stringValue = keyValue
        if detailedViewControllerVariables.recordedApplicationInformation[keyValue] != nil{
            let temp = detailedViewControllerVariables.recordedApplicationInformation[keyValue]
            textInformationDisplayTwo.stringValue = temp![0]
            textInformationDisplayThree.stringValue = temp![1]
        }
        else {
            textInformationDisplayTwo.stringValue = "No recording"
            textInformationDisplayThree.stringValue = "No recording"
        }
    }
    
    // func open applications' button
    
    @IBAction func openApplicationsButton(_ sender: Any) {
        for index in 0..<8{
            if checkBoxStack[index].state == .on{
                let applicationsName = checkBoxStack[index].title
                let category = readCSVtoGetCategory(applicationName: applicationsName)
                let applescript = readCSVtoGetApplescript(applicationCategory: category, applicationName: applicationsName)
                print("final applescript", applescript)
                
                let truescript = runApplescript(applescript: applescript)
                AppleScript(script: truescript)
                // runApplescript(applescript: applescript)
            }
        }
        
    }
    
    func readCSVtoGetApplescript(applicationCategory : String, applicationName : String) -> String{
        let filepath = Bundle.main.path(forResource: "applescriptCategoryCode", ofType: "csv")!
        var contents = try! String(contentsOfFile: filepath, encoding: .utf8)
        contents = cleanRows(file: contents)
        let csvRows = csv(data: contents)
        for i in 0..<csvRows.count{
            // variables.softwareNameArray.append(csvRows[i][0])
            // print("csvRow", csvRows[i][0])
            if csvRows[i][0] == applicationCategory {
                var final = String()
                let pathORurl = detailedViewControllerVariables.recordedApplicationInformation[applicationName]![0]
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
    
    func readCSVtoGetCategory(applicationName : String) -> String{
        let filepath = Bundle.main.path(forResource: "applescriptNameCategory", ofType: "csv")!
        var contents = try! String(contentsOfFile: filepath, encoding: .utf8)
        contents = cleanRows(file: contents)
        let csvRows = csv(data: contents)
        for i in 0..<csvRows.count{
            // variables.softwareNameArray.append(csvRows[i][0])
            // print("csvRow", csvRows[i][0])
            if csvRows[i][0] == applicationName {
                return csvRows[i][1]
            }
        }
        return "Others"
        // 0, 1 and 2
        // 0 is the name of the application
        // 1 is the path url of the opened application
        // 2 is the name title of the opened application
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
    

    

    
}
