//
//  OverviewWindow.swift
//  Scrapbook
//
//  Created by Donghan Hu on 2/10/20.
//  Copyright © 2020 Donghan Hu. All rights reserved.
//

import Cocoa
import SwiftUI
import Foundation

extension ViewController: NSTableViewDelegate {

    fileprivate enum CellIdentifiers {
      static let FirstCell  = "ColumnOneID"
      static let SecondCell = "ColumnTwoID"
    }
}

struct diaryInformationCollection {
    static var photoNameList = [[""]]
    static var photoNameFirstInformation = [""]
    static var photoNameSecondInformation = [""]
}

class Diary: NSObject {
    @objc dynamic var firstInformation: String
    @objc dynamic var secondInformation: String
    
    init(firstInformation: String, secondInformation: String){
        self.firstInformation = firstInformation
        self.secondInformation = secondInformation
    }
}

class OverviewWindow: NSViewController {

    @IBOutlet weak var goButtonName: NSButton!
    @IBOutlet weak var quitButtonName: NSButton!
    @IBOutlet weak var tableViewOutlet: NSTableView!
    
    
    
    override func viewDidLoad() {
//        var pageCollection = [NSObject]()

//        let photoNameListLength = diaryInformationCollection.photoNameList.count
//        for i in 0..<photoNameListLength{
//            print("[i][0]", diaryInformationCollection.photoNameList[i][0])
//            dynamic let page: [Diary] = [Diary(firstInformation: diaryInformationCollection.photoNameList[i][0], secondInformation: diaryInformationCollection.photoNameList[i][0])]
//            pageCollection.append(page as NSObject)
//        }

        super.viewDidLoad()
        // Do view setup here.
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        self.view.window?.title = "Overview Window"
        getAllAvailableScrapbookList()
        divideIntoTwoArray(stringArray: diaryInformationCollection.photoNameList)
        print("fisrt list", diaryInformationCollection.photoNameFirstInformation)
        print("second list", diaryInformationCollection.photoNameSecondInformation)

    }
    
    
    
    
    
    
    // func get all avaliable scrapbook
    func getAllAvailableScrapbookList(){
        let url =  URL(fileURLWithPath: variables.jsonFilePathString)
        // var fileSize : UInt64
        // var returnDictionary = [String : Any]()
        var photoNameList = [[String]]()
        do {
            // let attr = try FileManager.default.attributesOfItem(atPath: variables.jsonFilePathString)

            let rawData : NSData = try! NSData(contentsOf: url)
            do{
                let jsonDataDictionary = try JSONSerialization.jsonObject(with : rawData as Data, options: JSONSerialization.ReadingOptions.mutableContainers)as? NSDictionary
                let dictionaryOfReturnedJsonData = jsonDataDictionary as! Dictionary<String, AnyObject>
                let jsonarray = dictionaryOfReturnedJsonData["BasicInformation"] as! [[String : Any]]
                print("jsonarray", jsonarray)
                let length = jsonarray.count
                for i in 1..<length{
                    let photoname = jsonarray[i]["PhotoTime"] as! [String]
                        photoNameList.append(photoname)

                // end of for loop
                }
            // end of do judgement
            }
        } catch {
            print("preview Error: \(error)")
        }
        print("photo name list is: ", photoNameList)
        diaryInformationCollection.photoNameList = photoNameList
    }
    
    func divideIntoTwoArray(stringArray: [[String]]){
        var arrayOfFirstInformation = [String]()
        var arrayOfSecondInformation = [String]()
        let length = stringArray.count
        for i in 0..<length{
            print("[i][0]", stringArray[i][0])
            print("[i][1]", stringArray[i][1])
            arrayOfFirstInformation.append(stringArray[i][0])
            arrayOfSecondInformation.append(stringArray[i][1])
        }
        diaryInformationCollection.photoNameFirstInformation = arrayOfFirstInformation
        diaryInformationCollection.photoNameSecondInformation = arrayOfSecondInformation
    }
    
    @IBAction func quitButtonAction(_ sender: Any) {
        self.view.window?.close()
    }
    

    
    
    

    // end of the class
}



