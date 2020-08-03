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
    
    
    // return the name of the current front most application
    func frontmostApplication() -> String{
        let frontMostApplicationName = NSWorkspace.shared.frontmostApplication?.localizedName?.description
        print("current front most application is:", frontMostApplicationName!)
        return frontMostApplicationName!
        
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
    func screenAboveWindowListPrint() -> Array<String>{
        //let options = CGWindowListOption(arrayLiteral: .excludeDesktopElements, .optionOnScreenOnly)
        let temp = CGWindowListCopyWindowInfo(.optionOnScreenAboveWindow, CGWindowID(0))
        // let temp1 = CGWindowListCopyWindowInfo(.optionOnScreenBelowWindow, CGWindowID(0))
        var applicationNameStack = [String]()
        //let widowsListenInfor = CGWindowListCopyWindowInfo(option: optionOnScreenAboveWindow, CGWindowID(0))
        //let windowsListInfo = CGWindowListCopyWindowInfo(options, CGWindowID(0))
        // let infoList = temp as! [[String:Any]]
        let infoList = temp as! [[String:Any]]
        // let infoList1 = temp1 as! [[String:Any]]
        // print("infoList", infoList)
        // let visibleWindows = infoList.filter{ $0["kCGWindowLayer"] as! Int == 0 }
        
        var softwareNameList = infoList.filter{ ($0["kCGWindowLayer"] as! Int == 0) && ($0["kCGWindowOwnerName"] as? String != nil) }
        print("softwarenamelist", softwareNameList)

        var totoalRectArea = 0
        
        // var overlappedAreaWithLastLayer = 0
        
        var tempFirstx      = 0
        var tempFirstY      = 0
        var tempSecondX     = 0
        var tempSecondY     = 0
        
        print("kcgWindowName is not nil and the number of the opening software is: ", softwareNameList.count)
        
        var allApplicationNmaeList = [String]()
        var allApplicationPIDList = [String]()
        for singleApplication in softwareNameList {
            let singleApplicationName = singleApplication["kCGWindowOwnerName"] as! String
            print("PID", singleApplication["kCGWindowOwnerPID"] ?? "PID value is nil")
            let singleApplicationPIDName = String(describing: singleApplication["kCGWindowOwnerPID"])
            
            if (!allApplicationPIDList.contains(singleApplicationPIDName)){
                if singleApplicationName != "universalAccessAuthWarn" {
                    allApplicationNmaeList.append(singleApplicationName)
                    allApplicationPIDList.append(singleApplicationPIDName)
                }
            }
            
        }
        
        print("opened software name list in order: ", allApplicationNmaeList)
        
        
        
        variables.capturedApplicationNameList = allApplicationNmaeList

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
            if (applicationName == "universalAccessAuthWarn"){
                
            }
            else {
                print("bounds in dictionary format", boundDictionaryFormat)
                // dictionary.count == 4
                
                var firstX  : Int!
                var firstY  : Int!
                var height  : Int!
                var width   : Int!
                var secondX : Int!
                var secondY : Int!
                
                var newFirstX   : Int!
                var newFirstY   : Int!
                var newSecondX  : Int!
                var newSecondY  : Int!
                
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
                
                let x5 = max(screenShotInformation.firstCoordinationOfX, firstX)
                let y5 = max(screenShotInformation.firstCoordinationOfY, firstY)
                let x6 = min(screenShotInformation.secondCoordinationOfX, secondX)
                let y6 = min(screenShotInformation.secondCoordinationOfY, secondY)
                print("x5: ", x5)
                print("y5: ", y5)
                print("x5: ", x6)
                print("y6: ", y6)
                if (x5 > x6) || (y5 > y6){
                    print("no overlapping between screenshot and this application")
                    continue
                }
                else {
                    newFirstX = x5
                    newFirstY = y5
                    newSecondX = x6
                    newSecondY = y6
                    print("newFirstX: ", newFirstX!)
                    print("newFirstY: ", newFirstY!)
                    print("newSecondX:  ", newSecondX!)
                    print("newSecondY: ", newSecondY!)
                }
                
                
                let IntersectedArea = abs(newFirstX - newSecondX) * abs(newFirstY - newSecondY)
                print("Intersected Area is: ", IntersectedArea)
                print("tempFirstX: ", tempFirstx)
                print("tempFirstY: ", tempFirstY)
                print("tempSecondX: ", tempSecondX)
                print("tempSecondY: ", tempSecondY)
                let tempArea = twoRectangleOverlapArea(x1: tempFirstx, x2: tempSecondX, x3: newFirstX, x4: newSecondX, y1: tempFirstY, y2: tempSecondY, y3: newFirstY, y4: newSecondY)
                print("temp area is: ", tempArea)
                let validArea = IntersectedArea - tempArea
                
                tempFirstx = newFirstX
                tempFirstY = newFirstY
                tempSecondX = newSecondX
                tempSecondY = newSecondY
                
                print("valid Area: ", validArea)
                if (Double(validArea) / Double(areaOfScreenshot)) > 0 {
                    print("valid / total area is: ", (Double(validArea) / Double(areaOfScreenshot)))
                    applicationNameStack.append(applicationName)
                }
                totoalRectArea = totoalRectArea + validArea
                print("totalRectArea is: ", totoalRectArea)
                if (Double(totoalRectArea) / Double(areaOfScreenshot)) >= 1 {
                    print("app total / total area is: ", (Double(totoalRectArea) / Double(areaOfScreenshot)))
                    break
                }
            }
//            print("bounds in dictionary format", boundDictionaryFormat)
//            // dictionary.count == 4
//            
//            var firstX  : Int!
//            var firstY  : Int!
//            var height  : Int!
//            var width   : Int!
//            var secondX : Int!
//            var secondY : Int!
//            
//            var newFirstX   : Int!
//            var newFirstY   : Int!
//            var newSecondX  : Int!
//            var newSecondY  : Int!
//            
//            for (key, vaule) in boundDictionaryFormat {
//                print(key, vaule)
//                if (key as! String) == "X" {
//                    firstX = (boundDictionaryFormat.value(forKey: "X") as! Int)
//                    // print("the value of firstX is: ", firstX!)
//                    // print("the value of X: ", boundDictionaryFormat.value(forKey: "X") as! Int)
//                }
//                
//                else if (key as! String) == "Y" {
//                    firstY = ( boundDictionaryFormat.value(forKey: "Y") as! Int )
//                    // print("the value of firstY is: ", firstY!)
//                }
//                
//                else if (key as! String == "Width"){
//                    width = (boundDictionaryFormat.value(forKey: "Width") as! Int)
//                    // print("the value of secondX is: ", secondX!)
//                }
//                
//                else if (key as! String == "Height"){
//                    height =  (boundDictionaryFormat.value(forKey: "Height") as! Int)
//                    // print("the value of secondY is: ", secondY!)
//                }
//                
//                //print(boundDictionaryFormat.value(forKey: "X") as! Int)
//                
//                // get the bound information separately
//                
//                /*
//                 X 1440
//                 Height 1080
//                 Y 0
//                 Width 1920
//                 */
//            }
//            
//            secondX = firstX + width
//            secondY = firstY + height
//            
//            
//            // get the first and second coordination of the openning application
//            
//            print("software first x position: ", firstX!)
//            print("software first y position: ", firstY!)
//            print("software second x position: ", secondX!)
//            print("software second y position: ", secondY!)
//            
//            
//            /*
//             screenShotInformation.firstCoordinationOfX = firstCoordinationXInt
//             screenShotInformation.firstCoordinationOfY = firstCoordinationYInt
//             screenShotInformation.secondCoordinationOfX = secondCoordinationXInt
//             screenShotInformation.secondCoordinationOfY = secondCoordinationYInt
//             */
//            
//            print("screenshot first x: ", screenShotInformation.firstCoordinationOfX!)
//            print("screenshot first y: ", screenShotInformation.firstCoordinationOfY!)
//            print("screenshot second x: ", screenShotInformation.secondCoordinationOfX!)
//            print("secreenshot second y: ", screenShotInformation.secondCoordinationOfY!)
//            
//            // areaOfScreenshot is the area of the screenshot
//            let areaOfScreenshot = (screenShotInformation.secondCoordinationOfX - screenShotInformation.firstCoordinationOfX) * (screenShotInformation.secondCoordinationOfY - screenShotInformation.firstCoordinationOfY)
//            print("area of screenshot is: ", areaOfScreenshot)
//            
//            let x5 = max(screenShotInformation.firstCoordinationOfX, firstX)
//            let y5 = max(screenShotInformation.firstCoordinationOfY, firstY)
//            let x6 = min(screenShotInformation.secondCoordinationOfX, secondX)
//            let y6 = min(screenShotInformation.secondCoordinationOfY, secondY)
//            print("x5: ", x5)
//            print("y5: ", y5)
//            print("x5: ", x6)
//            print("y6: ", y6)
//            if (x5 > x6) || (y5 > y6){
//                print("no overlapping between screenshot and this application")
//                continue
//            }
//            else {
//                newFirstX = x5
//                newFirstY = y5
//                newSecondX = x6
//                newSecondY = y6
//                print("newFirstX: ", newFirstX!)
//                print("newFirstY: ", newFirstY!)
//                print("newSecondX:  ", newSecondX!)
//                print("newSecondY: ", newSecondY!)
//            }
//            
//            
//            let IntersectedArea = abs(newFirstX - newSecondX) * abs(newFirstY - newSecondY)
//            print("Intersected Area is: ", IntersectedArea)
//            print("tempFirstX: ", tempFirstx)
//            print("tempFirstY: ", tempFirstY)
//            print("tempSecondX: ", tempSecondX)
//            print("tempSecondY: ", tempSecondY)
//            let tempArea = twoRectangleOverlapArea(x1: tempFirstx, x2: tempSecondX, x3: newFirstX, x4: newSecondX, y1: tempFirstY, y2: tempSecondY, y3: newFirstY, y4: newSecondY)
//            print("temp area is: ", tempArea)
//            let validArea = IntersectedArea - tempArea
//            
//            tempFirstx = newFirstX
//            tempFirstY = newFirstY
//            tempSecondX = newSecondX
//            tempSecondY = newSecondY
//            
//            print("valid Area: ", validArea)
//            if (Double(validArea) / Double(areaOfScreenshot)) > 0 {
//                print("valid / total area is: ", (Double(validArea) / Double(areaOfScreenshot)))
//                applicationNameStack.append(applicationName)
//            }
//            totoalRectArea = totoalRectArea + validArea
//            print("totalRectArea is: ", totoalRectArea)
//            if (Double(totoalRectArea) / Double(areaOfScreenshot)) >= 1 {
//                print("app total / total area is: ", (Double(totoalRectArea) / Double(areaOfScreenshot)))
//                break
//            }
//            
            // let validArea = areaBetweenScreeshotAndApplication - overlappedAreaWithLastLayer
            // overlappedAreaWithLastLayer =
            
            /*
            kCGWindowBounds contains the start point of the applciation (x, y)
            and the height and width
             
            */
            // print(applicationName)
            // print(applicationBounds)
                
            // applicationNameStack.append(applicationName)
        }
        
    
        
        
    // old method
        
//    func screenAboveWindowListPrint() {
//        //let options = CGWindowListOption(arrayLiteral: .excludeDesktopElements, .optionOnScreenOnly)
//        let temp = CGWindowListCopyWindowInfo(.optionOnScreenAboveWindow, CGWindowID(0))
//        // let temp1 = CGWindowListCopyWindowInfo(.optionOnScreenBelowWindow, CGWindowID(0))
//        var applicationNameStack = [String]()
//        //let widowsListenInfor = CGWindowListCopyWindowInfo(option: optionOnScreenAboveWindow, CGWindowID(0))
//        //let windowsListInfo = CGWindowListCopyWindowInfo(options, CGWindowID(0))
//        // let infoList = temp as! [[String:Any]]
//        let infoList = temp as! [[String:Any]]
//        // let infoList1 = temp1 as! [[String:Any]]
//        //print("infoList", infoList)
//        let visibleWindows = infoList.filter{ $0["kCGWindowLayer"] as! Int == 0 }
//
//        let softwareNameList = infoList.filter{ ($0["kCGWindowLayer"] as! Int == 0) && ($0["kCGWindowOwnerName"] as? String != nil) }
//
//        var emptyRect = 0
//
//        print("kcgWindowName is not nil and the number of the opening software is: ", softwareNameList.count)
//
//        var allApplicationNmaeList = [String]()
//        for singleApplication in softwareNameList {
//            let singleApplicationName = singleApplication["kCGWindowOwnerName"] as! String
//            allApplicationNmaeList.append(singleApplicationName)
//        }
//
//        print("software name list in order: ", allApplicationNmaeList)
//
//        // print("software name list: ", softwareNameList)
//
//        for simpleSoftware in softwareNameList {
//            // print("one simple software window's information:", simpleSoftware)
//            // print("\n")
//            let applicationName = simpleSoftware["kCGWindowOwnerName"] as! String
//            let applicationBounds = simpleSoftware["kCGWindowBounds"]
//
//            /*
//            {
//             Height = 900;
//             Width = 1440;
//             X = 0;
//             Y = 0;
//             }
//            */
//            let boundDictionaryFormat = applicationBounds as! NSDictionary
//            print("software name is: ", applicationName)
//            print("bounds in dictionary format", boundDictionaryFormat)
//            // dictionary.count == 4
//
//            var firstX  : Int!
//            var firstY  : Int!
//            var height  : Int!
//            var width   : Int!
//            var secondX : Int!
//            var secondY : Int!
//
//            for (key, vaule) in boundDictionaryFormat {
//                print(key, vaule)
//                if (key as! String) == "X" {
//                    firstX = (boundDictionaryFormat.value(forKey: "X") as! Int)
//                    // print("the value of firstX is: ", firstX!)
//                    // print("the value of X: ", boundDictionaryFormat.value(forKey: "X") as! Int)
//                }
//
//                else if (key as! String) == "Y" {
//                    firstY = ( boundDictionaryFormat.value(forKey: "Y") as! Int )
//                    // print("the value of firstY is: ", firstY!)
//                }
//
//                else if (key as! String == "Width"){
//                    width = (boundDictionaryFormat.value(forKey: "Width") as! Int)
//                    // print("the value of secondX is: ", secondX!)
//                }
//
//                else if (key as! String == "Height"){
//                    height =  (boundDictionaryFormat.value(forKey: "Height") as! Int)
//                    // print("the value of secondY is: ", secondY!)
//                }
//
//                //print(boundDictionaryFormat.value(forKey: "X") as! Int)
//
//                // get the bound information separately
//
//                /*
//                 X 1440
//                 Height 1080
//                 Y 0
//                 Width 1920
//                 */
//            }
//
//            secondX = firstX + width
//            secondY = firstY + height
//
//
//            // get the first and second coordination of the openning application
//
//            print("software first x position: ", firstX!)
//            print("software first y position: ", firstY!)
//            print("software second x position: ", secondX!)
//            print("software second y position: ", secondY!)
//
//
//            /*
//             screenShotInformation.firstCoordinationOfX = firstCoordinationXInt
//             screenShotInformation.firstCoordinationOfY = firstCoordinationYInt
//             screenShotInformation.secondCoordinationOfX = secondCoordinationXInt
//             screenShotInformation.secondCoordinationOfY = secondCoordinationYInt
//             */
//
//            print("screenshot first x: ", screenShotInformation.firstCoordinationOfX!)
//            print("screenshot first y: ", screenShotInformation.firstCoordinationOfY!)
//            print("screenshot second x: ", screenShotInformation.secondCoordinationOfX!)
//            print("secreenshot second y: ", screenShotInformation.secondCoordinationOfY!)
//
//            // areaOfScreenshot is the area of the screenshot
//            let areaOfScreenshot = (screenShotInformation.secondCoordinationOfX - screenShotInformation.firstCoordinationOfX) * (screenShotInformation.secondCoordinationOfY - screenShotInformation.firstCoordinationOfY)
//            print("area of screenshot is: ", areaOfScreenshot)
//
//
//            // first case: screenshot area is completely in one opening application
//            // application's layer is counted from the front to the back (behind)
//            if ( (screenShotInformation.firstCoordinationOfX! >= firstX) && (screenShotInformation.firstCoordinationOfY! >= firstY) && (screenShotInformation.secondCoordinationOfX! <= secondX) && (screenShotInformation.secondCoordinationOfY! <= secondY) ) {
//                // screenshot area is contained in this software completely
//                print("screenshot is completely in one application currently, this software is: ", applicationName)
//                if applicationNameStack.contains(applicationName){
//                    // do nothing
//                }
//                else {
//                    applicationNameStack.append(applicationName)
//                }
//
//                break
//
//            }
//
//            // screenshot across multiple applications
//            else if ( (screenShotInformation.firstCoordinationOfX >= firstX) && (screenShotInformation.firstCoordinationOfY >= firstY) && ((screenShotInformation.secondCoordinationOfX >= secondX) || (screenShotInformation.secondCoordinationOfY >= secondY)) ){
//                // in this case, top left corner in application one, while the bottom right corner is not
//                // add application name into the stack
//                print("top left corner is in this application: ", applicationName)
//
//                let areaOfRectInFirstApplication = (screenShotInformation.secondCoordinationOfY - screenShotInformation.firstCoordinationOfY) * (secondX - screenShotInformation.firstCoordinationOfX)
//                print("area of rectangle in the first application:", areaOfRectInFirstApplication)
//
//                emptyRect = emptyRect + areaOfRectInFirstApplication
//                print("in top left corner if judgement loop, the current rect is:", emptyRect)
//                print(Double(Double(emptyRect) / Double(areaOfScreenshot)))
//                if Double(Double(emptyRect) / Double(areaOfScreenshot)) >= Double(0.8) && !(applicationNameStack.contains(applicationName)){
//                    applicationNameStack.append(applicationName)
//                    break
//                }
//
//                if Double(Double(emptyRect) / Double(areaOfScreenshot)) >= Double(0.15) && !(applicationNameStack.contains(applicationName)){
//                    applicationNameStack.append(applicationName)
//                }
////                if applicationNameStack.contains(applicationName){
////                    // do nothing
////                }
////                else {
////                    applicationNameStack.append(applicationName)
////                }
//            }
//
//            else if ( (screenShotInformation.secondCoordinationOfX <= secondX) && (screenShotInformation.secondCoordinationOfY <= secondY) && ((screenShotInformation.firstCoordinationOfX <= firstX) || (screenShotInformation.firstCoordinationOfY <= firstY)) ) {
//
//                print("bottom right corner is in this application: ", applicationName)
//
//                let areaOfRectInSecondApplication = (screenShotInformation.secondCoordinationOfX - firstX) * (screenShotInformation.secondCoordinationOfY - screenShotInformation.firstCoordinationOfY)
//                print("area of rectangle in the second application:", areaOfRectInSecondApplication)
//
//                emptyRect = emptyRect + areaOfRectInSecondApplication
//                print("in bottom right corner if judgement loop, the current rect is:", emptyRect)
//
//                print("emptyRect / areaOfScreenshot is: ", Double(Double(emptyRect) / Double(areaOfScreenshot)))
//                print(Double(Double(emptyRect) / Double(areaOfScreenshot)))
//                if (Double(Double(emptyRect) / Double(areaOfScreenshot)) >= Double(0.8)) && !(applicationNameStack.contains(applicationName)){
//                    applicationNameStack.append(applicationName)
//                    break
//                }
//
//                if Double(Double(emptyRect) / Double(areaOfScreenshot)) >= Double(0.15) && !(applicationNameStack.contains(applicationName)){
//                    applicationNameStack.append(applicationName)
//                }
//
//                // in this case, the bottom right corner is in application two, while top left corner is not
//                // add application name into the stack
////                if applicationNameStack.contains(applicationName){
////                    // do nothing
////                }
////                else {
////                    applicationNameStack.append(applicationName)
////                }
//            }
//
//            // the last if else
//            else {
//                print("the last else if")
//                let areaOfWholeApplication = (secondX - firstX) * (secondY - firstY)
//                emptyRect = emptyRect + areaOfWholeApplication
//                if Double(Double(emptyRect) / Double(areaOfScreenshot)) >= Double(0.8) && !(applicationNameStack.contains(applicationName)){
//
//                    applicationNameStack.append(applicationName)
//                    break
//                }
////                if applicationNameStack.contains(applicationName){
////                    // do nothing
////                }
////                else {
////                    applicationNameStack.append(applicationName)
////                }
//            }
//            /*
//            kCGWindowBounds contains the start point of the applciation (x, y)
//            and the height and width
//
//            */
//            // print(applicationName)
//            // print(applicationBounds)
//
//            // applicationNameStack.append(applicationName)
//        }
        
        
        
        print("application name list stack: ", applicationNameStack)
        variables.recordedApplicationNameStack = applicationNameStack
        variables.numberofRecordedApplication = applicationNameStack.count
        alternativeUserInterfaceVariables.capturedApplicationNumber = applicationNameStack.count
        return applicationNameStack

//        let softwareNameList1 = infoList1.filter{ ($0["kCGWindowLayer"] as! Int == 0) && ($0["kCGWindowOwnerName"] as? String != nil) }
//
//        print("kcgWindowName1 is not nil", softwareNameList1.count)
        //print("visibleWindows", visibleWindows)
    }

    func twoRectangleOverlapArea(x1 : Int, x2 : Int, x3 : Int, x4 : Int, y1 : Int, y2 : Int, y3 : Int, y4 : Int) -> Int{
        let x5 = max(x1, x3)
        let y5 = max(y1, y3)
        let x6 = min(x2, x4)
        let y6 = min(y2, y4)
        if (x5 > x6 || y5 > y6){
            print("two rectangles are not intersected with others")
            return 0
        }
        else {
           return (abs(x5 - x6) * abs(y5 - y6))
        }
        
    }
    
}
