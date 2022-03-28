import Foundation
import Vapor

struct CarsController: RouteCollection {

    private let carsManager = CarsManager.shared

    func boot(routes: RoutesBuilder) throws {
        routes.get("cars", use: allCars)
        routes.get("cars", ":id", use: carById)
        routes.post("cars", use: createCar)
    }

    private func allCars(req: Request) throws -> [Car] {
        carsManager.cars
    }

    private func carById(req: Request) throws -> Car {
        guard let carId = req.parameters.get("id"),
              let car = carsManager.getCar(by: carId) else {
            throw Abort(.notFound)
        }

        return car
    }

    private func createCar(req: Request) throws -> Car {
        let decoder = JSONDecoder()

        guard let buffer = req.body.data,
              let car = try? decoder.decode(Car.self, from: buffer) else {
            throw Abort(.badRequest)
        }

        let newCar = carsManager.addNewCar(car)
        return newCar
    }

}


