//
//  AppDelegate.swift
//  Scrapbook
//
//  Created by Donghan Hu on 12/26/19.
//  Copyright © 2019 Donghan Hu. All rights reserved.
//

import Cocoa
import Foundation
import AppKit
import CoreData

struct variables {
    static var defaultFolderPathString          = ""
    
    //the path of the latest taken screenshot
    static var latesScreenShotPathString        = ""
    static var latestScreenShotTime             = ""
    
    static var currentTimeInformation           = ""
    
    // json file path
    static var jsonFilePathURL                  = URL(string: "https://www.apple.com")
    static var jsonFilePathString               = ""
    
    // [[string]] save all applescript
    static var applescriptStingArray = [[""]]
    static var softwareNameArray = [String]()
    static var numberofRecordedApplication = 0
    static var recordedApplicationNameStack = [""]
    static var metaDataDictionary : [String : [String]] = [:]
    static var metaDataDictionaryTestOne : [String : Any] = ["Text"             :   String(),
                                                             "Title"            :   String(),
                                                             "PhotoTime"        :   [String](),
                                                             "screenshotPath"   :   [String](),
                                                             "Applications"     :   [String:[String]](),
                                                             "Coordinates"      :   [String:[String]]()
    ]
    
    
    
    static var metaDataIdctionaryTestDic : [String : [String]] = [:]
    
    static var countNumber                       = 1
    // static var dateCountNumber                   = 0
    static var dateCountNumber                   : Int!
    static var tempDay                           = 0
    static var defaultTitle                      = " "
    static var capturedApplicationNameList       = [""]
    static var detailedApplicationNameList       = [""]
    
    static var newKeyCollections                 = [String]()
    static var newRecordedApplicationNameStack   = [String]()
}

struct overviewWindowVariables {
    static var windowOpenOrClose            = false
    static var subOverviewWindowController : NSWindowController? = nil
}

struct overviewWiondowMainStoryBoard {
    static var windowOpenOrClose            = false
    static var subOverviewWindowController : NSWindowController? = nil
}

struct screenShotInformation {
    static var firstCoordinationOfX     : Int!
    static var firstCoordinationOfY     : Int!
    static var secondCoordinationOfX    : Int!
    static var secondCoordinationOfY    : Int!
}

struct diaryInformationCollection {
    static var photoNameList = [[""]]
    static var photoNameFirstInformation = [""]
    static var photoNameSecondInformation = [""]
}

struct photonumber {
    static var photonumberCounting  = 0
    static var photoPathList        = [String]()
    static var inputRelatedMessage  = [""]
    static var inputRelatedTitle    = [""]
}

struct detailedViewControllerVariables {
    static var numberofRecordedApplication = 0
    static var recordedApplicationNameStack = [""]
    static var recordedApplicationInformation = [String:[String]]()
}

struct alternativeUserInterfaceVariables {
    static var capturedApplicationNumber = 0
    static var capturedApplicationCount = 0
}

struct detailedWiondwVariables {
    static var buttonNumber = 0
    static var buttonCount = 0
    static var detailedDictionary : [String : Any] = [  "Text"             :   String(),
                                                        "Title"            :   String(),
                                                        "PhotoTime"        :   [String](),
                                                        "screenshotPath"   :   [String](),
                                                        "Applications"     :   [String:[String]]()
        
    ]
}

struct readNewCSVFileVariables {
    static var nameList = [String]()
    static var CateAndApplescriptList = [[""]]
    static var AppAndCateList = [[""]]
    
}

struct capturedApplicationsCoordinates {
    // to save captured applications' coordinates
    // esample: ["whole": ["whole", "349", "160", "574", "473"]]
    // x, y, width and height
    static var caputredCoordinates = [String:[String]]()
    static var screenWidth : Int!
    static var screenHeight : Int!
}


struct dataStructure: Codable {
    let text, title: String
    let apps: [App]
    let photoTime, screenshotPath: String

