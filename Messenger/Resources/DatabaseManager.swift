//
//  DatabaseManager.swift
//  Messenger
//
//  Created by Ryan Woods on 9/30/21.
//

import Foundation
import FirebaseDatabase

final class DatabaseManager{
    
    static let shared = DatabaseManager()
    
    private let database = Database.database().reference()
}

// MARK: -Account Management

extension DatabaseManager {
    
    
    public func userExists(with email: String, completion: @escaping ((Bool) -> Void)) {
        
        database.child(email).observeSingleEvent(of: .value, with: { snapshot in
            guard snapshot.value as? String != nil else {
                completion(false)
                return
            }
            
            completion(true)
        })
        
    }
    
    /// Inserts a user to database
    public func insertUser(with user: ChatAuppUser) {
        database.child(user.emailAddress).setValue([
            "first_name": user.firstName,
            "last_name": user.lastName
        ])
    }
}

struct ChatAuppUser {
    let firstName: String
    let lastName: String
    let emailAddress: String
    //let profilePicture: String
}
