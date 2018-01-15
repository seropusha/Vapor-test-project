//
//  RemedyDescription.swift
//  TESTAPIPackageDescription
//
//  Created by Sergey Navka on 11/20/17.
//

import FluentProvider
import HTTP

final class RemedyDescription: Model {
    let storage = Storage()
    
    // MARK: Properties
    var useDuringPregnancy: String?
    var contraindications: String?
    var storageConditions: String?
    var indications: String?
    var drugInteractions: String?
    var dosing: String?
    var bbd: String?
    var pharmacokinetics: String?
    var precautions: String?
    var pharmacologyActionDescription: String?
    var sideEffects: String?
    var useInImpairedRenalFunction: String?
    var releaseForm: String?
    var specialCases: String?
    var cautions: String?
    var pharmacodynamics: String?
    var drugOverdose: String?
    
    // MARK: Database keys
    struct Keys {
        static let id                               = "id"
        static let useDuringPregnancy               = "use-during-pregnancy"
        static let contraindications                = "contraindications"
        static let storageConditions                = "storage-conditions"
        static let indications                      = "indications"
        static let drugInteractions                 = "drug-interactions"
        static let dosing                           = "dosing"
        static let bbd                              = "bbd"
        static let pharmacokinetics                 = "pharmacokinetics"
        static let precautions                      = "precautions"
        static let pharmacologyActionDescription    = "pharmacologyActionDescription"
        static let sideEffects                      = "side-effects"
        static let useInImpairedRenalFunction       = "use-in-impaired-renal-function"
        static let releaseForm                      = "release-form"
        static let specialCases                     = "special-cases"
        static let cautions                         = "cautions"
        static let pharmacodynamics                 = "pharmacodynamics"
        static let drugOverdose                     = "drug-overdose"
    }
    
    // MARK: Fluent Serialization
    
    /// Initializes the RemedyDescription from the
    /// database row
    init(row: Row) throws {
        useDuringPregnancy              = try row.get(RemedyDescription.Keys.useDuringPregnancy)
        contraindications               = try row.get(RemedyDescription.Keys.contraindications)
        storageConditions               = try row.get(RemedyDescription.Keys.storageConditions)
        indications                     = try row.get(RemedyDescription.Keys.indications)
        drugInteractions                = try row.get(RemedyDescription.Keys.drugInteractions)
        dosing                          = try row.get(RemedyDescription.Keys.dosing)
        bbd                             = try row.get(RemedyDescription.Keys.bbd)
        pharmacokinetics                = try row.get(RemedyDescription.Keys.pharmacokinetics)
        precautions                     = try row.get(RemedyDescription.Keys.precautions)
        pharmacologyActionDescription   = try row.get(RemedyDescription.Keys.pharmacologyActionDescription)
        sideEffects                     = try row.get(RemedyDescription.Keys.sideEffects)
        useInImpairedRenalFunction      = try row.get(RemedyDescription.Keys.useInImpairedRenalFunction)
        releaseForm                     = try row.get(RemedyDescription.Keys.releaseForm)
        specialCases                    = try row.get(RemedyDescription.Keys.specialCases)
        cautions                        = try row.get(RemedyDescription.Keys.cautions)
        pharmacodynamics                = try row.get(RemedyDescription.Keys.pharmacodynamics)
        drugOverdose                    = try row.get(RemedyDescription.Keys.drugOverdose)
    }

    // Serializes the RemedyDescription to the database
    func makeRow() throws -> Row {
        var row = Row()
        try row.set(RemedyDescription.Keys.useDuringPregnancy, useDuringPregnancy)
        try row.set(RemedyDescription.Keys.contraindications, contraindications)
        try row.set(RemedyDescription.Keys.storageConditions, storageConditions)
        try row.set(RemedyDescription.Keys.indications, indications)
        try row.set(RemedyDescription.Keys.drugInteractions, drugInteractions)
        try row.set(RemedyDescription.Keys.dosing, dosing)
        try row.set(RemedyDescription.Keys.bbd, bbd)
        try row.set(RemedyDescription.Keys.pharmacokinetics, pharmacokinetics)
        try row.set(RemedyDescription.Keys.precautions, precautions)
        try row.set(RemedyDescription.Keys.pharmacologyActionDescription, pharmacologyActionDescription)
        try row.set(RemedyDescription.Keys.sideEffects, sideEffects)
        try row.set(RemedyDescription.Keys.useInImpairedRenalFunction, useInImpairedRenalFunction)
        try row.set(RemedyDescription.Keys.releaseForm, releaseForm)
        try row.set(RemedyDescription.Keys.specialCases, specialCases)
        try row.set(RemedyDescription.Keys.cautions, cautions)
        try row.set(RemedyDescription.Keys.pharmacodynamics, pharmacodynamics)
        try row.set(RemedyDescription.Keys.drugOverdose, drugOverdose)
        return row
    }
}

