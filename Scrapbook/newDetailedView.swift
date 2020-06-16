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
    
    @IBOutlet weak var openSelectedApplicationsButton: NSButton!
    @IBOutlet weak var openAllApplicationsButton: NSButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        let item = NSNib(nibNamed: "detailedColViewItem", bundle: nil)
        detailedColView.register(item, forItemWithIdentifier: .detailedItem)
        detailedColView.delegate = self
        detailedColView.dataSource = self
        
        openSelectedApplicationsButton.title = "Open Selected Applications"
        self.title = "Detailed Window"
        // Do view setup here.
        
        let nsImage = NSImage(contentsOfFile: screenshotInDetailedView.path)
        nsImage?.prefersColorMatch = false
        nsImage?.matchesOnMultipleResolution = true
        screenshotDisplay.image = nsImage
        scrapbookTitle.stringValue = screenshotInDetailedView.title
        scrapbookBody.stringValue = screenshotInDetailedView.text
        
        let timetemp = detailedWiondwVariables.detailedDictionary["PhotoTime"] as![String]
        
        currentTimeLabel.stringValue = timetemp[2]
        
        detailedInformationFirst.stringValue = "click application button to dispaly."
        detailedInformationSecond.stringValue = "click application button to display."
        detailedInformationThird.stringValue = "click application button to display."
        
    }
    
    @objc func collectionViewButton (_ sender: NSButton){
        print("button title", sender.title)
        detailedInformationFirst.stringValue = sender.title
        let detailedDictionary = detailedWiondwVariables.detailedDictionary["Applications"] as! [String:[String]]
        let tempApplicationName = sender.title
        let tempApplicationMetaData = detailedDictionary[tempApplicationName]
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
    }
    
    
    @IBAction func openApplicationsButton(_ sender: Any) {
        // print("detailedWindowdictionary", detailedWiondwVariables.detailedDictionary)
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
    
    
    @IBAction func openAllAppsAction(_ sender: Any) {
        let dictionary = detailedWiondwVariables.detailedDictionary["Applications"] as! [String:[String]]
        
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
    // end of the class
}
