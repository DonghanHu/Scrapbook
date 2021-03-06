//
//  readcsvFile.swift
//  Scrapbook
//
//  Created by Donghan Hu on 2/8/20.
//  Copyright © 2020 Donghan Hu. All rights reserved.
//

import Foundation
import AppKit

class applescriptFileLoad : NSObject {
    
    func readCSV(){
        let filepath = Bundle.main.path(forResource: "applescript", ofType: "csv")!
        var contents = try! String(contentsOfFile: filepath, encoding: .utf8)
        contents = cleanRows(file: contents)
        let csvRows = csv(data: contents)
        // print(csvRows[12][1])
        for i in 0..<csvRows.count{
            // print(i)
            // print(csvRows[i][0])
            variables.softwareNameArray.append(csvRows[i][0])
        }

        variables.applescriptStingArray = csvRows

        // print(variables.softwareNameArray)
//        print(csvRows.count)
        // 0, 1 and 2
        // 0 is the name of the application
        // 1 is the path url of the opened application
        // 2 is the name title of the opened application
    }
    
    func readCSVAPPandCate(){
        let filepath = Bundle.main.path(forResource: "AppAndCate", ofType: "csv")!
        var contents = try! String(contentsOfFile: filepath, encoding: .utf8)
        contents = cleanRows(file: contents)
        let csvRows = csv(data: contents)
        var temp = [String]()
        // print(csvRows[12][1])
        for i in 0..<csvRows.count{
            temp.append(csvRows[i][0])
        }
        readNewCSVFileVariables.nameList = temp
        readNewCSVFileVariables.AppAndCateList = csvRows
            // 0, 1 and 2
            // 0 is the name of the application
            // 1 is the path url of the opened application
            // 2 is the name title of the opened application
    }
    func readCSVCateAndScript(){
        let filepath = Bundle.main.path(forResource: "CateAndScript", ofType: "csv")!
        var contents = try! String(contentsOfFile: filepath, encoding: .utf8)
        contents = cleanRows(file: contents)
        let csvRows = csv(data: contents)
        readNewCSVFileVariables.CateAndApplescriptList = csvRows
            // 0, 1 and 2
            // 0 is the name of the application
            // 1 is the path url of the opened application
            // 2 is the name title of the opened application
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
}
