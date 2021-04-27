//
//  DetailsViewController.swift
//  TrilogoChallengerIOS
//
//  Created by Trilogo Tecnologia on 26/04/21.
//

import UIKit

class DetailsViewController: UIViewController {
    
    let movie: Movie
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .purple
    }
    
    init(movie: Movie) {
        self.movie = movie
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
