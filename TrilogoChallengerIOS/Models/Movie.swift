//
//  Movie.swift
//  TrilogoChallengerIOS
//
//  Created by Trilogo Tecnologia on 25/04/21.
//
import Foundation

struct ResponseOfMovies: Decodable {
    let results: [Movie]
}

struct Movie: Decodable {
    let id: Int
    let title: String
    let poster_path: String?
    let overview: String
    
    var posterURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(poster_path ?? "")")!
    }
}
