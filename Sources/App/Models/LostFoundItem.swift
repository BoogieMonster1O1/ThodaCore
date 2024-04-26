//
//  LostFoundEntry.swift
//
//
//  Created by Shrish Deshpande on 26/04/24.
//

import Fluent
import Vapor

final class LostFoundItem: Model, Content {
    public static let schema: String = "lostFoundItems"

    @ID(custom: "id", generatedBy: .user)
    var id: String?
}
