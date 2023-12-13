//
//  SignupCodeUtil.swift
//
//
//  Created by Shrish Deshpande on 13/12/23.
//

import Crypto
import Vapor
import Redis

func generateRandomConfirmationCode() -> String {
    var randomCode = ""

    for _ in 1...6 {
        let randomDigit = Int.random(in: 0...9)
        randomCode += "\(randomDigit)"
    }

    return randomCode
}

func getOrGenerateConfirmationCode(usn: String, req: Request) async throws -> String {
    if let code = try await req.redis.get("conf_\(usn)", asJSON: String.self) {
        return code
    }
    
    let newCode = generateRandomConfirmationCode()
    let result = try await req.redis.set("conf_\(usn)", to: newCode, onCondition: .none, expiration: .seconds(600)).get()
    if result == .conditionNotMet {
        throw Abort(.serviceUnavailable, reason: "Failed to set confirmation code for \(usn)")
    }
    return newCode
}
