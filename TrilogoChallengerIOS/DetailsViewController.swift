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
        self.setupDescritionTextView()
        self.setupConstraints()
        self.setupSynopsisLabel()
        self.setupImagePoster()
        self.view.backgroundColor = UIColor(red: 6 / 255, green: 9 / 255, blue: 87 / 255, alpha: 1.0)
    }
    
    init(movie: Movie) {
        self.movie = movie
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var synopsislabel : UILabel = {
        var synopsisLabel = UILabel()
        synopsisLabel.translatesAutoresizingMaskIntoConstraints = false
        return synopsisLabel
    }()
    
    private func setupSynopsisLabel(){
        synopsislabel.text = "Sinopse"
        synopsislabel.textColor = .white
        synopsislabel.font = UIFont.boldSystemFont(ofSize: 22)
    }
    
    lazy var posterImageView : UIImageView = { [unowned self] in
        var posterImageView = UIImageView()
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        return posterImageView
    }()
    
    private func setupImagePoster(){
        if let data = try? Data(contentsOf: self.movie.posterURL){
            posterImageView.image = UIImage(data:data)
        }
    }
    
    var descriptionTextView : UITextView = {
        var descriptionTextView = UITextView()
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        descriptionTextView.isEditable = false
        return descriptionTextView
    }()
    
    private func setupDescritionTextView(){
        descriptionTextView.text = movie.overview
        descriptionTextView.textColor = .white
        descriptionTextView.font = UIFont.boldSystemFont(ofSize: 18)
        descriptionTextView.backgroundColor = .none
        
    }
    
    private func setupConstraints() {
        self.view.addSubview(descriptionTextView)
        self.view.addSubview(synopsislabel)
        self.view.addSubview(posterImageView)
        NSLayoutConstraint.activate([
            self.posterImageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.posterImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.posterImageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.posterImageView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.45),
            
            self.synopsislabel.topAnchor.constraint(equalTo: self.posterImageView.bottomAnchor, constant: 10),
            
            self.descriptionTextView.topAnchor.constraint(equalTo: self.synopsislabel.bottomAnchor, constant: 10),
            self.descriptionTextView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            self.descriptionTextView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 5),
            self.descriptionTextView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -5)
            
        ])
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
