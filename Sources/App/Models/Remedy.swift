//
//  Remedy.swift
//  TESTAPIPackageDescription
//
//  Created by Valeriya Ponamarenko on 10/24/17.
//

import FluentProvider
import HTTP

final class Remedy: Model {
    let storage = Storage()
    
    // MARK: Properties
    var title: String
    var titleFull: String
    var substance: String
    var manufactured: String
    var type: String
    var farmType: String
    var farmGroup: String
    var jenericIDs: String?
    
    var description: RemedyDescription?
    
    // MARK: Database keys
    struct Keys {
        static let id           = "id"
        static let title        = "title"
        static let titleFull    = "title_big"
        static let substance    = "substance"
        static let manufactured = "manufactured"
        static let type         = "class"
        static let farmType     = "farm_utics_action_short"
        static let farmGroup    = "farm_group"
        static let description  = "description"
        static let jenericIDs   = "jeneric_id"
    }

    // MARK: Fluent Serialization
    
    /// Initializes the Post from the
    /// database row
    init(row: Row) throws {
        title = try row.get(Remedy.Keys.title)
        titleFull = try row.get(Remedy.Keys.titleFull)
        substance = try row.get(Remedy.Keys.substance)
        manufactured = try row.get(Remedy.Keys.manufactured)
        type = try row.get(Remedy.Keys.type)
        farmType = try row.get(Remedy.Keys.farmType)
        farmGroup = try row.get(Remedy.Keys.farmGroup)
        jenericIDs = try row.get(Remedy.Keys.jenericIDs)
        let id: Int = try row.get(Remedy.Keys.id)
        description = try RemedyDescription.find(id) ?? nil
    }
    
    // Serializes the Remedy to the database
    func makeRow() throws -> Row {
        var row = Row()
        try row.set(Remedy.Keys.title, title)
        try row.set(Remedy.Keys.titleFull, titleFull)
        try row.set(Remedy.Keys.substance, substance)
        try row.set(Remedy.Keys.manufactured, manufactured)
        try row.set(Remedy.Keys.type, type)
        try row.set(Remedy.Keys.farmType, farmType)
        try row.set(Remedy.Keys.farmGroup, farmGroup)
        try row.set(Remedy.Keys.jenericIDs, jenericIDs)
        if let descriptions = self.description {
            try row.set(Remedy.Keys.description, descriptions.makeJSON())
        }
        return row
    }
}

// MARK: JSON

// How the model converts from / to JSON.
// For example when:
//     - Creating a new Remedy (POST /remedy)
//     - Fetching a Remedy (GET /remedy, GET /remedy/:id)
//
extension Remedy: JSONConvertible {
    convenience init(json: JSON) throws {
        fatalError("Only get Remedyes from database, not setup")
    }
    
    func makeJSON() throws -> JSON {
        var json = JSON()
        try json.set(Remedy.Keys.id, id)
        try json.set(Remedy.Keys.title, title)
        try json.set(Remedy.Keys.titleFull, titleFull)
        try json.set(Remedy.Keys.substance, substance)
        try json.set(Remedy.Keys.manufactured, manufactured)
        try json.set(Remedy.Keys.type, type)
        try json.set(Remedy.Keys.farmType, farmType)
        try json.set(Remedy.Keys.farmGroup, farmGroup)
        try json.set(Remedy.Keys.jenericIDs, jenericIDs)
        if let descriptions = self.description {
            try json.set(Remedy.Keys.description, descriptions)
        }
        return json
    }
}

// MARK: Fluent Preparation

extension Remedy: Preparation {
    /// Prepares a table/collection in the database
    /// for storing Remedyes
    static func prepare(_ database: Database) throws {
        try database.create(self) { builder in
            builder.id()
            builder.string(Remedy.Keys.title)
            builder.string(Remedy.Keys.titleFull)
            builder.string(Remedy.Keys.substance)
            builder.string(Remedy.Keys.manufactured)
            builder.string(Remedy.Keys.type)
            builder.string(Remedy.Keys.farmType)
            builder.foreignId(for: RemedyDescription.self, optional: true, unique: true, foreignIdKey: "id", foreignKeyName: "id")
            builder.string(Remedy.Keys.jenericIDs)
            /////////
            //builder.foreignId(for: RemedyFavorite.self, optional: true, unique: false, foreignIdKey: "remedy_id", foreignKeyName: "remedy_id")
        }
    }
    
    /// Undoes what was done in `prepare`
    static func revert(_ database: Database) throws {
        try database.delete(self)
    }
}

// MARK: HTTP

// This allows Remedy models to be returned
// directly in route closures
extension Remedy: ResponseRepresentable { }

extension Remedy {
    var favorites: Children<Remedy, RemedyFavorite> {
        return children()
    }
}

//MARK: Query

extension Query {
    
    @discardableResult
    public func randomChunkQuery(count: Int, field: String) throws -> Query<E> {
        let entityClass = E.self
        let allCount = try entityClass.count()
        let indexes = (1...count).map{_ in arc4random_uniform(UInt32(allCount - 1)) + 1 }
        try self.filter(field, in: indexes)
        return self
    }
}
