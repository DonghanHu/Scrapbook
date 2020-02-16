//
//  overviewController.swift
//  Scrapbook
//
//  Created by Donghan Hu on 2/11/20.
//  Copyright © 2020 Donghan Hu. All rights reserved.
//

import Cocoa

extension ViewController: NSTableViewDataSource {
  
  func numberOfRows(in tableView: NSTableView) -> Int {
    print("row", diaryInformationCollection.photoNameList.count)
    return diaryInformationCollection.photoNameFirstInformation.count
  }
}


extension ViewController: NSTableViewDelegate {

  fileprivate enum CellIdentifiers {
    static let FirstCell = "columnOne"
    static let SecondCell = "columnTwo"
  }

  func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {

    var text: String = ""
    var cellIdentifier: String = ""

    if tableColumn == tableView.tableColumns[0] {
      text = "3"
      cellIdentifier = CellIdentifiers.FirstCell
    } else if tableColumn == tableView.tableColumns[1] {
      text = "4"
      cellIdentifier = CellIdentifiers.SecondCell
    }

    if let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: cellIdentifier), owner: nil) as? NSTableCellView {
      cell.textField?.stringValue = text
      return cell
    }
    return nil
  }

}

struct diary {
    dynamic var dia: Book = Book(firstInformation: "3", secondInformation: "4")
}

class overviewController: NSViewController {
    
    @IBOutlet weak var tableView: NSTableView!
    
    
    @objc dynamic var book: [Book] = [Book(firstInformation: diaryInformationCollection.photoNameFirstInformation[0], secondInformation: diaryInformationCollection.photoNameSecondInformation[0])]

    
    

    override func loadView() {
        super.loadView()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Collection View"
        // Do view setup here.        
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        self.view.window?.title = "Overview Window"


    }

    
    func getAllAvailableScrapbookList(){
        let url =  URL(fileURLWithPath: variables.jsonFilePathString)
        var photoNameList = [[String]]()
        do {
            let rawData : NSData = try! NSData(contentsOf: url)
            do{
                let jsonDataDictionary = try JSONSerialization.jsonObject(with : rawData as Data, options: JSONSerialization.ReadingOptions.mutableContainers)as? NSDictionary
                let dictionaryOfReturnedJsonData = jsonDataDictionary as! Dictionary<String, AnyObject>
                let jsonarray = dictionaryOfReturnedJsonData["BasicInformation"] as! [[String : Any]]
                // print("jsonarray", jsonarray)
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
        // print("photo name list is: ", photoNameList)
        photoNameList.removeFirst(1)
        diaryInformationCollection.photoNameList = photoNameList
    }
    
    func divideIntoTwoArray(stringArray: [[String]]){
        var arrayOfFirstInformation = [String]()
        var arrayOfSecondInformation = [String]()
        let length = stringArray.count
        for i in 0..<length{
            // print("[i][0]", stringArray[i][0])
            // print("[i][1]", stringArray[i][1])
            arrayOfFirstInformation.append(stringArray[i][0])
            arrayOfSecondInformation.append(stringArray[i][1])
        }
        diaryInformationCollection.photoNameFirstInformation = arrayOfFirstInformation
        diaryInformationCollection.photoNameSecondInformation = arrayOfSecondInformation
    }
    
}
