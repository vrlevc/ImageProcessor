//
//  AppDelegate.swift
//  ImageProcessor
//
//  Created by Viktor Levchenko on 9/27/18.
//  Copyright © 2018 LVA. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

	// MARK: -
	
	@IBOutlet weak var window: NSWindow!

	// MARK: - Image Processor
	
	
	
	// MARK: - NSApplicationDelegate
	
	func applicationDidFinishLaunching(_ aNotification: Notification) {
		// Insert code here to initialize your application
		let isUnitTesting = ProcessInfo.processInfo.environment["IS_UNIT_TESTING"] == "1"
		if isUnitTesting {
			// init for unit testing - might skip something ...
		}
	}

	func applicationWillTerminate(_ aNotification: Notification) {
		// Insert code here to tear down your application
	}

	func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
		return true;
	}
}

