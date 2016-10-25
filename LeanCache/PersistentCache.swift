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
    let fileManager: FileManager
    let cacheDirectory: URL
    
    init(name: String) {
        self.name = name
        self.fileManager = FileManager.default
        
        let cachesDirectory = self.fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first!
        self.cacheDirectory = cachesDirectory.appendingPathComponent(name)
    }
    
    func filePathForKey(_ key: String) -> String {
        return self.cacheDirectory.appendingPathComponent(key).path
    }
    
    func get(_ key: String) -> T? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: self.filePathForKey(key)) as? T
    }
    
    func set(_ object: T, forKey key: String) {
        do {
            try self.fileManager.createDirectory(at: self.cacheDirectory, withIntermediateDirectories: true, attributes: nil)
        } catch _ {
            
        }
        NSKeyedArchiver.archiveRootObject(object, toFile: self.filePathForKey(key))
    }
    
    func clear() {
        do {
            try self.fileManager.removeItem(at: self.cacheDirectory)
        } catch _ {
        }
    }
}
