import Vapor

struct Car: Content {
    var id: String?
    var brand: String
    var name: String
    var price: Double
    var gas_type: Int
}
