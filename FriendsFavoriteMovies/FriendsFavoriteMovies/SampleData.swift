//
//  SampleData.swift
//  FriendsFavoriteMovies
//
//  Created by Julien Juret on 21/04/2024.
//

import Foundation
import SwiftData

@MainActor
class SampleData {
    static let shared = SampleData()
    
    let modelContainer: ModelContainer
    
    var context: ModelContext {
        modelContainer.mainContext
    }
    
    private init() {
        let schema = Schema([
            Movie.self,
            Friend.self
        ])
        
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
                
        do {
            modelContainer = try ModelContainer(for: schema, configurations: [modelConfiguration])
            
            insertSampleData()
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }
    
    func insertSampleData() {
        for movie in Movie.sampleData {
            context.insert(movie)
        }
        
        for friend in Friend.sampleData {
            friend.favoriteMovie = Movie.sampleData.randomElement()
            context.insert(friend)
        }
        
        do {
            try context.save()
        } catch {
            print("Sample data context failed to save.")
        }
    }
    
    var movie: Movie {
        Movie.sampleData[0]
    }
    
    var friend: Friend {
        Friend.sampleData[0]
    }
}
