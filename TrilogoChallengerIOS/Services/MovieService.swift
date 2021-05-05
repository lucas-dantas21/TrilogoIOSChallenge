//
//  movieService.swift
//  TrilogoChallengerIOS
//
//  Created by Trilogo Tecnologia on 04/05/21.
//

import Foundation

class MovieService {
    let api_key = "c2e78b4a8c14e65dd6e27504e6df95ad"
    let baseAPIUrl = "https://api.themoviedb.org/3/movie/now_playing?"
    let language = "pt-BR"
    let urlSession = URLSession.shared
    
    
    func setupURL(page : Int, completion: @escaping(ResponseOfMovies) -> Void ) {
        if let url = URL(string: "\(baseAPIUrl)api_key=\(api_key)&language=\(language)&page=\(page)") {
            urlSession.dataTask(with: url){ data, response, error in
                if let data = data {
                    do {
                        let res = try JSONDecoder().decode(ResponseOfMovies.self, from: data)
                        completion(res)
                    }
                    
                    catch let error {
                        print(error)
                    }
                }
                
            }.resume()
        }
    }

    
    
}
