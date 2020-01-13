//
//  takeScreenShot.swift
//  Scrapbook
//
//  Created by Donghan Hu on 12/30/19.
//  Copyright © 2019 Donghan Hu. All rights reserved.
//

import Foundation
import AppKit

class Screencapture : NSObject {
    
    
    var timerDetectMouseClickAction : Timer = Timer()
    let softeareClassifyHandler = softwareClassify()
    
    
    func selectScreenCapture(){
        
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM.dd,HH:mm:ss"
        let dateString = dateFormatter.string(from: date)
        let task = Process()
        task.launchPath = "/usr/sbin/screencapture"
        var arguments = [String]();
        arguments.append("-s")
        
        arguments.append(variables.defaultFolderPathString + "Screenshot-" + dateString + ".jpg")
        
        variables.latesScreenShotPathString = variables.defaultFolderPathString + "Screenshot-" + dateString + ".jpg"
        
        print("save path", variables.latesScreenShotPathString)
        task.arguments = arguments
        
        let outpipe = Pipe()
        task.standardOutput = outpipe

        
        task.launch() // asynchronous call.
        
        
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
        let output1 = String(data: outdata, encoding: .utf8)


        
        task.waitUntilExit()
        

        
        
        print("output", output1)
        
        // mouseLocation()
        
        print("the process of takeing screenshot is finished, and the images has been saved locally.")
        softeareClassifyHandler.frontmostApplication()
        
        // timerDetectMouseClickAction.invalidate()
//        print("timer detecting mouse action has been stopped.")
        
        //pause for 0.5 second
        //sleep(UInt32(0.5))
        
        let screenshotEditWindowHandler : NSViewController = screenshotEditWindow()
        let subWindow = NSWindow(contentViewController:  screenshotEditWindowHandler)
        let subWindowController = NSWindowController(window: subWindow)
        subWindowController.showWindow(nil)

        
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
    
}
