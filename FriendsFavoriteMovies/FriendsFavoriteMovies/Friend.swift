//
//  Friend.swift
//  FriendsFavoriteMovies
//
//  Created by Julien Juret on 21/04/2024.
//

import Foundation
import SwiftData

@Model
final class Friend {
    var name: String
    var favoriteMovie: Movie?
    
    init(name: String) {
        self.name = name
    }
    
    static let sampleData = [
        Friend(name: "Elena"),
        Friend(name: "Graham"),
        Friend(name: "Mayuri"),
        Friend(name: "Rich"),
        Friend(name: "Rody")
    ]
}
