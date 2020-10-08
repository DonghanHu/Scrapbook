//
//  collectionViewController.swift
//  Scrapbook
//
//  Created by Donghan Hu on 2/11/20.
//  Copyright © 2020 Donghan Hu. All rights reserved.
//

import Cocoa



extension NSUserInterfaceItemIdentifier {
    static let collectionViewItem = NSUserInterfaceItemIdentifier("ColViewItem")
}


class collectionViewController: NSViewController, NSCollectionViewDelegate, NSCollectionViewDataSource {
    
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        
        // print screenshot's number
        //print("count for number", photonumber.photonumberCounting)
        // print the totoal number of screenshots the same as name list
        // print("count for photo name list length: ", diaryInformationCollection.photoNameList.count)
        let item = collectionView.makeItem(withIdentifier: .collectionViewItem, for: indexPath)
        print("diaryInformationCollection.photoNameList.count", diaryInformationCollection.photoNameList.count)
        if (photonumber.photonumberCounting == diaryInformationCollection.photoNameList.count - 1){
            photonumber.photonumberCounting = 0
        }
        else {
            photonumber.photonumberCounting = photonumber.photonumberCounting + 1
        }
        
        return item
    }
    

    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        let temp = diaryInformationCollection.photoNameFirstInformation.count
        return diaryInformationCollection.photoNameFirstInformation.count
//        let temp = diaryInformationCollection.photoNameSecondInformation.count
//        return diaryInformationCollection.photoNameSecondInformation.count
        
    }

    
    
    @IBOutlet weak var colView: NSCollectionView!
    @IBOutlet weak var refreshButton: NSButton!
    

    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do view setup here.
        
        getAllAvailableScrapbookList()
        divideIntoTwoArray(stringArray: diaryInformationCollection.photoNameList)
        photoNameListGenerate()
        
        
        let windowHeight = self.view.frame.size.height
        let windowWidth = self.view.frame.size.width
        
        
        if popoverWindow.popover.isShown {
            popoverWindow.popover.close()
        }
        
        
        // print("window level", NSWindow.Level(rawValue: Int(CGWindowLevelForKey(.mainMenuWindow))))
        
        let item = NSNib(nibNamed: "ColViewItem", bundle: nil)
        
        colView.register(item, forItemWithIdentifier: .collectionViewItem)
    
        // colView.layer?.borderWidth = 13.0
        // colView.layer?.borderColor = NSColor.red as! CGColor
        
        colView.delegate = self
        colView.dataSource = self
        self.title = "Collection View"
        refreshButton.title = "Refresh"
//        let clickGesture = NSClickGestureRecognizer(target: self, action: #selector(self.collectionViewSingleClick(_:)))
//        colView.addGestureRecognizer(clickGesture)
    
        
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
                // print("jsonarray", jsonarray)
                let length = jsonarray.count
                
                
                // print the number of message
                //print("message count:", photonumber.inputRelatedMessage.count)
                
                // if (photonumber.inputRelatedMessage.count == length || length == 1){
                if (length == 1){
                    print("nothing happenn in collection view window")
                    diaryInformationCollection.photoNameList = [[""]]
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
//                        photonumber.inputRelatedMessage.append(inputRelatedText[0])
                    }
                    photonumber.inputRelatedMessage = inputMessageList
                    
                    // print the memo of this page of scrapbook
                    // print("message", photonumber.inputRelatedMessage)
                    
                    photonumber.inputRelatedTitle   = inputMessageTitleList
                    
                    //print the title of this page of scrapbook
                    // print("title", photonumber.inputRelatedTitle)
                    
                }

            // end of do judgement
            }
        } catch {
            print("preview Error: \(error)")
        }
        
        // print the memo body as text information
        // print("text information is:", photonumber.inputRelatedMessage)

    }
    
    func divideIntoTwoArray(stringArray: [[String]]){
        var arrayOfFirstInformation = [String]()
        var arrayOfSecondInformation = [String]()
        // print("stringArray", stringArray)
        let length = stringArray.count
        if stringArray != [[""]] {
            for i in 0..<length{
                // print("[i][0]", stringArray[i][0])
                // print("[i][1]", stringArray[i][1])
                arrayOfFirstInformation.append(stringArray[i][0])
                arrayOfSecondInformation.append(stringArray[i][1])
            }
        }
//        if length > 1{
//            for i in 0..<length{
//                // print("[i][0]", stringArray[i][0])
//                // print("[i][1]", stringArray[i][1])
//                arrayOfFirstInformation.append(stringArray[i][0])
//                arrayOfSecondInformation.append(stringArray[i][1])
//            }
//        }

        diaryInformationCollection.photoNameFirstInformation = arrayOfFirstInformation
        diaryInformationCollection.photoNameSecondInformation = arrayOfSecondInformation
    }
    func photoNameListGenerate(){
        
        
        // print the number of photo information
        // print("second information count",diaryInformationCollection.photoNameSecondInformation.count)
        
        for i in 0..<diaryInformationCollection.photoNameSecondInformation.count{
            // print("i", i)
            // print("second information", diaryInformationCollection.photoNameSecondInformation[i])
            if photonumber.photoPathList.contains(diaryInformationCollection.photoNameSecondInformation[i]){
                
            }
            else {
                photonumber.photoPathList.append(diaryInformationCollection.photoNameSecondInformation[i])
            }
            
        }
        // print("photolistgenerate", photonumber.photoPathList)
    }
    
    @objc func collectionViewSingleClick(_ sender:AnyObject){
        print("clicked on this collection view window")
        getAllAvailableScrapbookList()
        divideIntoTwoArray(stringArray: diaryInformationCollection.photoNameList)
        photoNameListGenerate()
    }
    
    // photoNameList edit
    func photoNameListEdit(){
        let temp = photonumber.photoPathList.count - 1
        if temp < 1 {
            photonumber.photoPathList.removeAll()
        }
        
        else {
            for i in 0..<temp{
                if !diaryInformationCollection.photoNameSecondInformation.contains(photonumber.photoPathList[i]){
                    photonumber.photoPathList.remove(at: i)
                }
            }
        }

    }
    
    @IBAction func refreshAction(_ sender: Any) {
        print("refreshed")
        getAllAvailableScrapbookList()
        photoNameListEdit()
        self.loadView()
        // ColViewItem.load()
    }
    
    func alternativeRefreshAction() {
        print("refresh in detialed window")
        getAllAvailableScrapbookList()
        photoNameListEdit()
        self.loadView()
    }
    
    // end of the class
}
