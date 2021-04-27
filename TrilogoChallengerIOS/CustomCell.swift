//
//  CustomCell.swift
//  TrilogoChallengerIOS
//
//  Created by Trilogo Tecnologia on 25/04/21.
//

import UIKit

class CustomCell: UITableViewCell {
    
    var movieTitleLabel: UILabel = {
        let movieTitleLabel = UILabel()
        movieTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        return movieTitleLabel
    }()
    
    var imagePoster: UIImageView = {
        let imagePoster = UIImageView()
        imagePoster.translatesAutoresizingMaskIntoConstraints = false
        imagePoster.tintColor = .green
        return imagePoster
    }()
    
    override func willMove(toSuperview newSuperview: UIView?) {
        setupContrainst()
    }
    
    func setupContrainst(){
        self.addSubview(movieTitleLabel)
        self.addSubview(imagePoster)
        NSLayoutConstraint.activate([
            imagePoster.topAnchor.constraint(equalTo: self.topAnchor),
            imagePoster.widthAnchor.constraint(equalToConstant: 200.0),
            imagePoster.heightAnchor.constraint(equalToConstant: 150.0),
            imagePoster.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            movieTitleLabel.topAnchor.constraint(equalTo: self.imagePoster.bottomAnchor, constant: 5),
            self.bottomAnchor.constraint(equalTo: self.movieTitleLabel.bottomAnchor, constant: 5)
        ])
    }
}
