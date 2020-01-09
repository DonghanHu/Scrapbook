//
//  jsonfile.swift
//  Scrapbook
//
//  Created by Donghan Hu on 12/30/19.
//  Copyright © 2019 Donghan Hu. All rights reserved.
//

import Foundation
class jsonRelated: NSObject {
    
    
    func createjson(filepath: URL) -> URL{
        let documentsDirectoryPath = filepath
        let jsonFilePath = documentsDirectoryPath.appendingPathComponent("Scrapbook.json")
        let fileManager = FileManager.default
        var isDirectory: ObjCBool = false
        if !fileManager.fileExists(atPath: (jsonFilePath.absoluteString), isDirectory: &isDirectory) {
            let created = fileManager.createFile(atPath: (jsonFilePath.absoluteString), contents: nil, attributes: nil)
            if created {
                print("json file path:", jsonFilePath)
                print("Json file created ")
                WriteInitialData(Filepath: (jsonFilePath.absoluteString))
                
            } else {
                print("Couldn't create json file for some reason")
            }
        } else {
            print("json file path:", jsonFilePath)
            print("File already exists")
        }
        return jsonFilePath
    }
    
        func WriteInitialData(Filepath : String){
//            let date = Date()
//            let calendar = Calendar.current
//            let day = calendar.component(.day, from: date)
//            let month = calendar.component(.month, from: date)
//            let year = calendar.component(.year, from: date)
//            let hour = calendar.component(.hour, from: date)
//            let current = String(year) + "-" + String(month) + "-" + String(day) + "-" + String(hour)
//            let dateFormatter = DateFormatter()
//            dateFormatter.dateStyle = DateFormatter.Style.medium
//            dateFormatter.timeStyle = DateFormatter.Style.medium
//            let tempdate = Calendar.current.date(byAdding: .hour, value: 0, to: Date())
//            var dateString = dateFormatter.string(from: tempdate!)
//            let final = dateFormatter.date(from: dateString)
//            dateFormatter.dateFormat = "yyyy-M-d-HH:mm:ss"
//            let date24 = dateFormatter.string(from: final!)
            var ArrayOfDictionary = [Dictionary<String, Any>]()
            let recordingCount = 0
            let dictionary : [String : Any] =
                [
                    "Introduction" : "Hello, world"
            ]
//            let NameofSession = Filepath.replacingOccurrences(of: "/test.json", with: "")
            ArrayOfDictionary.append(dictionary)
            var temp : [String : Any] =
                [
                    "NameOfFile"                : "Data collecting, editing and saving",
                    "NumberOfRecording"         : recordingCount,
                    "BasicInformation"          : ArrayOfDictionary
            ]
            
            let jsonData = try! JSONSerialization.data(withJSONObject: temp, options: JSONSerialization.WritingOptions.prettyPrinted)
            if FileManager.default.fileExists(atPath: Filepath){
                var err:NSError?
                if let fileHandle = FileHandle(forWritingAtPath: Filepath){
                    fileHandle.write(jsonData)
                    fileHandle.closeFile()
                }
                else {
                    print("Can't open fileHandle \(String(describing: err))")
                }
            }
            
            
        }
}
