//
//  APIController.swift
//  Constrains
//
//  Created by Eric Rojas Pech on 26/11/23.
//

import Foundation

class APIController
{
    
    var users: [User] = []
    let baseURL = URL(string: "https://randomuser.me/api/?inc=name,email,dob,phone,nat,location,login,picture&results=20&seed=smartstc&nat=ES")!
    
    typealias CompletionHandler = (Error?) -> Void
    
    func getUsers(completion: @escaping CompletionHandler = { _ in }) {
            
            URLSession.shared.dataTask(with: baseURL) { (data, _, error) in
                if let error = error {
                    print("Error getting users: \(error)")
                    completion(error)
                    return
                }
                
                guard let data = data else {
                    print("No data returned")
                    completion(nil)
                    return
                }
                
                do {
                    let newUser = try JSONDecoder().decode(UserResult.self, from: data)
                    print(newUser)
                    self.users = newUser.results
                    completion(nil)
                } catch {
                    print("Error decoding \(error)")
                    completion(error)
                }
                
            }.resume()
    }
}
