//
//  UsersTableModel.swift
//  Constrains
//
//  Created by Eric Rojas Pech on 26/11/23.
//

import Foundation

class UsersTableModel{
    
    let apiController = APIController()
    
    func getUsersCount() -> Int{
        return apiController.users.count
    }

    
    func getNumberOfUsersSynchronously() -> Int {
        let apiController = APIController()
        let semaphore = DispatchSemaphore(value: 0)
        var numberOfUsers = 0
        
        apiController.getUsers { error in
            defer {
                semaphore.signal()
            }

            if let error = error {
                print("Error: \(error)")
            } else {
                numberOfUsers = apiController.users.count
            }
        }
        _ = semaphore.wait(timeout: .distantFuture)

        return numberOfUsers
    }
    
}


