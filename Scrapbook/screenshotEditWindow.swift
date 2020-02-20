//
//  screenshotEditWindow.swift
//  Scrapbook
//
//  Created by Donghan Hu on 1/6/20.
//  Copyright © 2020 Donghan Hu. All rights reserved.
//

import Cocoa
import Foundation

class screenshotEditWindow: NSViewController {
    @IBOutlet weak var imageCellDisplay: NSImageCell!
    
    
    @IBOutlet weak var textEditField: NSTextField!
    @IBOutlet weak var applicationName: NSTextField!
    @IBOutlet weak var applicationFirstFactor: NSTextField!
    @IBOutlet weak var applicationSecondFactor: NSTextField!
    
    // check box name list
    @IBOutlet weak var checkboxOne: NSButton!
    @IBOutlet weak var checkboxTwo: NSButton!
    @IBOutlet weak var checkboxThree: NSButton!
    @IBOutlet weak var checkboxFour: NSButton!
    @IBOutlet weak var checkboxFive: NSButton!
    @IBOutlet weak var checkboxSix: NSButton!
    @IBOutlet weak var checkboxSeven: NSButton!
    @IBOutlet weak var checkboxEight: NSButton!
    // button name list
    @IBOutlet weak var buttonOne: NSButton!
    @IBOutlet weak var buttonTwo: NSButton!
    @IBOutlet weak var buttonThree: NSButton!
    @IBOutlet weak var buttonFour: NSButton!
    @IBOutlet weak var buttonFive: NSButton!
    @IBOutlet weak var buttonSix: NSButton!
    @IBOutlet weak var buttonSeven: NSButton!
    @IBOutlet weak var buttonEight: NSButton!
    
    // text box for displaying information
    @IBOutlet weak var applicationNameTextbox: NSTextField!
    
    @IBOutlet weak var applicationFirstFactorTextbox: NSTextField!
    @IBOutlet weak var applicationSecondFactorTextBox: NSTextField!
    
    var checkboxStack = [NSButton]()
    var buttonStack = [NSButton]()
    
    
    override func viewWillAppear(){
        
        super.viewWillAppear()
        self.view.window?.title = "eidt window"
        applicationName.stringValue = "click button to display"
        applicationFirstFactorTextbox.stringValue = "click button to display"
        applicationSecondFactorTextBox.stringValue = "click button to display"
        checkboxStackGenerate()
        buttonStackGenerate()
        checkBoxAllHidden()
        buttonAllHidden()
        for i in 0..<variables.numberofRecordedApplication{
            let temp = checkboxStack[i]
            temp.title = variables.recordedApplicationNameStack[i]
            temp.isHidden = false
        }
        for j in 0..<variables.numberofRecordedApplication{
            let temp = buttonStack[j]
            temp.title = variables.recordedApplicationNameStack[j]
            temp.isHidden = false
        }
        
        
        displayLatestScreenshot()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do view setup here.
    }
    
