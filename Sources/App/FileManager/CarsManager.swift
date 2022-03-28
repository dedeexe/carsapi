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
        cars.first(where: { $0.id == id })
    }

    func addNewCar(_ car: Car) -> Car {
        var car = car
        car.id = UUID().uuidString
        self.cars.append(car)
        return car
    }

    func removeCar(by id: String) -> Car? {
        guard let car = cars.first(where: { $0.id == id }) else {
            return nil
        }

        self.cars = cars.filter { $0.id != id }
        return car
    }
}


