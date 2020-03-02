//
//  takeScreenShot.swift
//  Scrapbook
//
//  Created by Donghan Hu on 12/30/19.
//  Copyright © 2019 Donghan Hu. All rights reserved.
//

import Foundation
import AppKit
import ScreenCapture

//extension StringProtocol {
//    func index<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> Index? {
//        range(of: string, options: options)?.lowerBound
//    }
//    func endIndex<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> Index? {
//        range(of: string, options: options)?.upperBound
//    }
//    func indices<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> [Index] {
//        var indices: [Index] = []
//        var startIndex = self.startIndex
//        while startIndex < endIndex,
//            let range = self[startIndex...]
//                .range(of: string, options: options) {
//                indices.append(range.lowerBound)
//                startIndex = range.lowerBound < range.upperBound ? range.upperBound :
//                    index(range.lowerBound, offsetBy: 1, limitedBy: endIndex) ?? endIndex
//        }
//        return indices
//    }
//    func ranges<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> [Range<Index>] {
//        var result: [Range<Index>] = []
//        var startIndex = self.startIndex
//        while startIndex < endIndex,
//            let range = self[startIndex...]
//                .range(of: string, options: options) {
//                result.append(range)
//                startIndex = range.lowerBound < range.upperBound ? range.upperBound :
//                    index(range.lowerBound, offsetBy: 1, limitedBy: endIndex) ?? endIndex
//        }
//        return result
//    }
//}

extension Collection where Element: Equatable {
    func indexDistance(of element: Element) -> Int? {
        guard let index = firstIndex(of: element) else { return nil }
        return distance(from: startIndex, to: index)
    }
}
extension StringProtocol {
    func indexDistance<S: StringProtocol>(of string: S) -> Int? {
        guard let index = range(of: string)?.lowerBound else { return nil }
        return distance(from: startIndex, to: index)
    }
}


class Screencapture : NSObject {
    
    
    var timerDetectMouseClickAction : Timer = Timer()
    
    var softeareClassificationHandler = softwareClassify()
    
    var applescriptHandler = appleScript()
    
    var takeScreenshotSuccess = false
    
    // using packet to take screenshot from the github
    func screenCaptureFramework(){
        
//        let regionUrl = ScreenCapture.captureRegion("/path/to/save/to.png")
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM.dd,HH:mm:ss"
        let dateString = dateFormatter.string(from: date)
        variables.latesScreenShotPathString = variables.defaultFolderPathString + "Screenshot-" + dateString + ".jpg"
        
        
        let regionUrl = ScreenCapture.captureRegion(variables.latesScreenShotPathString)
        
        
    }
    
    
    // using swift code to take screenshot
    // this take the screenshot of the whole screen
    