    // func all check box titles are hidden
    func checkBoxTitleHidden(){
        
    }
    // func all check box are hidden at first
    func checkBoxAllHidden(){
        checkboxOne.isHidden = true
        checkboxTwo.isHidden = true
        checkboxThree.isHidden = true
        checkboxFour.isHidden = true
        checkboxFive.isHidden = true
        checkboxSix.isHidden = true
        checkboxSeven.isHidden = true
        checkboxEight.isHidden = true
        
    }
    // func put check box names in the stack
    func checkboxStackGenerate(){
        checkboxStack.append(checkboxOne)
        checkboxStack.append(checkboxTwo)
        checkboxStack.append(checkboxThree)
        checkboxStack.append(checkboxFour)
        checkboxStack.append(checkboxFive)
        checkboxStack.append(checkboxSix)
        checkboxStack.append(checkboxSeven)
        checkboxStack.append(checkboxEight)
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
    
    func displayLatestScreenshot() {
        imageCellDisplay.imageScaling = .scaleProportionallyUpOrDown
        print(variables.latesScreenShotPathString)
        
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: variables.latesScreenShotPathString){
            print("imgae existed")
        }
        else {
            print("image not existed")
        }
        

        let currentScreenshot = NSImage(contentsOfFile: variables.latesScreenShotPathString)
        imageCellDisplay.image = currentScreenshot
        
    }
    @IBAction func buttonOneAction(_ sender: Any) {
        let keyValue = variables.recordedApplicationNameStack[0]
        applicationName.stringValue = keyValue
        if variables.softwareNameArray.contains(keyValue){
            let temp = variables.metaDataDictionary[keyValue]
            applicationFirstFactor.stringValue = temp![0]
            applicationSecondFactor.stringValue = temp![1]
            
            //here is new method for alternating
            let tem = variables.metaDataDictionaryTestOne["Applications"] as! [String:[String]]
            // applicationFirstFactor.stringValue = temp![keyValue][0]
            // applicationFirstFactor.stringValue = temp![keyValue][1]
            // print("test new data structure value 0:", tem[keyValue]![0])
            // print("test new data structure value 1:", tem[keyValue]![1])
            //
        }
        else {
            applicationFirstFactorTextbox.stringValue = "No recording"
            applicationSecondFactorTextBox.stringValue = "No recording"
        }
        
        
    }
    @IBAction func buttonTwoAction(_ sender: Any) {
        let keyValue = variables.recordedApplicationNameStack[1]
        applicationName.stringValue = keyValue
        if variables.softwareNameArray.contains(keyValue){
           let temp = variables.metaDataDictionary[keyValue]
           applicationFirstFactor.stringValue = temp![0]
           applicationSecondFactor.stringValue = temp![1]
            
            //
            let tem = variables.metaDataDictionaryTestOne["Applications"] as! [String:[String]]
            // applicationFirstFactor.stringValue = temp![keyValue][0]
            // applicationFirstFactor.stringValue = temp![keyValue][1]
            // print("test new data structure value 0:", tem[keyValue]![0])
            // print("test new data structure value 1:", tem[keyValue]![1])
            //
            
        }
         else {
           applicationFirstFactorTextbox.stringValue = "No recording"
           applicationSecondFactorTextBox.stringValue = "No recording"
       }
    }
    @IBAction func buttonThreeAction(_ sender: Any) {
        let keyValue = variables.recordedApplicationNameStack[2]
        applicationName.stringValue = keyValue
        if variables.softwareNameArray.contains(keyValue){
            let temp = variables.metaDataDictionary[keyValue]
            applicationFirstFactor.stringValue = temp![0]
            applicationSecondFactor.stringValue = temp![1]
            
            //
            let tem = variables.metaDataDictionaryTestOne["Applications"] as! [String:[String]]
            // applicationFirstFactor.stringValue = temp![keyValue][0]
            // applicationFirstFactor.stringValue = temp![keyValue][1]
            // print("test new data structure value 0:", tem[keyValue]![0])
            // print("test new data structure value 1:", tem[keyValue]![1])
            //
            
         }
          else {
            applicationFirstFactorTextbox.stringValue = "No recording"
            applicationSecondFactorTextBox.stringValue = "No recording"
        }
    }
    @IBAction func buttonFourAction(_ sender: Any) {
        let keyValue = variables.recordedApplicationNameStack[3]
        applicationName.stringValue = keyValue
        if variables.softwareNameArray.contains(keyValue){
            let temp = variables.metaDataDictionary[keyValue]
            applicationFirstFactor.stringValue = temp![0]
            applicationSecondFactor.stringValue = temp![1]
            //
            let tem = variables.metaDataDictionaryTestOne["Applications"] as! [String:[String]]
            // applicationFirstFactor.stringValue = temp![keyValue][0]
            // applicationFirstFactor.stringValue = temp![keyValue][1]
            // print("test new data structure value 0:", tem[keyValue]![0])
            // print("test new data structure value 1:", tem[keyValue]![1])
            //
         }
          else {
            applicationFirstFactorTextbox.stringValue = "No recording"
            applicationSecondFactorTextBox.stringValue = "No recording"
        }
    }
    @IBAction func buttonFiveAction(_ sender: Any) {
        let keyValue = variables.recordedApplicationNameStack[4]
        applicationName.stringValue = keyValue
        if variables.softwareNameArray.contains(keyValue){
            let temp = variables.metaDataDictionary[keyValue]
            applicationFirstFactor.stringValue = temp![0]
            applicationSecondFactor.stringValue = temp![1]
            
            //
            let tem = variables.metaDataDictionaryTestOne["Applications"] as! [String:[String]]
            // applicationFirstFactor.stringValue = temp![keyValue][0]
            // applicationFirstFactor.stringValue = temp![keyValue][1]
            // print("test new data structure value 0:", tem[keyValue]![0])
            // print("test new data structure value 1:", tem[keyValue]![1])
            //
            
            
         }
          else {
            applicationFirstFactorTextbox.stringValue = "No recording"
            applicationSecondFactorTextBox.stringValue = "No recording"
        }

    }
    @IBAction func buttonSixAction(_ sender: Any) {
        let keyValue = variables.recordedApplicationNameStack[5]
        applicationName.stringValue = keyValue
        if variables.softwareNameArray.contains(keyValue){
            let temp = variables.metaDataDictionary[keyValue]
            applicationFirstFactor.stringValue = temp![0]
            applicationSecondFactor.stringValue = temp![1]
            
            
            //
            let tem = variables.metaDataDictionaryTestOne["Applications"] as! [String:[String]]
            // applicationFirstFactor.stringValue = temp![keyValue][0]
            // applicationFirstFactor.stringValue = temp![keyValue][1]
            // print("test new data structure value 0:", tem[keyValue]![0])
            // print("test new data structure value 1:", tem[keyValue]![1])
            //
            
         }
          else {
            applicationFirstFactorTextbox.stringValue = "No recording"
            applicationSecondFactorTextBox.stringValue = "No recording"
        }

    }
    @IBAction func buttonSevenAction(_ sender: Any) {
        let keyValue = variables.recordedApplicationNameStack[6]
        applicationName.stringValue = keyValue
        if variables.softwareNameArray.contains(keyValue){
            let temp = variables.metaDataDictionary[keyValue]
            applicationFirstFactor.stringValue = temp![0]
            applicationSecondFactor.stringValue = temp![1]
            
            //
            let tem = variables.metaDataDictionaryTestOne["Applications"] as! [String:[String]]
            // applicationFirstFactor.stringValue = temp![keyValue][0]
            // applicationFirstFactor.stringValue = temp![keyValue][1]
            // print("test new data structure value 0:", tem[keyValue]![0])
            // print("test new data structure value 1:", tem[keyValue]![1])
            //
            
            
         }
          else {
            applicationFirstFactorTextbox.stringValue = "No recording"
            applicationSecondFactorTextBox.stringValue = "No recording"
        }

    }
    @IBAction func buttonEightAction(_ sender: Any) {
        let keyValue = variables.recordedApplicationNameStack[7]
        applicationName.stringValue = keyValue
        if variables.softwareNameArray.contains(keyValue){
            let temp = variables.metaDataDictionary[keyValue]
            applicationFirstFactor.stringValue = temp![0]
            applicationSecondFactor.stringValue = temp![1]
            
            //
            let tem = variables.metaDataDictionaryTestOne["Applications"] as! [String:[String]]
            // applicationFirstFactor.stringValue = temp![keyValue][0]
            // applicationFirstFactor.stringValue = temp![keyValue][1]
            // print("test new data structure value 0:", tem[keyValue]![0])
            // print("test new data structure value 1:", tem[keyValue]![1])
            //
            
            
         }
          else {
            applicationFirstFactorTextbox.stringValue = "No recording"
            applicationSecondFactorTextBox.stringValue = "No recording"
        }
    }
    
