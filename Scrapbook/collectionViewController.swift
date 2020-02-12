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
        print("count for number", photonumber.photonumberCounting)
        print("count for photo name list length: ", diaryInformationCollection.photoNameList.count)
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
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do view setup here.
        let item = NSNib(nibNamed: "ColViewItem", bundle: nil)
        
        colView.register(item, forItemWithIdentifier: .collectionViewItem)
        
        colView.delegate = self
        colView.dataSource = self
        
        
        
        
    }
    

    
}
