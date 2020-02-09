//
//  SoftwareAppleScript.swift
//  Scrapbook
//
//  Created by Donghan Hu on 1/21/20.
//  Copyright © 2020 Donghan Hu. All rights reserved.
//

import Foundation
import Cocoa

class appleScript : NSObject{
    var ClassDictionary : [String : String] = [   "Preview"                 : "1",
                                                  "Pages"                   : "2",
                                                  "Numbers"                 : "2",
                                                  "Keynote"                 : "2",
                                                  "Xcode"                   : "3",
                                                  "Google Chrome"           : "4",
                                                  "Safari"                  : "5",
                                                  "Microsoft Word"          : "6",
                                                  "Microsoft Excel"         : "6",
                                                  "Microsoft PowerPoint"    : "6",
                                                  "Acrobat Reader"          : "6",
                                                  "Eclipse"                 : "6",
                                                  "TextEdit"                : "7"
       ]
    
    func softwareClassifyBasedOnCategory(softwareName: String){
        let categoryNumber = ClassDictionary[softwareName]
        if categoryNumber == "1" {
            let fileNameInPreview = PreviewFileName()
            let filePathInPreview = PreviewFilePath()
            let category = "Productivity"
            
        }
        
        else if categoryNumber == "2" {
            
        }
        
        else if categoryNumber == "3" {
            
        }
        
        else if categoryNumber == "4" {
            
        }
        
        else if categoryNumber == "5" {
            
        }
        
        else if categoryNumber == "6" {
            
        }
        
        else if categoryNumber == "7" {
            
        }
        
        else {
            
        }
        // end of the function: softwareClassifyBasedOnCategory
    }
    
    //preview opened file path
    func PreviewFilePath() -> String{
        
        let MyAppleScript = "tell application \"System Events\" \n tell process \"Preview\" \n set thefile to value of attribute \"AXDocument\" of window 1 \n end tell \n end tell"
        var error: NSDictionary?
        let scriptObject = NSAppleScript(source: MyAppleScript)
        let output: NSAppleEventDescriptor = scriptObject!.executeAndReturnError(&error)
        if (error != nil) {
            print("error: \(String(describing: error))")
        }
        if output.stringValue == nil{
            let empty = "empty"
            return empty
        }
        else {
            return (output.stringValue?.description)!
            
        }
    }
        
    // get the file name of the preview
    func PreviewFileName() -> String{
        let first = "tell application \"System Events\" \n tell process"
        let second = "\"Preview\" \n "
        let third = "set fileName to name of window 1 \n end tell \n end tell"
        let final = first + second + third
        var error: NSDictionary?
        let scriptObject = NSAppleScript(source: final)
        let output: NSAppleEventDescriptor = scriptObject!.executeAndReturnError(&error)
        if (error != nil) {
            print("error: \(String(describing: error))")
        }
        if output.stringValue == nil{
            let empty = "empty"
            return empty
        }
        else { return (output.stringValue?.description)!}
    }
    // end of the class
}