    // functions for the checkbox actions
    @IBAction func checkboxOneAction(_ sender: Any) {
    }
    @IBAction func checkboxTwoAction(_ sender: Any) {
    }
    @IBAction func checkboxThreeAction(_ sender: Any) {
    }
    @IBAction func checkboxFourAction(_ sender: Any) {
    }
    @IBAction func checkBoxFiveAction(_ sender: Any) {
    }
    @IBAction func checkboxSixAction(_ sender: Any) {
    }
    @IBAction func checkboxSevenAction(_ sender: Any) {
    }
    @IBAction func checkboxEightAction(_ sender: Any) {
    }
    
    @IBAction func saveButtonAction(_ sender: Any) {
        var tempStringArray = [String]()
        tempStringArray.append(variables.latesScreenShotPathString)
        tempStringArray.append(variables.latestScreenShotTime)
        variables.metaDataDictionary["screenshotPath"] = tempStringArray
//        if let file = FileHandle(forWritingAtPath : jpath.absoluteString) {
//            file.write(jsonData)
//            file.closeFile()
//        }
        
        for index in 0..<8{
            if checkboxStack[index].state == .off{
                variables.metaDataDictionary.removeValue(forKey: buttonStack[index].title)
                
                //
                var temp = variables.metaDataDictionaryTestOne["Applications"] as! [String: [String]]
                let name = buttonStack[index].title
                temp.removeValue(forKey: buttonStack[index].title)
                temp.removeValue(forKey: name)
                print("temp", temp)
                variables.metaDataDictionaryTestOne["Applications"] = temp
                //
                
            }
        }
        variables.metaDataDictionary["Text"] = [textEditField.stringValue]
        variables.metaDataDictionary["PhotoTime"] = [variables.latestScreenShotTime, variables.latesScreenShotPathString]
        // self.view.window?.windowController?.close()
        print("final meta data dictionary", variables.metaDataDictionary)
        // code here
        // writeAndReadMetaDataIntoJsonFile(metaData: variables.metaDataDictionary)
        dialogOK(question: "Information has been saved successfully.", text: "Click OK to continue.")
        
        //
        variables.metaDataDictionaryTestOne["Text"] = [textEditField.stringValue]
        variables.metaDataDictionaryTestOne["PhotoTime"] = [variables.latestScreenShotTime, variables.latesScreenShotPathString]
        //
        
        // code here
        writeAndReadMetaDataInformaionIntoJsonFileTest (metaData: variables.metaDataDictionaryTestOne)
        print("final new data structre:", variables.metaDataDictionaryTestOne)
        
        self.view.window?.close()
    }
    
    
    func writeMetaDataIntoJsonFile (metaData : Dictionary<String, [String]>) {
        let jsonData = try! JSONSerialization.data(withJSONObject: metaData, options: JSONSerialization.WritingOptions.prettyPrinted)
        if FileManager.default.fileExists(atPath: variables.jsonFilePathString){
            var err:NSError?
            if let fileHandle = FileHandle(forWritingAtPath: variables.jsonFilePathString){
                fileHandle.write(jsonData)
                fileHandle.closeFile()
            }
            else {
                print("Can't open fileHandle \(String(describing: err))")
            }
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
    
    func writeAndReadMetaDataIntoJsonFile (metaData : Dictionary<String,[String]>){
        do {
                let jsonData = try! JSONSerialization.data(withJSONObject: metaData, options: JSONSerialization.WritingOptions.prettyPrinted)
                let jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)! as String
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
        // self.view.window?.windowController?.close()
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
    
    
    // end of the class
}
