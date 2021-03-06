# LeanCache 💁

![Platforms](https://img.shields.io/badge/platforms-iOS%20|%20watchOS%20|%20macOS%20|%20tvOS-blue.svg)
![Languages](https://img.shields.io/badge/languages-Swift%203-orange.svg)
![License](https://img.shields.io/badge/license-MIT%2FApache-blue.svg)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)][Carthage]
[![Cocoapods compatible](https://img.shields.io/badge/Cocoapods-compatible-red.svg
)][Cocoapods]

[Carthage]: https://github.com/carthage/carthage
[Cocoapods]: https://cocoapods.org

LeanCache allows you to cache and persist plain old objects that conform to NSCoding. To use LeanCache with value based struct models, simply create a class that implements NSCoding and wrap your model.

With LeanCache, you're in control of your own desteny! This is because LeanCache makes few assumptions about how you'd like to cache things and tasks you with creating your own object caching lifecycle.

# Swift 4
use the `swift-4` branch.

# Getting started – example caching lifecycle

All you need to do is start with a model like the following, but it should be readily apparent that it'd be trivial to modify this flow to fit your needs.

```swift
struct ExampleObject {
    let name: String
    let age: Int
    let favoriteLanguage: String

    init(name: String, age: Int, favoriteLanguage: String) {
        self.name = name
        self.age = age
        self.favoriteLanguage = favoriteLanguage
    }
}
```

Next, you'd create a cache type protocol and implement a coder for your model

```swift
protocol ExampleObjectCacheType {
    func get() -> ExampleObject?
    func set(object: ExampleObject)
}
```

```swift
class ExampleObjectCoder: NSObject, NSCoding {
    let exampleObject: ExampleObject?

    init(exampleObject: ExampleObject) {
        self.exampleObject = exampleObject
    }

    required init?(coder: NSCoder) {
        if let name = coder.decodeObjectForKey("name") as? String,
            let age = coder.decodeObjectForKey("age") as? Int,
            let favoriteLanguage = coder.decodeObjectForKey("favorite_language") as? String {
                self.exampleObject = ExampleObject(name: name, age: age, favoriteLanguage: favoriteLanguage)
            } else {
                self.exampleObject = nil
        }
    }

    func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(self.exampleObject?.name, forKey: "name")
        coder.encodeObject(self.exampleObject?.age, forKey: "age")
        coder.encodeObject(self.exampleObject?.favoriteLanguage, forKey: "favorite_language")
    }
}
```

After that, create a caching wrapper for your model

```swift
class ExampleObjectCache: NSObject, ExampleObjectCacheType {
    let cache: Cache<ExampleObjectCoder>

    override init() {
        self.cache = Cache(name: "exampleObject")
    }

    func get() -> ExampleObject? {
        return self.cache.get()?.exampleObject
    }

    func set(object: ExampleObject) {
        let coder = ExampleObjectCoder(exampleObject: object)
        self.cache.set(coder)
    }
}
```

Finally, you can interact with your cache and persist new objects

```swift
let andrew = ExampleObject(name: "Andrew", age: 25, favoriteLanguage: "Swift")
let mariah = ExampleObject(name: "Mariah", age: 22, favoriteLanguage: "Objective-C")

let cache = ExampleObjectCache()
cache.set(andrew)
print(cache.get()?.name) // "Andrew"

//get model from persistent cache
cache.set(mariah)
print(ExampleObjectCache().get()?.name) // "Mariah"

```

Authored by Klaas Pieter https://github.com/klaaspieter and migrated to Swift 3 / podified by Andrew Sowers https://github.com/asowers1