    func screenCaptureSwiftCodeMethod(folderName: String){
        
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM.dd,HH:mm:ss"
        let dateString = dateFormatter.string(from: date)
        variables.latesScreenShotPathString = variables.defaultFolderPathString + "Screenshot-" + dateString + ".jpg"
        
        dateFormatter.dateFormat = "yyyy, MMMM, dd, E, hh:mm:ss"
        let currentTime = dateFormatter.string(from: date)
        variables.currentTimeInformation = currentTime
        print("current", currentTime)
        
        var displayCount: UInt32 = 0;
        var result = CGGetActiveDisplayList(0, nil, &displayCount)
        if (result != CGError.success) {
            print("error: \(result)")
            return
        }
        let allocated = Int(displayCount)
        let activeDisplays = UnsafeMutablePointer<CGDirectDisplayID>.allocate(capacity: allocated)
        result = CGGetActiveDisplayList(displayCount, activeDisplays, &displayCount)

        if (result != CGError.success) {
            print("error: \(result)")
            return
        }
        
        for i in 1...displayCount {
            // let unixTimestamp = CreateTimeStamp()
            
            let fileUrl = URL(fileURLWithPath: variables.latesScreenShotPathString)
            
            // let fileUrl = URL(fileURLWithPath: folderName + "\(unixTimestamp)" + "_" + "\(i)" + ".jpg", isDirectory: true)
            let screenShot:CGImage = CGDisplayCreateImage(activeDisplays[Int(i-1)])!
            let bitmapRep = NSBitmapImageRep(cgImage: screenShot)
            let jpegData = bitmapRep.representation(using: NSBitmapImageRep.FileType.jpeg, properties: [:])!
            do {
                try jpegData.write(to: fileUrl, options: .atomic)
            }
            catch {print("error: \(error)")}
        }
    }
    // function to create time stamp, now it is not used
    func CreateTimeStamp() -> Int32
    {
        return Int32(Date().timeIntervalSince1970)
    }
    
    
    // my method of taking screenshot by using terminate line code
    // /usr/sbin/screencapture
    func selectScreenCapture(){
        
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM.dd,HH:mm:ss"
        let dateString = dateFormatter.string(from: date)
        
        dateFormatter.dateFormat = "yyyy, MMMM, dd, E, hh:mm:ss"
        let currentTime = dateFormatter.string(from: date)
        variables.currentTimeInformation = currentTime
        
        let task = Process()
        task.launchPath = "/usr/sbin/screencapture"
        var arguments = [String]();
        arguments.append("-s")
        
        arguments.append(variables.defaultFolderPathString + "Screenshot-" + dateString + ".jpg")
        
        variables.latesScreenShotPathString = variables.defaultFolderPathString + "Screenshot-" + dateString + ".jpg"
        variables.latestScreenShotTime = dateString
        print("save path", variables.latesScreenShotPathString)
        task.arguments = arguments
        
        let outpipe = Pipe()
        task.standardOutput = outpipe
        task.standardError = outpipe

        
        
        //task.launch() // asynchronous call.
        do {
          try task.run()
        } catch {}

        
        
        
        // time interval has been set as 0.2 second temporally
        
        // self.timerDetectMouseClickAction = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(mouseClick), userInfo: nil, repeats: true)
//        let outpipe = Pipe()
//        task.standardOutput = outpipe
        
        // 2020-01-06 17:49:18.482325-0500
        // screencapture[33094:10098239] [default]
        // captureRect = (2799.0, 384.0, 338.0, 275.0)

//        while task.isRunning {
//
//            if !(task.scriptingProperties!.isEmpty){
//                print("script", task.scriptingProperties)
//            }
//
//        }
        
        let outdata = outpipe.fileHandleForReading.readDataToEndOfFile()
        let output = String(data: outdata, encoding: .utf8)
        
        // output is String format
        // let outputDictionary = output as NSDictionary
        // print ("output dictionary format", outputDictionary)

        let temp = ( output as! String )
        // print("output", output!)
        print ("temp", temp)
        
        if temp.contains("captureRect"){
            

        
            // get the index fo ( and )
            // print("first index of (", temp.indexDistance(of: "(")!)
            // print("first index of )", temp.indexDistance(of: ")")!)
            
            let startPositionInt = temp.indexDistance(of: "(")! + 1
            // method one without ")"
            let endPositionInt = temp.indexDistance(of: ")")!
            // method two with ")"
            // let endPositionInt = temp.indexDistance(of: ")")! + 1
            let totalLength = temp.count
            let endPoint = 0 - ( totalLength - endPositionInt )
            
            let startingPoint = temp.index(temp.startIndex, offsetBy: startPositionInt)
            let endingPoint = temp.index(temp.endIndex, offsetBy: endPoint)
            
            let range = startingPoint..<endingPoint
            let recTangleString = temp[range]
            print("final sub string: ", temp[range])
            // now I get a string contains coordination of the screenshot
            // method 1: 2874.0, 254.0, 773.0, 580.0
            // method 2: 3022.0, 186.0, 751.0, 556.0)
            // print("start index:", output?.index(of: "captureRect")!)
            // print("end index:", output?.endIndex(of: ")")!)
            
            // (12, 12) -> (701, 51) ======= (1452.0, 12.0) -> (701.0, 51.0)
            // 1452 because it is on a additional screen
            // so it is the upper left coordination and bottom right coordination
            
            // get the first coordination of X
            let firstCommaPosition = recTangleString.indexDistance(of: ",")!
            let firstCommaIndex = recTangleString.index(recTangleString.startIndex, offsetBy: firstCommaPosition)
            let firstCoordinationX = String(recTangleString[..<firstCommaIndex])
            let firstCoordinationXInt = (firstCoordinationX as NSString).integerValue
            print("first x: ", firstCoordinationXInt)
            
            let secondEndPooint = 0 - (recTangleString.count - firstCommaPosition) + 2
            let secondPartEndIndex = recTangleString.index(recTangleString.endIndex, offsetBy: secondEndPooint)
            let secondPartOfRectangleInformation = recTangleString[secondPartEndIndex...]
            print("second part string: ", secondPartOfRectangleInformation)
            
            // get the first coordination of Y
            let secondCommaPosition = secondPartOfRectangleInformation.indexDistance(of: ",")!
            let secondCommaIndex = secondPartOfRectangleInformation.index(secondPartOfRectangleInformation.startIndex, offsetBy: secondCommaPosition)
            let firstCoordinationY = String(secondPartOfRectangleInformation[..<secondCommaIndex])
            let firstCoordinationYInt = (firstCoordinationY as NSString).integerValue
            print("first y: ", firstCoordinationYInt)
            
            let thirdEndPoint = 0 - ( secondPartOfRectangleInformation.count - secondCommaPosition ) + 2
            let thirdPartEndIndex = secondPartOfRectangleInformation.index(secondPartOfRectangleInformation.endIndex, offsetBy: thirdEndPoint)
            let thirdPartOfRectangleInformation = secondPartOfRectangleInformation[thirdPartEndIndex...]
            print("third part string: ", thirdPartOfRectangleInformation)
            
            // get the second coordination of X
            let thirdCommaPosition = thirdPartOfRectangleInformation.indexDistance(of: ",")!
            let thirdCommaIndex = thirdPartOfRectangleInformation.index(thirdPartOfRectangleInformation.startIndex, offsetBy: thirdCommaPosition)
            let secondCoordinationX = String(thirdPartOfRectangleInformation[..<thirdCommaIndex])
            let secondCoordinationXInt = (secondCoordinationX as NSString).integerValue
            print("second X: ", secondCoordinationXInt)
            
            let forthEndPoint = 0 - ( thirdPartOfRectangleInformation.count - secondCommaPosition) + 2
            let forthPartEndIndex = thirdPartOfRectangleInformation.index(thirdPartOfRectangleInformation.endIndex, offsetBy: forthEndPoint)
            let forthPartOfRectangleInformation = thirdPartOfRectangleInformation[forthPartEndIndex...]
            print("forth part string: ", forthPartOfRectangleInformation)
            
            // get the second coordination of Y
            let forthCommaPosition = forthPartOfRectangleInformation.indexDistance(of: ".")!
            let forthCommaIndex = forthPartOfRectangleInformation.index(forthPartOfRectangleInformation.startIndex, offsetBy: forthCommaPosition)
            let secondCoordinationY = String(forthPartOfRectangleInformation[..<forthCommaIndex])
            let secondCoordinationYInt = (secondCoordinationY as NSString).integerValue
            print("second Y: ", secondCoordinationYInt)
            
            // get for coordination of the screenshot
            // (firstCoordinationXInt, firstCoordinationYInt) -> (secondCoordinationXInt, secondCoordinationYInt)
    //        if secondCoordinationXInt < firstCoordinationXInt {
    //            screenShotInformation.firstCoordinationOfX = secondCoordinationXInt
    //            screenShotInformation.secondCoordinationOfX = firstCoordinationXInt
    //        }
    //
    //        if secondCoordinationYInt < firstCoordinationYInt {
    //            screenShotInformation.firstCoordinationOfY = secondCoordinationYInt
    //            screenShotInformation.secondCoordinationOfY = firstCoordinationYInt
    //        }
    //
            screenShotInformation.firstCoordinationOfX = firstCoordinationXInt
            screenShotInformation.firstCoordinationOfY = firstCoordinationYInt
            screenShotInformation.secondCoordinationOfX = firstCoordinationXInt + secondCoordinationXInt
            screenShotInformation.secondCoordinationOfY = firstCoordinationYInt + secondCoordinationYInt
            alternativeUserInterfaceVariables.capturedApplicationCount = 0
            alternativeUserInterfaceVariables.capturedApplicationNumber = 0
            takeScreenshotSuccess = true
            
        }
        
        // softeareClassificationHandler.screenAboveWindowListPrint()
        
        task.waitUntilExit()
        
        if (takeScreenshotSuccess){
            let applicationNameStack = softeareClassificationHandler.screenAboveWindowListPrint()
            // let applicationNameStackLength = applicationNameStack.count
            applescriptHandler.applicationMetaData(applicationNameStack: applicationNameStack)
            print("the process of takeing screenshot is finished, and the images has been saved locally.")
           
            
// code for screenshotEditWindow view controller
//            let screenshotEditWindowHandler : NSViewController = screenshotEditWindow()
//            let subWindow = NSWindow(contentViewController:  screenshotEditWindowHandler)
//            let subWindowController = NSWindowController(window: subWindow)
//            subWindowController.showWindow(nil)
            
            
            let temp2 : NSViewController = testViewController()
            let subWindow2 = NSWindow(contentViewController: temp2)
            let subWindowController2 = NSWindowController(window: subWindow2)
            subWindowController2.showWindow(nil)
            
//            let temp3: NSViewController = testViewController()
//            temp3.view.display()
            
            
            
        }
            
            
        else {
            print("the action of taking a screenshot failed. please repeat your action.")
        }
        
        
        
        
        // print("output", output1)
        
        // mouseLocation()
        
        
        // softeareClassifyHandler.frontmostApplication()
        
        // timerDetectMouseClickAction.invalidate()
//        print("timer detecting mouse action has been stopped.")
        
        //pause for 0.5 second
        //sleep(UInt32(0.5))
        


        
    }

    @objc func mouseClick(){
        let bool = NSEvent.pressedMouseButtons
        if bool == 1 {
            let xMouseCoordination = NSEvent.mouseLocation.x
            let yMouseCoordination = NSEvent.mouseLocation.y
                        
            print("mouse location of starting: ", xMouseCoordination, yMouseCoordination)
        }
    }
    
    func mouseLocation(){
        let xMouseCoordination = NSEvent.mouseLocation.x
        let yMouseCoordination = NSEvent.mouseLocation.y
        print("mouse locatin of ending: ", xMouseCoordination, yMouseCoordination)
    }
    
    func switchTwoValue(valueOne : Int, valueTwo : Int){
        
    }
    
}
