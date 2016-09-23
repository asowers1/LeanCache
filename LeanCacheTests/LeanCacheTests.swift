import Quick
import Nimble
import LeanCache

class RGBTests: QuickSpec {
    override func spec() {
        describe("LeanCache") {
            it("can cache objects") {
                let andrew = ExampleObject(name: "Andrew", age: 24, favoriteLanguage: "Swift")
                let mariah = ExampleObject(name: "Mariah", age: 21, favoriteLanguage: "Objective-C")
                
                let cache = ExampleObjectCache()
                cache.set(andrew)
                
                ExampleObjectCache().set(mariah)
                
                let exampleObjects = [andrew, mariah]
                ExampleObjectCollectionCache().set(exampleObjects)
                
                expect(ExampleObjectCollectionCache().get()?[0].name == cache.get()?.name).toEventually(beTrue())
            }
        }
    }
}
