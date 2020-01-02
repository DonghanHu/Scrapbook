//
//  takeScreenShot.swift
//  Scrapbook
//
//  Created by Donghan Hu on 12/30/19.
//  Copyright © 2019 Donghan Hu. All rights reserved.
//

import Foundation
class Screencapture : NSObject {
    
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
        print("save path", arguments)
        task.arguments = arguments
        task.launch() // asynchronous call.
        
        
//        task.waitUntilExit()
    }

    
    
}
