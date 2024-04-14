//
//  Post.swift
//
//
//  Created by Shrish Deshpande on 05/01/24.
//

import Vapor
import Fluent
import Foundation

final class Post: Model, Content {
    public static let schema = "posts"
    
    @ID(custom: "id", generatedBy: .user)
    var id: String?
    
    @Parent(key: "user_id")
    var creator: RegisteredUser
    
    @Field(key: "content")
    var content: String
    
    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?
    
    @Timestamp(key: "deleted_at", on: .delete)
    var deletedAt: Date?

    @OptionalParent(key: "reply_id")
    var reply: Post?
    
    @Siblings(through: LikedPost.self, from: \.$post, to: \.$user)
    var likes: [RegisteredUser]

    @Children(for: \.$reply)
    var replies: [Post]
    
    init() {
    }
    
    // TODO: attachments (media), comments enabled, edited
    init(id: String, userId: Int, content: String) {
        self.id = id
        self.$creator.id = userId
        self.content = content
    }
    
    convenience init(userId: Int, content: String) {
        self.init(id: generateId(content), userId: userId, content: content)
    }
}

func generateId(_ content: String) -> String {
    let characters = "abcdefghijklmnopqrstuvwxyz0123456789"
    var postId = ""
    let timestamp = String(Int(Date().timeIntervalSince1970), radix: 36)
    postId += timestamp
    
    for _ in 0 ..< 12 - postId.count {
        let randomIndex = Int.random(in: 0...characters.count)
        postId.insert(characters[characters.index(characters.startIndex, offsetBy: randomIndex)], at: content.startIndex)
    }

    return postId
}
