//
//  CustomCell.swift
//  TrilogoChallengerIOS
//
//  Created by Trilogo Tecnologia on 25/04/21.
//

import UIKit

protocol customCellDelegate: class {
    func changeStatusOffavoriteMovieButtom(movie : Movie)
}

class CustomCell: UITableViewCell {
    weak var delegate : customCellDelegate?
    var movie : Movie?
    override func willMove(toSuperview newSuperview: UIView?) {
        
        setupContrainst()
        setupCell()
        accessoryView = favoriteMovieButtom
    }
    
    let favoriteMovieButtom : UIButton = {
        let favoriteMovieButtom = UIButton(type: .system)
        favoriteMovieButtom.setTitle("favoritar", for: .normal)
        favoriteMovieButtom.setImage(UIImage.init(imageLiteralResourceName:"coracao"), for: .normal)
        favoriteMovieButtom.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        
        return favoriteMovieButtom
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
        self.backgroundColor = UIColor(red: 137 / 255, green: 182 / 255, blue: 231 / 255, alpha: 1.0)
        imagePoster.tintColor = .green
        
        movieTitleLabel.textColor = UIColor.white
        movieTitleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        
        releaseDataLabel.textColor = UIColor.white
        releaseDataLabel.font = UIFont.boldSystemFont(ofSize: 18)
        
        favoriteMovieButtom.addTarget(self, action: #selector(favoriteMovieButtomAction), for: .touchUpInside)
    }
    
    func setupContrainst(){
        self.addSubview(movieTitleLabel)
        self.addSubview(imagePoster)
        self.addSubview(releaseDataLabel)
        NSLayoutConstraint.activate([
            imagePoster.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            imagePoster.widthAnchor.constraint(equalToConstant: 120.0),
            imagePoster.heightAnchor.constraint(equalToConstant: 140.0),
            imagePoster.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 5),
            
            movieTitleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            movieTitleLabel.leadingAnchor.constraint(equalTo: self.imagePoster.trailingAnchor, constant: 10),
            movieTitleLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -5),
            
            releaseDataLabel.topAnchor.constraint(equalTo:  movieTitleLabel.bottomAnchor, constant: 10),
            releaseDataLabel.leadingAnchor.constraint(equalTo: self.imagePoster.trailingAnchor, constant: 10),
            releaseDataLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 5),
            
            self.bottomAnchor.constraint(equalTo: self.imagePoster.bottomAnchor, constant: 10)
        ])
    }
    
    @objc func favoriteMovieButtomAction(){
        guard let movie = self.movie else { return }
        self.delegate?.changeStatusOffavoriteMovieButtom(movie: movie)
    }
}
