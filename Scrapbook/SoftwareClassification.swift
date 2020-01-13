//
//  SoftwareClassification.swift
//  Scrapbook
//
//  Created by Donghan Hu on 1/2/20.
//  Copyright © 2020 Donghan Hu. All rights reserved.
//

import Foundation
import AppKit

class softwareClassify : NSObject {
    
    func currentMousePosition (){
        let xMoustLoaction = Int(NSEvent.mouseLocation.x)
        let yMouseLocation = Int(NSEvent.mouseLocation.y)
        // x and y are current mouse location of the major monitor
        
    }
    
    func frontmostApplication(){
        let frontMostApplicationName = NSWorkspace.shared.frontmostApplication?.localizedName?.description
        print("current front most application is:", frontMostApplicationName!)
        
    }
    
    func openingApplication(){
        let openingApplicationList = NSWorkspace.shared.runningApplications.description
         for runningApp in NSWorkspace.shared.runningApplications {
            if (runningApp.isHidden){
                print(runningApp, "is hidden")
            }
            else {
                print(runningApp.localizedName)
            }
//            if let bundleIdentifier = runningApp.localizedName {
//                print(bundleIdentifier)
//            }
                   
        }
    }
    
    func screenAboveWindowListPrint() {
        //let options = CGWindowListOption(arrayLiteral: .excludeDesktopElements, .optionOnScreenOnly)
        let temp = CGWindowListCopyWindowInfo(.optionOnScreenAboveWindow, CGWindowID(0))
        // let temp1 = CGWindowListCopyWindowInfo(.optionOnScreenBelowWindow, CGWindowID(0))
        var applicationNameStack = [String]()
        //let widowsListenInfor = CGWindowListCopyWindowInfo(option: optionOnScreenAboveWindow, CGWindowID(0))
        //let windowsListInfo = CGWindowListCopyWindowInfo(options, CGWindowID(0))
        // let infoList = temp as! [[String:Any]]
        let infoList = temp as! [[String:Any]]
        // let infoList1 = temp1 as! [[String:Any]]
        //print("infoList", infoList)
        let visibleWindows = infoList.filter{ $0["kCGWindowLayer"] as! Int == 0 }
        
        let softwareNameList = infoList.filter{ ($0["kCGWindowLayer"] as! Int == 0) && ($0["kCGWindowOwnerName"] as? String != nil) }
        
        print("kcgWindowName is not nil", softwareNameList.count)
        print(softwareNameList)
        
        for simpleSoftware in softwareNameList {
            let applicationName = simpleSoftware["kCGWindowOwnerName"] as! String
            let applicationBounds = simpleSoftware["kCGWindowBounds"]
            /*
            kCGWindowBounds contains the start point of the applciation (x, y)
            and the height and width
             
            */
            //print(applicationName)
            //print(applicationBounds)
            applicationNameStack.append(applicationName)
        }
        print(applicationNameStack)

//        let softwareNameList1 = infoList1.filter{ ($0["kCGWindowLayer"] as! Int == 0) && ($0["kCGWindowOwnerName"] as? String != nil) }
//
//        print("kcgWindowName1 is not nil", softwareNameList1.count)
        //print("visibleWindows", visibleWindows)
    }

    
}
