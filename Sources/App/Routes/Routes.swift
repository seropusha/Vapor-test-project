import Vapor

public enum APIVersion: String {
    var value: String { return self.rawValue }
    case v1 = "api/v1/"
}
//let v1 = drop.grouped(APIVersion.v1.value)


extension Droplet {
    
    func setupRoutes() throws {
        
//        get("info") { req in
//            return req.description
//        }
//
//        get("tablesInfo") { req in
//            let result = try self.database?.driver.raw("SELECT * FROM sqlite_master WHERE type='table'")
//            return try JSON(node: result)
//        }
        
        try resource("remedy", RemedyController.self)
        try resource("remedyDescription", RemedyDescriptionController.self)
    }
}
