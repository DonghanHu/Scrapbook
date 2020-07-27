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
        
        if (photonumber.photonumberCounting == diaryInformationCollection.photoNameList.count - 1){
            photonumber.photonumberCounting = 0
        }
        else {
            photonumber.photonumberCounting = photonumber.photonumberCounting + 1
        }
        
        return item
    }
    

    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return diaryInformationCollection.photoNameFirstInformation.count
    }

    
    
    @IBOutlet weak var colView: NSCollectionView!
    
    override func viewWillAppear() {
        self.view.window?.level = NSWindow.Level(rawValue: Int(CGWindowLevelForKey(.mainMenuWindow) + 1))
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do view setup here.
        
        
        // print("window level", NSWindow.Level(rawValue: Int(CGWindowLevelForKey(.mainMenuWindow))))
        
        let item = NSNib(nibNamed: "ColViewItem", bundle: nil)
        
        colView.register(item, forItemWithIdentifier: .collectionViewItem)
    
        colView.layer?.borderWidth = 13.0
        colView.layer?.borderColor = NSColor.red as! CGColor
        
        colView.delegate = self
        colView.dataSource = self
        self.title = "Collection View"
    
        
    }
    

    
}
