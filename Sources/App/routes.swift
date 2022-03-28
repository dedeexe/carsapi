import Vapor

func routes(_ app: Application) throws {
    app.get { req in
        return "Pura magia!!!"
    }

    try app.register(collection: BrandsController())
    try app.register(collection: CarsController())
}
