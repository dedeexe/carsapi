import Foundation
import Vapor

struct BrandsController: RouteCollection {

    private let brandsManager = BrandsManager.shared

    func boot(routes: RoutesBuilder) throws {
        routes.get("brands", use: allBrands)
        routes.get("brands", ":id", use: brandById)
    }

    private func allBrands(req: Request) throws -> [Brand] {
        brandsManager.brands
    }

    private func brandById(req: Request) throws -> Brand {
        guard let brandId = Int(req.parameters.get("id") ?? ""),
              let brand = brandsManager.getBrand(by: brandId) else {
            throw Abort(.notFound)
        }
        
        return brand
    }

}


