//
//  eventmonitor.swift
//  Scrapbook
//
//  Created by Donghan Hu on 8/14/20.
//  Copyright © 2020 Donghan Hu. All rights reserved.
//

import Cocoa

open class EventMonitor {
    // fileprivate means private in this file
    // private means only used in class or structure
    
    fileprivate var monitor: AnyObject?
    fileprivate let mask: NSEvent.EventTypeMask
    fileprivate let handler: (NSEvent?) -> ()
    
    
    public init(mask: NSEvent.EventTypeMask, handler: @escaping (NSEvent?) ->()) {
        self.mask = mask
        self.handler = handler
    }
    
    deinit {
        stop()
    }
    
    // open is kind of like public, but has greater useing than public
    // ? means the type of this value can be null or others
    open func start() {
        monitor = NSEvent.addGlobalMonitorForEvents(matching: mask, handler: handler) as AnyObject?
    }
    
    // ! maens the value is not null
    open func stop() {
        if monitor != nil {
            NSEvent.removeMonitor(monitor!)
            monitor = nil
        }
    }
}

