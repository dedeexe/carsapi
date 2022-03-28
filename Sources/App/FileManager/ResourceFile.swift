import Foundation
import Vapor

enum ResourceFile: String {
    case brands = "brands.json"
    case cars  = "cars.json"

    var path: String {
        let directory = DirectoryConfiguration.detect()
        let filePath = directory
            .resourcesDirectory
            .appending("/")
            .appending(self.rawValue)

        return filePath
    }

    var url: URL {
        URL(fileURLWithPath: path)
    }
}
