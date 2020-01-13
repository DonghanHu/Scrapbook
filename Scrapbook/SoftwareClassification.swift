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
        
        print("kcgWindowName is not nil and the number of the opening software is: ", softwareNameList.count)
        //print(softwareNameList)
        
        for simpleSoftware in softwareNameList {
            print("one simple software window's information:", simpleSoftware)
            print("\n")
            let applicationName = simpleSoftware["kCGWindowOwnerName"] as! String
            let applicationBounds = simpleSoftware["kCGWindowBounds"]

            /*
            {
             Height = 900;
             Width = 1440;
             X = 0;
             Y = 0;
             }
            */
            let boundDictionaryFormat = applicationBounds as! NSDictionary
            print("bounds in dictionary format", boundDictionaryFormat)
            // dictionary.count == 4
            for (key, vaule) in boundDictionaryFormat {
                print(key, vaule)
                if (key as! String) == "X" {
                    print(boundDictionaryFormat.value(forKey: "X") as! Int)
                }
                //print(boundDictionaryFormat.value(forKey: "X") as! Int)
                
                // get the bound information separately
                
                /*
                 X 1440
                 Height 1080
                 Y 0
                 Width 1920
                 */
            }
            /*
            kCGWindowBounds contains the start point of the applciation (x, y)
            and the height and width
             
            */
            //print(applicationName)
            // print(applicationBounds)
            applicationNameStack.append(applicationName)
        }
        print(applicationNameStack)

//        let softwareNameList1 = infoList1.filter{ ($0["kCGWindowLayer"] as! Int == 0) && ($0["kCGWindowOwnerName"] as? String != nil) }
//
//        print("kcgWindowName1 is not nil", softwareNameList1.count)
        //print("visibleWindows", visibleWindows)
    }

    
}