    enum CodingKeys: String, CodingKey {
        case text = "Text"
        case title = "Title"
        case apps
        case photoTime = "PhotoTime"
        case screenshotPath = "screenshotPath"
    }
}
struct App: Codable {
    let applicationname: String
    let applicationCategory: String
    let apppath: String
    let filename: String
}

struct screenshotInDetailedView {
    static var path: String!
    static var text = ""
    static var title = ""
}

struct popoverWindow {
    static var popover = NSPopover()
}

struct autosaveSet {
    static var autosaveFlag = false
    static var deleteRecordingRecordingWindow = false
}

struct collectionViewItemCount {
    static var countOfCollectionViewItem = -1
}

struct checkboxInformationCaptureWindoe {
    static var checkboxNameStack = [""]
    static var clickstatus = 0
    static var checkboxNameStackDetailedWindow = [""]
    static var clickstatusDetailedWindow = 0
}

struct checkDetailedWiondowOpenOrNot {
    static var openOrNot = false
}

// @available(OSX 10.13, *)
@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    
    let jsonFileHandler = jsonRelated()
    let csvFileReadHandler = applescriptFileLoad()
    
    let popover = NSPopover()// new one
    
    let popoverView = NSPopover()
    
    var eventMonitor : EventMonitor?

    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)

    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
//        let documents = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] 
        let folderPath = homePath() + "/Documents/" + "Scrapbook/"
        variables.defaultFolderPathString = folderPath
        print(variables.defaultFolderPathString)
        defaultFolder(folderPath: folderPath)
        jsonFileHandler.createjson(filepath: URL(string: variables.defaultFolderPathString)!)
        
