import Vapor

class BrandsManager {

    private(set) var brands: [Brand] = []

    static let shared: BrandsManager = {
        BrandsManager()
    }()

    private init() {
        do {
            let data = try Data(contentsOf: ResourceFile.brands.url)
            let decoder = JSONDecoder()
            let brandsList = try decoder.decode([Brand].self, from: data)
            self.brands = brandsList
        } catch {
            fatalError("Impossible to load brands: \(error.localizedDescription)")
        }
    }

    func getBrand(by id: Int) -> Brand? {
        brands.filter { $0.id == id }.first
    }
}
