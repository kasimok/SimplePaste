//
//  AppDelegate.swift
//  simplePaste
//
//  Created by Evilisn on 1/Apr/2022.
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {

    let pbManager = OkaPBManager.shared


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        pbManager.startMonitor()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }


}

