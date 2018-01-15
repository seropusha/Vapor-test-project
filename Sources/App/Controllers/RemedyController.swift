//
//  RemedyController.swift
//  TESTAPIPackageDescription
//
//  Created by Valeriya Ponamarenko on 10/24/17.
//

import Foundation
import Vapor
import HTTP
import SQLite

final class RemedyController: ResourceRepresentable {

    /// When users call 'GET'
    /// on '/remedy?limit=...&offset=...'
    /// OR '/remedy?randomCount=...'
    /// OR '/remedy?search=...&type=...'
    func index(_ req: Request) throws -> ResponseRepresentable {
        let query = try Remedy.makeQuery()
        
        // limit && offset
        if let limit = req.query?["limit"]?.int, let offset = req.query?["offset"]?.int {
            try query.limit(limit, offset: offset)
            return try query.all().makeJSON()
            
        /// random remedies
        } else if let randomCount = req.query?["randomCount"]?.int {
            guard randomCount < 100 else { return Response(status: .other(statusCode: 204, reasonPhrase: "Less 100 please")) }
            try query.randomChunkQuery(count: randomCount, field: Remedy.Keys.id)
            return try query.all().makeJSON()
            
        ///search by text
        } else if let searchText = req.query?["search"]?.string {
            let availableTypes: [String] = [Remedy.Keys.substance,
                                            Remedy.Keys.manufactured,
                                            Remedy.Keys.type,
                                            Remedy.Keys.farmType,
                                            Remedy.Keys.farmGroup]
            let inputType = req.query?["search"]?.string ?? ""
            let type = availableTypes.contains(inputType) ? inputType : Remedy.Keys.title
            try query.filter(type, .contains, searchText)
            return try query.all().makeJSON()
        }
        return Response(status: .noContent)
    }    
    
    /// When the consumer calls 'GET' on a specific resource, ie:
    /// '/remedy/13rd88' we should show that specific remedy
    func show(_ req: Request, remedy: Remedy) throws -> ResponseRepresentable {
        return try remedy.makeJSON()
    }
    
    /// When making a controller, it is pretty flexible in that it
    /// only expects closures, this is useful for advanced scenarios, but
    /// most of the time, it should look almost identical to this
    /// implementation
    func makeResource() -> Resource<Remedy> {
        return Resource(
            index: index,
            show: show
        )
    }
}

extension Request {
    /// Create a post from the JSON body
    /// return BadRequest error if invalid
    /// or no JSON
    func remedy() throws -> Remedy {
        guard let json = json else { throw Abort.badRequest }
        return try Remedy(json: json)
    }
}

/// Since PostController doesn't require anything to
/// be initialized we can conform it to EmptyInitializable.
///
/// This will allow it to be passed by type.
extension RemedyController: EmptyInitializable { }
