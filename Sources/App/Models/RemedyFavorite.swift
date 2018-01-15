//
//  Favorite.swift
//  App
//
//  Created by Sergey Navka on 12/1/17.
//

import FluentProvider
import HTTP

final class RemedyFavorite: Model {
    let storage = Storage()

    // MARK: Properties
    var key: String
    var remedyID: Identifier
    
    // MARK: Database keys
    struct Keys {
        static let id              = "id"
        static let key             = "key"
        static let remedyID        = "remedy_id"
    }
    
    /// Creates a new RemedyFavorite
    init(key: String, remedyID: Identifier) {
        self.key = key
        self.remedyID = remedyID
    }
    
    // MARK: Fluent Serialization
    
    /// Initializes the Post from the
    /// database row
    init(row: Row) throws {
        key = try row.get(RemedyFavorite.Keys.key)
        remedyID = try row.get(RemedyFavorite.Keys.remedyID)
    }
    
    // Serializes the RemedyFavorite to the database
    func makeRow() throws -> Row {
        var row = Row()
        try row.set(RemedyFavorite.Keys.key, key)
        try row.set(RemedyFavorite.Keys.remedyID, remedyID)
        return row
    }
}

// MARK: JSON

// How the model converts from / to JSON.
//
extension RemedyFavorite: JSONConvertible {
    convenience init(json: JSON) throws {
        self.init(
            key: try json.get(RemedyFavorite.Keys.key),
            remedyID: try json.get(RemedyFavorite.Keys.remedyID)
        )
    }
    
    func makeJSON() throws -> JSON {
        var json = JSON()
        try json.set(RemedyFavorite.Keys.id, id)
        try json.set(RemedyFavorite.Keys.key, key)
        try json.set(RemedyFavorite.Keys.remedyID, remedyID)
        return json
    }
}

//MARK: Parent
extension RemedyFavorite {
    var owner: Parent<RemedyFavorite, Remedy> {
        return parent(id: remedyID)
    }
}

// MARK: Fluent Preparation

extension RemedyFavorite: Preparation {
    /// Prepares a table/collection in the database
    /// for storing Favorites
    static func prepare(_ database: Database) throws {
        try database.create(self) { builder in
            builder.id()
            builder.string(RemedyFavorite.Keys.key)
            builder.string(RemedyFavorite.Keys.remedyID)
            builder.parent(Remedy.self)
        }
    }
    
    /// Undoes what was done in `prepare`
    static func revert(_ database: Database) throws {
        try database.delete(self)
    }
}

