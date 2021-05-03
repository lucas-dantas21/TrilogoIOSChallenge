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
        self.setupTitleLabel()
        self.setupImagePoster()
        self.view.backgroundColor = UIColor(red: 15 / 255, green: 15 / 255, blue: 5 / 255, alpha: 1.0)
    }
    
    init(movie: Movie) {
        self.movie = movie
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var TitleLabel : UILabel = {
        var synopsisLabel = UILabel()
        synopsisLabel.translatesAutoresizingMaskIntoConstraints = false
        return synopsisLabel
    }()
    
    private func setupTitleLabel(){
        TitleLabel.text = movie.title
        TitleLabel.textColor = .white
        TitleLabel.font = UIFont.boldSystemFont(ofSize: 22)
    }
    
    lazy var posterImageView : UIImageView = { [unowned self] in
        var posterImageView = UIImageView()
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        return posterImageView
    }()
    
    private func setupImagePoster(){
        if let data = try? Data(contentsOf: self.movie.posterURL){
            posterImageView.image = UIImage(data:data)
        } else {
            posterImageView.image = UIImage.init(imageLiteralResourceName: "SemImagem")
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
        self.view.addSubview(TitleLabel)
        self.view.addSubview(posterImageView)
        NSLayoutConstraint.activate([
            self.posterImageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.posterImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.posterImageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.posterImageView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.45),
            
            self.TitleLabel.topAnchor.constraint(equalTo: self.posterImageView.bottomAnchor, constant: 10),
            self.TitleLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            self.TitleLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            
            self.descriptionTextView.topAnchor.constraint(equalTo: self.TitleLabel.bottomAnchor, constant: 5),
            self.descriptionTextView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -1),
            self.descriptionTextView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 5),
            self.descriptionTextView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 5)
            
        ])
    }
}