//        if let button = statusItem.button {
//          button.image = NSImage(named:NSImage.Name("book"))
//          button.action = #selector(togglePopover(_:))
//        }
//        popover.contentViewController = ViewController.freshController()
//
        
        statusItem.button?.title = "S"
        statusItem.button?.target = self
        
        
        //NSApp.activate(ignoringOtherApps: true)
        
        // statusItem.button?.action = #selector(showSettings)
        // statusItem.button?.action = #selector(printQuote(_:))
        statusItem.button?.action = #selector(togglePopover(_:))
        popover.contentViewController = ViewController.freshController()
        
        csvFileReadHandler.readCSV()
        csvFileReadHandler.readCSVAPPandCate()
        csvFileReadHandler.readCSVCateAndScript()

        // set count number as 1
        let date = Date()
        let calendar = Calendar.current
        let stringDay = calendar.component(.day, from: date)
        let intDay = Int(stringDay)
        variables.tempDay = intDay
        
        // NSApplication.shared.keyWindow?.close()
        
        eventMonitor = EventMonitor(mask: [.leftMouseDown, .rightMouseDown]) { [weak self] event in
            if let strongSelf = self, strongSelf.popover.isShown {
            strongSelf.closePopover(sender: event)
          }
        }
        
        // checking permission for screen recording 
        takeTestImage()
        deleteTestImage()
        
        
        
    }
    
    func takeTestImage(){
        let task = Process()
        task.launchPath = "/usr/sbin/screencapture"
        var arguments = [String]();
        arguments.append("-x")

        arguments.append(variables.defaultFolderPathString + "test")
        task.arguments = arguments

        let outpipe = Pipe()
        task.standardOutput = outpipe
        task.standardError = outpipe
         do {
           try task.run()
         } catch {}
        
    }
    
    func deleteTestImage(){
        let path = variables.defaultFolderPathString + "test"
        do {
          try FileManager.default.removeItem(atPath: path)
        } catch{}
        
    }
    
    @objc func printQuote(_ sender: Any?) {
      let quoteText = "Never put off until tomorrow what you can do the day after tomorrow."
      let quoteAuthor = "Mark Twain"
      
      print("\(quoteText) — \(quoteAuthor)")
    }

    
    func XcodeFileName(softwarename : String) -> (String){
        let first = "tell application \"Xcode\" \n set fileName to name of window 1 \n end tell"
        var error: NSDictionary?
        print("first is, ", first)
        let scriptObject = NSAppleScript(source: first)
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

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    @objc func togglePopover(_ sender: Any?) {
        print("clicked icon S")
        // eventMonitor?.start()
      if popover.isShown {
        closePopover(sender: sender)
      } else {
        showPopover(sender: sender)
      }
        
    }

    func showPopover(sender: Any?) {
      if let button = statusItem.button {
        popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
      }
        eventMonitor?.start()

    }

    func closePopover(sender: Any?) {
      popover.performClose(sender)
        eventMonitor?.stop()
    }
    
    @objc func homePath() -> String{
        let pw = getpwuid(getuid())
        let home = pw?.pointee.pw_dir
        let homePath = FileManager.default.string(withFileSystemRepresentation: home!, length: Int(strlen(home!)))
        return homePath
    }
    
    @objc func defaultFolder(folderPath : String) {
        if FileManager.default.fileExists(atPath: folderPath){
            print(folderPath)
            print("default already existed")
        }
        else {
            do {
                try FileManager.default.createDirectory(atPath: folderPath, withIntermediateDirectories: true, attributes: nil)
                print(folderPath)
                print("default folder created successfully")
            } catch {
                
                print("default folder created failed")
                print(error)
            }
        }

    }
    
    @objc func showSettings() {
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateController(withIdentifier: "ViewController") as? ViewController else {
            fatalError("Unable to find Viewcontroller in the story board.")
        }
        
        guard let button = statusItem.button else {
            fatalError("could not find status item button.")
        }
        
        let popoverView = NSPopover()
        popoverView.contentViewController = vc
        popoverView.behavior = .transient
        popoverView.show(relativeTo: button.bounds, of: button, preferredEdge: .maxY)
        
        
//        popover.contentViewController = vc
//        popover.behavior = .transient
//        popover.show(relativeTo: button.bounds, of: button, preferredEdge: .maxY)
        
        
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Scrapbook")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving and Undo support

    @IBAction func saveAction(_ sender: AnyObject?) {
        // Performs the save action for the application, which is to send the save: message to the application's managed object context. Any encountered errors are presented to the user.
        let context = persistentContainer.viewContext

        if !context.commitEditing() {
            NSLog("\(NSStringFromClass(type(of: self))) unable to commit editing before saving")
        }
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Customize this code block to include application-specific recovery steps.
                let nserror = error as NSError
                NSApplication.shared.presentError(nserror)
            }
        }
    }

    func windowWillReturnUndoManager(window: NSWindow) -> UndoManager? {
        // Returns the NSUndoManager for the application. In this case, the manager returned is that of the managed object context for the application.
        return persistentContainer.viewContext.undoManager
    }

    func applicationShouldTerminate(_ sender: NSApplication) -> NSApplication.TerminateReply {
        // Save changes in the application's managed object context before the application terminates.
        let context = persistentContainer.viewContext
        
        if !context.commitEditing() {
            NSLog("\(NSStringFromClass(type(of: self))) unable to commit editing to terminate")
            return .terminateCancel
        }
        
        if !context.hasChanges {
            return .terminateNow
        }
        
        do {
            try context.save()
        } catch {
            let nserror = error as NSError

            // Customize this code block to include application-specific recovery steps.
            let result = sender.presentError(nserror)
            if (result) {
                return .terminateCancel
            }
            
            let question = NSLocalizedString("Could not save changes while quitting. Quit anyway?", comment: "Quit without saves error question message")
            let info = NSLocalizedString("Quitting now will lose any changes you have made since the last successful save", comment: "Quit without saves error question info");
            let quitButton = NSLocalizedString("Quit anyway", comment: "Quit anyway button title")
            let cancelButton = NSLocalizedString("Cancel", comment: "Cancel button title")
            let alert = NSAlert()
            alert.messageText = question
            alert.informativeText = info
            alert.addButton(withTitle: quitButton)
            alert.addButton(withTitle: cancelButton)
            
            let answer = alert.runModal()
            if answer == .alertSecondButtonReturn {
                return .terminateCancel
            }
        }
        // If we got here, it is time to quit.
        return .terminateNow
    }

}

