import UIKit

class Person: NSObject, Codable {
    static let defaultName = "Unknown"
    var name : String
    var imagePath : String
    
    init(name: String = defaultName, imagePath: String) {
        self.name = name
        self.imagePath = imagePath
    }
}
