//
//  User.swift
//  Constrains
//
//  Created by Eric Rojas Pech on 26/11/23.
//

import Foundation
struct UserResult : Decodable{
    let results: [User]
    
}

struct User: Decodable{
    let name: Name
    let email: String
    let dob: Dob
    let phone: String
    let nat: String
    let location: Location
    let login: Login
    let picture: Picture
    
}

struct Name: Decodable{
    var title: String
    var first: String
    var last: String
}

struct Dob: Decodable{
    var age: Int
}

struct Login: Decodable{
    var username: String
    var password: String
}

struct Location: Decodable{
    var city: String
    var state: String
}

struct Picture: Decodable{
    var large: String
}