// MARK: JSON

// How the model converts from / to JSON.
//
extension RemedyDescription: JSONConvertible {
    convenience init(json: JSON) throws {
        fatalError("Only get Remedyes from database, not setup")
    }
    
    func makeJSON() throws -> JSON {
        var json = JSON()
        try json.updatev(RemedyDescription.Keys.useDuringPregnancy, useDuringPregnancy)
        try json.update(RemedyDescription.Keys.contraindications, contraindications)
        try json.update(RemedyDescription.Keys.storageConditions, storageConditions)
        try json.update(RemedyDescription.Keys.indications, indications)
        try json.update(RemedyDescription.Keys.drugInteractions, drugInteractions)
        try json.update(RemedyDescription.Keys.dosing, dosing)
        try json.update(RemedyDescription.Keys.bbd, bbd)
        try json.update(RemedyDescription.Keys.pharmacokinetics, pharmacokinetics)
        try json.update(RemedyDescription.Keys.precautions, precautions)
        try json.update(RemedyDescription.Keys.pharmacologyActionDescription, pharmacologyActionDescription)
        try json.update(RemedyDescription.Keys.sideEffects, sideEffects)
        try json.update(RemedyDescription.Keys.useInImpairedRenalFunction, useInImpairedRenalFunction)
        try json.update(RemedyDescription.Keys.releaseForm, releaseForm)
        try json.update(RemedyDescription.Keys.specialCases, specialCases)
        try json.update(RemedyDescription.Keys.cautions, cautions)
        try json.update(RemedyDescription.Keys.pharmacodynamics, pharmacodynamics)
        try json.update(RemedyDescription.Keys.drugOverdose, drugOverdose)
        return json
    }
}

// MARK: Fluent Preparation

extension RemedyDescription: Preparation {
    /// Prepares a table/collection in the database
    /// for storing RemedyDescrptions
    static func prepare(_ database: Database) throws {
        try database.create(self) { builder in
           builder.id()
           builder.string(RemedyDescription.Keys.useDuringPregnancy)
           builder.string(RemedyDescription.Keys.contraindications)
           builder.string(RemedyDescription.Keys.storageConditions)
           builder.string(RemedyDescription.Keys.indications)
           builder.string(RemedyDescription.Keys.drugInteractions)
           builder.string(RemedyDescription.Keys.dosing)
           builder.string(RemedyDescription.Keys.bbd)
           builder.string(RemedyDescription.Keys.pharmacokinetics)
           builder.string(RemedyDescription.Keys.precautions)
           builder.string(RemedyDescription.Keys.pharmacologyActionDescription)
           builder.string(RemedyDescription.Keys.sideEffects)
           builder.string(RemedyDescription.Keys.useInImpairedRenalFunction)
           builder.string(RemedyDescription.Keys.releaseForm)
           builder.string(RemedyDescription.Keys.specialCases)
           builder.string(RemedyDescription.Keys.cautions)
           builder.string(RemedyDescription.Keys.pharmacodynamics)
           builder.string(RemedyDescription.Keys.drugOverdose)
           builder.foreignId(for: Remedy.self, optional: false, unique: true, foreignIdKey: "id", foreignKeyName: "id")
        }
    }
    
    /// Undoes what was done in `prepare`
    static func revert(_ database: Database) throws {
        try database.delete(self)
    }
}

// MARK: HTTP

// This allows RemedyDescription models to be returned
// directly in route closures
extension RemedyDescription: ResponseRepresentable { }

extension StructuredDataWrapper {
    mutating func update(_ path: String, _ value: String?) throws {
        if let string = value, string != "null" {
            try set(path, any)
        }
    }
}
