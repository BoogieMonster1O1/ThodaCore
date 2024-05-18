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

    @Parent(key: "user_id")
    var creator: RegisteredUser

    @Field(key: "title")
    var title: String

    @Field(key: "content")
    var content: String

    @Field(key: "isFoundItem")
    var isFoundItem: Bool

    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?

    @Timestamp(key: "deleted_at", on: .delete)
    var deletedAt: Date?

    @Timestamp(key: "closed_at", on: .none)
    var closedAt: Date?

    @Enum(key: "itemType")
    var itemType: LostItemType

    @Field(key: "imageUrl")
    var imageUrl: String?
}

enum LostItemType: String, Content {
    case idCard
    case earphones
    case calculator
    case other
}
