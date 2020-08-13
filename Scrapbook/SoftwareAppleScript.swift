//
//  SoftwareAppleScript.swift
//  Scrapbook
//
//  Created by Donghan Hu on 1/21/20.
//  Copyright © 2020 Donghan Hu. All rights reserved.
//

import Foundation
import Cocoa

extension Dictionary {
    mutating func merge(dict: [Key: Value]){
        for (k, v) in dict {
            updateValue(v, forKey: k)
        }
    }
}

class appleScript : NSObject{
    
    func applicationMetaData(applicationNameStack : [String]) {
        
        let length = applicationNameStack.count
        for i in 0..<length {
            if variables.softwareNameArray.contains(applicationNameStack[i]){
                for j in 0..<variables.softwareNameArray.count{
                    if variables.softwareNameArray[j] == applicationNameStack[i]{
                        let applicationName = returnApplicationName(softwareName: applicationNameStack[i])
                        let applicationFirstResult = returnApplicationFirstFactor(softwareName: applicationNameStack[i])
                        let applicationSecondResult = returnApplicationSecondFactor(softwareName: applicationNameStack[i])
                        let applicationThirdResult = returnApplicationThirdFactor(softwareName: applicationNameStack[i])
                        // print("applicationName", applicationName)
                        let firstInformation = FirstApplicationInformation(softwareName: applicationNameStack[i], cate: applicationThirdResult)
                        let secondInformation = secondApplicationInformation(softwareName: applicationNameStack[i], cate: applicationThirdResult)
                        
//                        print("old second", applicationSecondResult)
//                        print("new second", secondInformation)
//                        print("old one", applicationFirstResult)
//                        print("new one", firstInformation)
                        // print("first factor result", applicationFirstResult)
                        // print("second factor result", applicationSecondResult)
                        var valueArray = [String]()
                        valueArray.append(applicationFirstResult)
                        valueArray.append(applicationSecondResult)
                        valueArray.append(applicationThirdResult)
                        
                        variables.metaDataDictionary[applicationName] = valueArray
                        var applicationInformationDictionary = [String:[String]]()
                        
                        
                        
                        var applicationInformationDictionaryCopy = [String:[String]]()
                        // applicationInformationDictionary[applicationName] = [applicationFirstResult,applicationSecondResult]
                        applicationInformationDictionary[applicationName] = [firstInformation, secondInformation, applicationThirdResult]
                        applicationInformationDictionaryCopy = variables.metaDataDictionaryTestOne["Applications"] as! [String : [String]]
                        applicationInformationDictionaryCopy.merge(dict: applicationInformationDictionary)
                        variables.metaDataDictionaryTestOne["Applications"] = applicationInformationDictionaryCopy
                        // print("who knows whether it works or not", variables.metaDataDictionaryTestOne["Applications"])
//                        var d1 = ["a": "b"]
//                        var d2 = ["c": "e"]
//                        d1.merge(dict: d2)
                        
                        print("firstInformation", firstInformation)
                        // file path
                        print("secondInformation", secondInformation)
                        // file name
                        print("applicationThirdResult", applicationThirdResult)
                        // application category: Xcode, Prod2
                        
                    }
                    
                    
                // end of for loop for softwareNameArray
                }
            }
            else {
                let emptyFirst = ""
                let emptySecond = ""
                var applicationInformationDictionary = [String:[String]]()
                var applicationInformationDictionaryCopy = [String:[String]]()
                applicationInformationDictionary[applicationNameStack[i]] = [emptyFirst,emptySecond, "Others"]
                applicationInformationDictionaryCopy = variables.metaDataDictionaryTestOne["Applications"] as! [String : [String]]
                applicationInformationDictionaryCopy.merge(dict: applicationInformationDictionary)
                variables.metaDataDictionaryTestOne["Applications"] = applicationInformationDictionaryCopy
                
                //continue
            }
            
            
        // end of for loop for applicationNameStack
        }
        
        var tempCoordinates = variables.metaDataDictionaryTestOne["Coordinates"] as! [String : [String]]
        tempCoordinates.merge(dict: capturedApplicationsCoordinates.caputredCoordinates)
        variables.metaDataDictionaryTestOne["Coordinates"] = tempCoordinates
        print("final dictionary", variables.metaDataDictionaryTestOne)
        
        
        // print("this is the dictionary of metadata", variables.metaDataDictionary)
    }
    

    
    func returnApplicationName(softwareName: String) -> String{
        return softwareName
    }
    
    
    func returnApplicationFirstFactor(softwareName: String) -> String{
        for i in 0..<variables.applescriptStingArray.count{
            if softwareName == variables.applescriptStingArray[i][0] {
                let applescriptCode = variables.applescriptStingArray[i][1]
                print("running applescriptCode", applescriptCode)
                let applescriptResult = runApplescript(applescript: applescriptCode)
                print("middle first running apple script code, ", applescriptResult)
                let result = runApplescript(applescript: applescriptResult)
                print("running applescript result", result)
                // return applescriptResult
                return result
            }
            else {
                continue
            }
        }
        return "first factor error"
        
    }
    
