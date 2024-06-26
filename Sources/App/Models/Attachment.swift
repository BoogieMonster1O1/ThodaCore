//
//  Attachment.swift
//
//
//  Created by Shrish Deshpande on 09/06/24.
//

import Vapor
import Fluent

final class Attachment: Model {
    public static let schema = "attachments"

    @ID(custom: "id", generatedBy: .user)
    var id: String?

    @Field(key: "parent_id")
    var parentId: String?

    @Field(key: "hash")
    var hash: String

    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?

    public init() {
    }

    public init(parent: String, hash: String) {
        self.id = Snowflake.init().stringValue
        self.parentId = parent
        self.hash = hash
    }
}
