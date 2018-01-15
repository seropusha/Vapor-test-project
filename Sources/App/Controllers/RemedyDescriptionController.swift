//
//  RemedyDescriptionController.swift
//  App
//
//  Created by Sergey Navka on 11/30/17.
//

import Foundation
import Vapor
import HTTP

final class RemedyDescriptionController: ResourceRepresentable {
    
    /// When the consumer calls 'GET' on a specific resource, ie:
    /// '/remedy/13rd88' we should show that specific remedy
    func show(_ req: Request, remedyDescription: RemedyDescription) throws -> ResponseRepresentable {
        return try remedyDescription.makeJSON()
    }
    
    /// When making a controller, it is pretty flexible in that it
    /// only expects closures, this is useful for advanced scenarios, but
    /// most of the time, it should look almost identical to this
    /// implementation
    func makeResource() -> Resource<RemedyDescription> {
        return Resource(
            show: show
        )
    }
}

extension Request {
    /// Create a post from the JSON body
    /// return BadRequest error if invalid
    /// or no JSON
    func remedyDescription() throws -> RemedyDescription {
        guard let json = json else { throw Abort.badRequest }
        return try RemedyDescription(json: json)
    }
}

/// Since PostController doesn't require anything to
/// be initialized we can conform it to EmptyInitializable.
///
/// This will allow it to be passed by type.
extension RemedyDescriptionController: EmptyInitializable { }

