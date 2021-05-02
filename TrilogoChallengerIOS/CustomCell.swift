//
//  CustomCell.swift
//  TrilogoChallengerIOS
//
//  Created by Trilogo Tecnologia on 25/04/21.
//

import UIKit

class CustomCell: UITableViewCell {
    override func willMove(toSuperview newSuperview: UIView?) {
       
        setupContrainst()
        setupCell()
        accessoryView = starButtom
    }
    
    let starButtom : UIButton = {
        let starButtom = UIButton(type: .system)
        starButtom.setTitle("favoritar", for: .normal)
        starButtom.setImage(#imageLiteral(resourceName: "coracao"), for: .normal)
        starButtom.tintColor = .red
        
    
        starButtom.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        return starButtom
    }()
    
 
    var movieTitleLabel: UILabel = {
        let movieTitleLabel = UILabel()
        movieTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        return movieTitleLabel
    }()
    
    var releaseDataLabel: UILabel = {
        let releaseDataLabel = UILabel()
        releaseDataLabel.translatesAutoresizingMaskIntoConstraints = false
        return releaseDataLabel
    }()
    
    var imagePoster: UIImageView = {
        let imagePoster = UIImageView()
        imagePoster.translatesAutoresizingMaskIntoConstraints = false
        return imagePoster
    }()
    
   
    func setupCell(){
        self.backgroundColor = UIColor(red: 73 / 255, green: 13 / 255, blue: 117 / 255, alpha: 1.0)
        imagePoster.tintColor = .green
        
        movieTitleLabel.textColor = UIColor.white
        movieTitleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        
        releaseDataLabel.textColor = UIColor.white
        releaseDataLabel.font = UIFont.boldSystemFont(ofSize: 18)
    }
    
    func setupContrainst(){
        self.addSubview(movieTitleLabel)
        self.addSubview(imagePoster)
        self.addSubview(releaseDataLabel)
        NSLayoutConstraint.activate([
            imagePoster.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            imagePoster.widthAnchor.constraint(equalToConstant: 120.0),
            imagePoster.heightAnchor.constraint(equalToConstant: 140.0),
            imagePoster.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            
            movieTitleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            movieTitleLabel.leadingAnchor.constraint(equalTo: self.imagePoster.trailingAnchor, constant: 10),
            movieTitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 5),
            
            releaseDataLabel.topAnchor.constraint(equalTo:  movieTitleLabel.bottomAnchor, constant: 10),
            releaseDataLabel.leadingAnchor.constraint(equalTo: self.imagePoster.trailingAnchor, constant: 10),
            releaseDataLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 5),
            
            self.bottomAnchor.constraint(equalTo: self.imagePoster.bottomAnchor, constant: 10)
        ])
    }
}
