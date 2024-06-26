//
//  Resolver+GetConfessions.swift
//
//
//  Created by Shrish Deshpande on 19/02/24.
//

import Graphiti
import Fluent
import Vapor

extension Resolver {
    func getConfessions(request: Request, arguments: PaginationArgs) async throws -> Page<Confession> {
        try await verifyAccessToken(req: request)
        return try await Confession.query(on: request.db)
            .sort(\.$id, .descending)
            .paginate(.init(page: arguments.page, per: arguments.per))
    }

    func getConfessionById(request: Request, arguments: IntIdArgs) async throws -> Confession {
        try await verifyAccessToken(req: request)
        guard let confession = try await Confession.find(arguments.id, on: request.db) else {
            throw Abort(.notFound, reason: "Confession not found")
        }
        return confession
    }

    func getLatestConfession(request: Request, arguments: NoArguments) async throws -> Confession? {
        try await verifyAccessToken(req: request)
        return try await Confession.query(on: request.db)
          .sort(\.$id, .descending)
          .first()
    }
}

