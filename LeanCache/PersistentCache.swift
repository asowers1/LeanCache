//
//  PersistentCache.swift
//  LeanCache
//
//  Created by Andrew Sowers on 05/27/2016.
//  Copyright (c) 2016 Andrew Sowers. All rights reserved.
//

import Foundation

class PersistentCache<T: NSCoding> {
    let name: String
    let fileManager: NSFileManager
    let cacheDirectory: NSURL
    
    init(name: String) {
        self.name = name
        self.fileManager = NSFileManager.defaultManager()
        
        let cachesDirectory = self.fileManager.URLsForDirectory(.CachesDirectory, inDomains: .UserDomainMask).first!
        self.cacheDirectory = cachesDirectory.URLByAppendingPathComponent(name)!
    }
    
    func filePathForKey(key: String) -> String {
        return self.cacheDirectory.URLByAppendingPathComponent(key)!.path!
    }
    
    func get(key: String) -> T? {
        return NSKeyedUnarchiver.unarchiveObjectWithFile(self.filePathForKey(key)) as? T
    }
    
    func set(object: T, forKey key: String) {
        do {
            try self.fileManager.createDirectoryAtURL(self.cacheDirectory, withIntermediateDirectories: true, attributes: nil)
        } catch _ {
            
        }
        NSKeyedArchiver.archiveRootObject(object, toFile: self.filePathForKey(key))
    }
    
    func clear() {
        do {
            try self.fileManager.removeItemAtURL(self.cacheDirectory)
        } catch _ {
        }
    }
}
