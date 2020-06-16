//
//  AlternativeCaptureView.swift
//  Scrapbook
//
//  Created by Donghan Hu on 2/16/20.
//  Copyright © 2020 Donghan Hu. All rights reserved.
//

import Cocoa

extension NSUserInterfaceItemIdentifier {
    static let checkBoxViewItem = NSUserInterfaceItemIdentifier("checkBoxViewItem")
    // static let buttonViewItem = NSUserInterfaceItemIdentifier("altButtonView")
}

class AlternativeCaptureView: NSViewController , NSCollectionViewDelegate, NSCollectionViewDataSource{
    
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return variables.recordedApplicationNameStack.count
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        let item = collectionView.makeItem(withIdentifier: .checkBoxViewItem, for: indexPath)
//        
        if (alternativeUserInterfaceVariables.capturedApplicationCount == variables.recordedApplicationNameStack.count - 1){
            alternativeUserInterfaceVariables.capturedApplicationCount = 0
        }
        else {
            alternativeUserInterfaceVariables.capturedApplicationCount = alternativeUserInterfaceVariables.capturedApplicationCount + 1
        }
        
        return item
    }

    @IBOutlet weak var saveButton: NSButton!
    @IBOutlet weak var deleteButton: NSButton!
    
    @IBOutlet weak var textInformationFirst: NSTextField!
    @IBOutlet weak var textInformationSecond: NSTextField!
    @IBOutlet weak var textInformationThrid: NSTextField!
    
    @IBOutlet weak var textInputTitile: NSTextField!
    @IBOutlet weak var textInputBody: NSTextField!
    @IBOutlet weak var screenshotDisplay: NSImageView!
    
    @IBOutlet weak var collectionView: NSCollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let item = NSNib(nibNamed: "checkBoxViewItem", bundle: nil)
        collectionView.register(item, forItemWithIdentifier: .checkBoxViewItem)
        collectionView.delegate = self
        collectionView.dataSource = self
        self.title = "Capture View"
        
        textInputTitile.stringValue = "Scrap: " + dateFromatGenerate() + "(Default)"
        displayLatestScreenshot()
        
        
        //
        // print("variables", variables.metaDataDictionaryTestOne)
        // Do view setup here.
        
        
    }
    
    func dateFromatGenerate() -> String{
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY.MM.dd,HH:mm"
        let dateString = dateFormatter.string(from: date)
        return dateString
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
    
    
    @IBAction func saveButtonAction(_ sender: Any) {
        
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
    
    // end of the class
    
}


