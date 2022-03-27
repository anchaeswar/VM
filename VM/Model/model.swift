//
//  model.swift
//  VM
//
//  Created by MunchEm on 27/03/22.
//

import Foundation

struct RoomStatus : Decodable {
    let createdAt : String
    let isOccupied : Bool
    let maxOccupancy : Int
    let id : String
}


struct People : Decodable {
    let createdAt : String
    let firstName : String
    let avatar : String
    let lastName : String
    let email : String
    let jobtitle : String
    let favouriteColor : String
    let id : String
}