    func returnApplicationSecondFactor(softwareName: String) -> String{
        for i in 0..<variables.applescriptStingArray.count{
            if softwareName == variables.applescriptStingArray[i][0] {
                let applescriptCode = variables.applescriptStingArray[i][2]
                print("second running applescriptCode", applescriptCode)
                let applescriptResult = runApplescript(applescript: applescriptCode)
                print("middel result  of second running applescript", applescriptResult)
                let result = runApplescript(applescript: applescriptResult)
                print("second running applescript result", result)
                // return applescriptResult
                return result
            }
            else {
                continue
            }
        }
       return "Second factor error"
    }
    
    func FirstApplicationInformation(softwareName: String, cate: String) -> String{
        for i in 0..<readNewCSVFileVariables.CateAndApplescriptList.count{
            if cate == readNewCSVFileVariables.CateAndApplescriptList[i][0] {
                let initScriptCode = readNewCSVFileVariables.CateAndApplescriptList[i][1]
                let tempScriptCode = initScriptCode.replacingOccurrences(of: "AlternativeApplicationName", with: softwareName)
                let applescriptResult = runApplescript(applescript: tempScriptCode)
                let result = runApplescript(applescript: applescriptResult)
                return result
            }
            
        }
        return "first factor is nil"
    }
    
    func secondApplicationInformation(softwareName: String, cate: String) -> String{
        for i in 0..<readNewCSVFileVariables.CateAndApplescriptList.count{
            if cate == readNewCSVFileVariables.CateAndApplescriptList[i][0] {
                let initScriptCode = readNewCSVFileVariables.CateAndApplescriptList[i][2]
                print("applescript code for second information, file name", initScriptCode)
                let tempScriptCode = initScriptCode.replacingOccurrences(of: "AlternativeApplicationName", with: softwareName)
                let applescriptResult = runApplescript(applescript: tempScriptCode)
                print("applescript for second inforamtion in lines, file name", applescriptResult)
                let result = runApplescript(applescript: applescriptResult)
                print("result for second inforamtion, file name", result)
                return result
            }
            
        }
        return "second factor is nil"
    }
    
    func returnApplicationThirdFactor(softwareName: String) -> String{
        for i in 0..<readNewCSVFileVariables.AppAndCateList.count{
            if softwareName == readNewCSVFileVariables.AppAndCateList[i][0]{
                return readNewCSVFileVariables.AppAndCateList[i][1]
            }
            
        }
        return "Others"
    }

    
    func runApplescript(applescript : String) -> String{
        var error: NSDictionary?
        let scriptObject = NSAppleScript(source: applescript)
        let output: NSAppleEventDescriptor = scriptObject!.executeAndReturnError(&error)
        // print("output", output)
        if (error != nil) {
            print("error: \(String(describing: error))")
        }
        if output.stringValue == nil{
            let empty = "the result is empty"
            return empty
        }
        else {
            return (output.stringValue?.description)!
            
        }
    }
    
    
    func cleanRows(file:String)->String{
        var cleanFile = file
        cleanFile = cleanFile.replacingOccurrences(of: "\r", with: "\n")
        cleanFile = cleanFile.replacingOccurrences(of: "\n\n", with: "\n")
        //        cleanFile = cleanFile.replacingOccurrences(of: ";;", with: "")
        //        cleanFile = cleanFile.replacingOccurrences(of: ";\n", with: "")
        return cleanFile
    }
    
    
    func csv(data: String) -> [[String]] {
        var result: [[String]] = []
        let rows = data.components(separatedBy: "\n")
        for row in rows {
            // print(row)
            let columns = row.components(separatedBy: ",")
            result.append(columns)
        }
        return result
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
