//
//  MovieService.swift
//  TrilogoChallengerIOS
//
//  Created by Trilogo Tecnologia on 25/04/21.
//

import Foundation

class MovieAPI {
    private init(){}
    private let api_key = "c2e78b4a8c14e65dd6e27504e6df95ad"
    private let baseAPIUrl = "https://api.themoviedb.org/3/movie/now_playing?"
    private let language = "pt-BR"
    private let urlSession = URLSession.shared
    
    func setupUrl(page : Int){
        if let url = URL(string: "\(baseAPIUrl)api_key=\(api_key)&language=\(language)&page=\(page)"){
            URLSession.shared.dataTask(with: url){ data, response, error in
                if let data = data {
                    do {
                        let res = try JSONDecoder().decode(ResponseOfMovies.self, from: data)
                    } catch let error {
                        print(error)
                    }
                }

            }.resume()
        }
    }
}

