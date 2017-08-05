//
//  LeanCacheTests.swift
//  LeanCacheTests
//
//  Created by Andrew Sowers on 8/5/17.
//  Copyright © 2017 Andrew Sowers. All rights reserved.
//

import XCTest
import LeanCache

class LeanCacheTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testPersist() {
        
        let andrew = ExampleObject(name: "Andrew", age: 24, favoriteLanguage: "Swift")
        let mariah = ExampleObject(name: "Mariah", age: 22, favoriteLanguage: "Objective-C")
        
        let cache = ExampleObjectCache()
        cache.set(andrew)
        
        ExampleObjectCache().set(mariah)
        
        let exampleObjects = [andrew, mariah]
        ExampleObjectCollectionCache().set(exampleObjects)
        
        XCTAssert(exampleObjects[0].name == cache.get()?.name)
        XCTAssert(exampleObjects[1].name != cache.get()?.name)
    }
    
    
}
