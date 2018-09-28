//
//  ImageIO_Tests.swift
//  ImageIO_Tests
//
//  Created by Viktor Levchenko on 9/27/18.
//  Copyright © 2018 LVA. All rights reserved.
//

import XCTest
import ImageIO

class ImageIO_Tests: XCTestCase {
	
	let mediaFolder : String  = "/ImageIO_Tests/TestMedia"
	var mediaPath : String? = nil
	
    override func setUp() {
        super.setUp()
		mediaPath = search(subFolder: mediaFolder)
		NSLog( " >>> --------- TEST LOGGING ---------" )
    }
    
    override func tearDown() {
		NSLog( " >>> --------------------------------" )
        super.tearDown()
    }

// MARK: -
	
	func search(subFolder: String,
				startingFromPath: String = FileManager.default.currentDirectoryPath,
				by fileManager: FileManager = FileManager.default,
				silent: Bool = true) -> String?
	{
		for index in startingFromPath.split(separator: "/") {
			let subPath = String( startingFromPath[..<index.endIndex] ) + subFolder
			if !silent { NSLog( " >>> Searching ... : \(subPath)" ) }
			if fileManager.fileExists(atPath: subPath ) {
				if !silent { NSLog( " >>> Found : \(subPath)" ) }
				return subPath
			}
		}
		return nil
	}
	
	func test_Media()
	{
		NSLog( " >>> Searching test media ..." );
		
		let fm = FileManager.default
		XCTAssertNotNil( fm );

		let path = fm.currentDirectoryPath
		NSLog( " >>> Current Dir Path : \(fm.currentDirectoryPath)" )
		
		let media = search(subFolder: mediaFolder, startingFromPath: path, by:fm, silent:false)
		XCTAssert( FileManager.default.fileExists(atPath: media ?? "") )
	}
	
	func test_Source_SupportedImageFormats()
	{
		NSLog( "Supported SOURCE types:" )
		let supportedSourceTypes : CFArray = CGImageSourceCopyTypeIdentifiers()
		CFShow( supportedSourceTypes )
    }

	func test_Destination_SupportedImageFormars()
	{
		NSLog( "Supported DESTINATION types:" )
		let supportedDestinationTypes : CFArray = CGImageDestinationCopyTypeIdentifiers()
		CFShow(supportedDestinationTypes)
	}
	
	func test_CGImageSource() throws
	{
		XCTAssertNotNil(mediaPath)
		for media in try FileManager.default.contentsOfDirectory(atPath: mediaPath!) {
			// Path to media file:
			let path = mediaPath! + "/" + media
			NSLog( " >>> Use as source path : \(path)" )
			XCTAssertTrue( FileManager.default.fileExists(atPath: path) )
			// CFUrl of media file:
			let url = CFURLCreateWithFileSystemPath(kCFAllocatorDefault, path as CFString, .cfurlposixPathStyle, false)
			XCTAssertNotNil(url)
			// Image Source:
			let source = CGImageSourceCreateWithURL(url!, nil)
			XCTAssertNotNil(source)
			// Get some source inforamtion:
			let type: CFString? = CGImageSourceGetType( source! )
			let count: Int = CGImageSourceGetCount( source! )
			NSLog( " >>> CGImageSourceGetType : \(type ?? "does not supported" as CFString)" )
			NSLog( " >>> CGImageSourceGetCount : \(count)" )
			
			// go through all images in source:
			for index in 0..<count {
				let image = CGImageSourceCreateImageAtIndex(source!, index, nil)
				XCTAssertNotNil(image)
			}
		}
	}
	
}














