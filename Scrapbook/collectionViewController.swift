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

struct notificationValues {
    static var notificationKey = "scrapbook.notificationKey"
}

struct cellCGSize {
    static var height : CGFloat!
    static var width : CGFloat!
}

let notificationKeyCollectionView = "scrapbook.notificationKey"

class collectionViewController: NSViewController, NSCollectionViewDelegate, NSCollectionViewDataSource, NSWindowDelegate, NSCollectionViewDelegateFlowLayout {
    
    
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
    
    func collectionView(_ collectionView: NSCollectionView, layout collectionViewLayout: NSCollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = view.frame.size.height
        let width = view.frame.size.width
        // in case you you want the cell to be 40% of your controllers view
        cellCGSize.width = width * 0.22
        cellCGSize.height = height * 0.22
        
        return CGSize(width: width * 0.22, height: height * 0.22)
        
    }

    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        let temp = diaryInformationCollection.photoNameFirstInformation.count
        collectionViewItemCount.countOfCollectionViewItem = temp
        return diaryInformationCollection.photoNameFirstInformation.count
//        let temp = diaryInformationCollection.photoNameSecondInformation.count
//        return diaryInformationCollection.photoNameSecondInformation.count
        
    }

    
    
    @IBOutlet weak var colView: NSCollectionView!
    @IBOutlet weak var refreshButton: NSButton!
    @IBOutlet weak var verticalScroller: NSScroller!
    @IBOutlet weak var staticInformationLabel: NSTextField!
    
    var playTimer = Timer()
    
    override func viewDidLoad() {
        
        
        
        super.viewDidLoad()
        // Do view setup here.
        
        
        //code notification observer
        NotificationCenter.default.addObserver(self, selector: #selector(collectionViewController.updateNotificationRefresh), name: NSNotification.Name(rawValue: notificationValues.notificationKey), object: nil)
        
        
        //staticInformationLabel.isHidden = true
        
        // staticInformationLabel.stringValue = "afafasdfas dfasd asdsafasdfasdfasdfasdf asdfasdfdagfasdgads dgasdgjoewjoqperuqworeywqfh sadfhkasdol fkawjef hwasdi fgaslkdjgfl asldfjkha sodifgyao iufalbksdjf hl"
        
        
        // load related information
        getAllAvailableScrapbookList()
        divideIntoTwoArray(stringArray: diaryInformationCollection.photoNameList)
        photoNameListGenerate()
        
        // make refresh button invisible
        refreshButton.isHidden = true
        
        
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
        print("vertical scroller value in viewdidload", colView.enclosingScrollView?.verticalScroller?.floatValue)
        // scroller vertical
        colView.enclosingScrollView?.verticalScroller?.floatValue = 1.0
        print("vertical scroller value in viewdidload", colView.enclosingScrollView?.verticalScroller?.floatValue)
        
        self.title = "Collection View"
        refreshButton.title = "Refresh"
        
        
//        if (collectionViewItemCount.countOfCollectionViewItem == 0){
//
//            staticInformationLabel.stringValue = "No recording has been save yet!"
//        }
//        else {
//            staticInformationLabel.isHidden = true
//        }
        
        // not work
//        if let contentSize = colView.collectionViewLayout?.collectionViewContentSize{
//            colView.setFrameSize(contentSize)
//        }
//
        
        
//        let clickGesture = NSClickGestureRecognizer(target: self, action: #selector(self.collectionViewSingleClick(_:)))
//        colView.addGestureRecognizer(clickGesture)
        
        //verticalScroller.scroll(NSPoint(x: 0, y: 0))
        // print("scroller size", verticalScroller.locationOfPrintRect(.zero))
        //verticalScroller.floatValue = 1.0
        // verticalScroller.locationOfPrintRect(.zero)
        // colView.intrinsicContentSize.height
        // colView.self.bounds.size.height
        
        // verticalScroller.scroll(NSPoint(x: 0, y: colView.self.bounds.size.height))
        
    }
    
    
    
    @objc func updateNotificationRefresh(){
        print("update function in collectionview window.")
        alternativeRefreshAction()
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        
        if let contentSize = colView.collectionViewLayout?.collectionViewContentSize{
                    colView.setFrameSize(contentSize)
        }
            
        print("vertical scroller value in viewwillappear", colView.enclosingScrollView?.verticalScroller?.floatValue)
        colView.enclosingScrollView?.verticalScroller?.floatValue = 1.0
        print("vertical scroller value in viewwillappear", colView.enclosingScrollView?.verticalScroller?.floatValue)
        let height = colView.bounds.size.height
//        colView.enclosingScrollView?.verticalScroller?.floatValue = Float(height)
        //colView.enclosingScrollView?.contentView.scroll(NSPoint(x: 0, y: height))
        
        
        
        
        if (collectionViewItemCount.countOfCollectionViewItem == 0){

            staticInformationLabel.stringValue = "No recording has been saved yet!"
            staticInformationLabel.font = NSFont(name: "AppleSystemUIFont", size: 22.0)
        }
        else {
            staticInformationLabel.isHidden = true
        }
        
    }
    
    
    @IBAction func verticalScrollerAction(_ sender: Any) {
        print(verticalScroller.floatValue)
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
    
    override func viewWillLayout() {
        super.viewWillLayout()
        print("vertical scroller value in viewwilllayout", colView.enclosingScrollView?.verticalScroller?.floatValue)
        colView.enclosingScrollView?.verticalScroller?.floatValue = 1.0
        print("vertical scroller value in viewwilllayout", colView.enclosingScrollView?.verticalScroller?.floatValue)
    }
    
    override func loadView() {
        super.loadView()
        print("vertical scroller value in loadview", colView.enclosingScrollView?.verticalScroller?.floatValue)
        colView.enclosingScrollView?.verticalScroller?.floatValue = 1.0
        print("vertical scroller value in loadview", colView.enclosingScrollView?.verticalScroller?.floatValue)
        
        
//        self.playTimer.fire()
//        self.playTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(automaticallyRefresh), userInfo: nil, repeats: true)
//        print("valid or not in loadview:", self.playTimer.isValid)
//
//        if (collectionViewItemCount.countOfCollectionViewItem == 0){
//
//           staticInformationLabel.stringValue = "No recording has been saved yet!"
//           staticInformationLabel.font = NSFont(name: "AppleSystemUIFont", size: 25.0)
//       }
//       else {
//           staticInformationLabel.isHidden = true
//       }
    }
    
    override func viewDidAppear() {
        self.view.window?.delegate = self
        self.playTimer.fire()
        // self.playTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.automaticallyRefresh), userInfo: nil, repeats: true)
        print("valid or not in viewdidappear:", self.playTimer.isValid)
    }
    
    func windowWillClose(_ notification: Notification) {

        self.playTimer.invalidate()
        print("valid or not in windowwill close:", self.playTimer.isValid)
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
        print("collectionViewItemCount = ", collectionViewItemCount.countOfCollectionViewItem)
        self.loadView()
        print("collectionViewItemCount = ", collectionViewItemCount.countOfCollectionViewItem)
        if (collectionViewItemCount.countOfCollectionViewItem == 0){
            staticInformationLabel.isHidden = false
            staticInformationLabel.stringValue = "No recording has been saved yet!"
            staticInformationLabel.font = NSFont(name: "AppleSystemUIFont", size: 22.0)
        }
        else{
            staticInformationLabel.isHidden = true
        }
    }
    
    // useless fucntion for testing
    @objc func automaticallyRefresh(){
        print("auto refresh in timer")
    }

    func testPrint(){
        self.loadView()

    }
    // useless functino ends here
    
    // end of the class
}
