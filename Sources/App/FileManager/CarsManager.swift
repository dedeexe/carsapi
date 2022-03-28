import Vapor

class CarsManager {

    private(set) var cars: [Car] = []

    static let shared: CarsManager = {
        CarsManager()
    }()

    private init() {
        do {
            let data = try Data(contentsOf: ResourceFile.cars.url)
            let decoder = JSONDecoder()
            let carsList = try decoder.decode([Car].self, from: data)
            self.cars = carsList
        } catch {
            fatalError("Impossible to load cars: \(error.localizedDescription)")
        }
    }

    func getCar(by id: String) -> Car? {
        cars.filter { $0.id == id }.first
    }

    func addNewCar(_ car: Car) -> Car {
        var car = car
        car.id = UUID().uuidString
        self.cars.append(car)
        return car
    }
}


