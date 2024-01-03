//
//  RegisteredUser.swift
//
//
//  Created by Shrish Deshpande on 08/12/23.
//

import Vapor
import Fluent

public final class RegisteredUser: Model, Content {
    public static let schema = "registeredUsers"

    @ID(custom: "id", generatedBy: .user)
    public var id: String?

    @Field(key: "name")
    var name: String

    @Field(key: "phone")
    var phone: String

    @Field(key: "email")
    var email: String
    
    @OptionalField(key: "personal_email")
    var personalEmail: String?

    @Field(key: "branch")
    var branch: String

    @Field(key: "gender")
    var gender: String
    
    @OptionalField(key: "pronouns")
    var pronouns: String?
    
    @Timestamp(key: "date_registered", on: .create)
    var dateRegistered: Date?
    
    @OptionalField(key: "bio")
    var bio: String?
    
    @Field(key: "intake_year")
    var intakeYear: Int
    
    @Field(key: "reg_no")
    var regNo: Int?

    public init() { }

    public init(id: String, name: String, phone: String, email: String, personalEmail: String? = nil, branch: String, gender: String, pronouns: String? = nil, bio: String? = nil, intakeYear: Int, regNo: Int? = nil) {
        self.id = id
        self.name = name
        self.phone = phone
        self.email = email
        self.personalEmail = personalEmail
        self.branch = branch
        self.gender = gender
        self.pronouns = pronouns
        self.bio = bio
        self.intakeYear = intakeYear
        self.regNo = regNo
    }
}
