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
    
    let softwareBoundaryDictionary = [String : Int]()
    
    
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
        print("software name list: ", softwareNameList)
        
        for simpleSoftware in softwareNameList {
            // print("one simple software window's information:", simpleSoftware)
            // print("\n")
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
            print("software name is: ", applicationName)
            print("bounds in dictionary format", boundDictionaryFormat)
            // dictionary.count == 4
            
            var firstX  : Int!
            var firstY  : Int!
            var height  : Int!
            var width   : Int!
            var secondX : Int!
            var secondY : Int!
            
            for (key, vaule) in boundDictionaryFormat {
                print(key, vaule)
                if (key as! String) == "X" {
                    firstX = (boundDictionaryFormat.value(forKey: "X") as! Int)
                    // print("the value of firstX is: ", firstX!)
                    // print("the value of X: ", boundDictionaryFormat.value(forKey: "X") as! Int)
                }
                
                else if (key as! String) == "Y" {
                    firstY = ( boundDictionaryFormat.value(forKey: "Y") as! Int )
                    // print("the value of firstY is: ", firstY!)
                }
                
                else if (key as! String == "Width"){
                    width = (boundDictionaryFormat.value(forKey: "Width") as! Int)
                    // print("the value of secondX is: ", secondX!)
                }
                
                else if (key as! String == "Height"){
                    height =  (boundDictionaryFormat.value(forKey: "Height") as! Int)
                    // print("the value of secondY is: ", secondY!)
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
            
            secondX = firstX + width
            secondY = firstY + height
            
            
            // get the first and second coordination of the openning application
            
            print("software first x position: ", firstX!)
            print("software first y position: ", firstY!)
            print("software second x position: ", secondX!)
            print("software second y position: ", secondY!)
            
            
            /*
             screenShotInformation.firstCoordinationOfX = firstCoordinationXInt
             screenShotInformation.firstCoordinationOfY = firstCoordinationYInt
             screenShotInformation.secondCoordinationOfX = secondCoordinationXInt
             screenShotInformation.secondCoordinationOfY = secondCoordinationYInt
             */
            
            print("screenshot first x: ", screenShotInformation.firstCoordinationOfX!)
            print("screenshot first y: ", screenShotInformation.firstCoordinationOfY!)
            print("screenshot second x: ", screenShotInformation.secondCoordinationOfX!)
            print("secreenshot second y: ", screenShotInformation.secondCoordinationOfY!)
            
            // areaOfScreenshot is the area of the screenshot
            let areaOfScreenshot = (screenShotInformation.secondCoordinationOfX - screenShotInformation.firstCoordinationOfX) * (screenShotInformation.secondCoordinationOfY - screenShotInformation.firstCoordinationOfY)
            print("area of screenshot is: ", areaOfScreenshot)
            var emptyRect = 0
            
            // first case: screenshot area is completely in one opening application
            // application's layer is counted from the front to the back (behind)
            if ( (screenShotInformation.firstCoordinationOfX! >= firstX) && (screenShotInformation.firstCoordinationOfY! >= firstY) && (screenShotInformation.secondCoordinationOfX! <= secondX) && (screenShotInformation.secondCoordinationOfY! <= secondY) ) {
                // screenshot area is contained in this software completely
                print("screenshot is completely in one application currently, this software is: ", applicationName)
                if applicationNameStack.contains(applicationName){
                    // do nothing
                }
                else {
                    applicationNameStack.append(applicationName)
                }
                
                break

            }
            
            // screenshot across multiple applications
            if ( (screenShotInformation.firstCoordinationOfX >= firstX) && (screenShotInformation.firstCoordinationOfY >= firstY) && ((screenShotInformation.secondCoordinationOfX >= secondX) || (screenShotInformation.secondCoordinationOfY >= secondY)) ){
                // in this case, top left corner in application one, while the bottom right corner is not
                // add application name into the stack
                print("top left corner is in this application: ", applicationName)
                
                let areaOfRectInFirstApplication = (screenShotInformation.secondCoordinationOfY - screenShotInformation.firstCoordinationOfY) * (secondX - screenShotInformation.firstCoordinationOfX)
                print("area of rectangle in the first application:", areaOfRectInFirstApplication)
                
                emptyRect = emptyRect + areaOfRectInFirstApplication
                print("in top left corner if judgement loop, the current rect is:", emptyRect)
                
                if Double(Double(emptyRect) / Double(areaOfScreenshot)) >= Double(0.8) && !(applicationNameStack.contains(applicationName)){
                    applicationNameStack.append(applicationName)
                    break
                }
//                if applicationNameStack.contains(applicationName){
//                    // do nothing
//                }
//                else {
//                    applicationNameStack.append(applicationName)
//                }
            }
            
            if ( (screenShotInformation.secondCoordinationOfX <= secondX) && (screenShotInformation.secondCoordinationOfY <= secondY) && ((screenShotInformation.firstCoordinationOfX <= firstX) || (screenShotInformation.firstCoordinationOfY <= firstY)) ) {
                
                print("bottom right corner is in this application: ", applicationName)
                
                let areaOfRectInSecondApplication = (screenShotInformation.secondCoordinationOfX - firstX) * (screenShotInformation.secondCoordinationOfY - screenShotInformation.firstCoordinationOfY)
                print("area of rectangle in the second application:", areaOfRectInSecondApplication)
                
                emptyRect = emptyRect + areaOfRectInSecondApplication
                print("in bottom right corner if judgement loop, the current rect is:", emptyRect)
                
                print("emptyRect / areaOfScreenshot is: ", Double(Double(emptyRect) / Double(areaOfScreenshot)))
                
                if Double(Double(emptyRect) / Double(areaOfScreenshot)) >= Double(0.8) && !(applicationNameStack.contains(applicationName)){
                    applicationNameStack.append(applicationName)
                    break
                }
                // in this case, the bottom right corner is in application two, while top left corner is not
                // add application name into the stack
//                if applicationNameStack.contains(applicationName){
//                    // do nothing
//                }
//                else {
//                    applicationNameStack.append(applicationName)
//                }
            }
                
            // the last if else
            else {
                print("the last else if")
                let areaOfWholeApplication = (secondX - firstX) * (secondY - firstY)
                emptyRect = emptyRect + areaOfWholeApplication
                if Double(Double(emptyRect) / Double(areaOfScreenshot)) >= Double(0.8) && !(applicationNameStack.contains(applicationName)){
                    
                    applicationNameStack.append(applicationName)
                    break
                }
//                if applicationNameStack.contains(applicationName){
//                    // do nothing
//                }
//                else {
//                    applicationNameStack.append(applicationName)
//                }
            }
            /*
            kCGWindowBounds contains the start point of the applciation (x, y)
            and the height and width
             
            */
            // print(applicationName)
            // print(applicationBounds)
                
            // applicationNameStack.append(applicationName)
        }
        
        print("application name list stack: ", applicationNameStack)

//        let softwareNameList1 = infoList1.filter{ ($0["kCGWindowLayer"] as! Int == 0) && ($0["kCGWindowOwnerName"] as? String != nil) }
//
//        print("kcgWindowName1 is not nil", softwareNameList1.count)
        //print("visibleWindows", visibleWindows)
    }

    
}
