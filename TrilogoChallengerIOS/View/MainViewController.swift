//
//  ViewController.swift
//  TrilogoChallengerIOS
//
//  Created by Trilogo Tecnologia on 25/04/21.
//

import UIKit

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var page = 1
    var totalPages = 1
    var ids = [Int]()
    var results = [Movie]()
    var movieService = MovieService()
    let tableView: UITableView = {
        let table = UITableView()
        table.separatorColor = UIColor.black
        table.register(CustomCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    let alert : UIAlertController = {
        let alert = UIAlertController(title: "OPS!", message: "Não há nada além daqui", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        return alert
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUrl(page: self.page)
        setupBarButtoms()
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView )
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CustomCell else {
            return UITableViewCell()
        }
        
        if let data = try? Data(contentsOf: results[indexPath.row].posterURL) {
            cell.imagePoster.image = UIImage(data: data)
        }
        else {
            cell.imagePoster.image = UIImage.init(imageLiteralResourceName: "SemImagem")
        }
        
        cell.delegate = self
        cell.movie = results[indexPath.row]
        cell.movieTitleLabel.text = results[indexPath.row].title
        cell.releaseDataLabel.text = "Estreia : \(results[indexPath.row].release_date)"
        
        if ids.contains(results[indexPath.row].id) {
            cell.favoriteButtom.tintColor = .blue
        }
        else {
            cell.favoriteButtom.tintColor = .gray
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dt = DetailsViewController(movie: results[indexPath.row])
        self.navigationController?.pushViewController(dt, animated: true)
    }
    
    // RequestSetup
    
    func setupUrl(page : Int) {
        results.removeAll()
        movieService.setupURL(page: page) { (result) in
            self.results =  result.results
            self.totalPages = result.total_pages
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.setupTitle()
            }
        }
    }
    
    // BarSetup
    
    func setupTitle() {
        self.title = "Página \(page) de \(totalPages)"
    }
    
    func setupBarButtoms() {
        let nextButtom = UIBarButtonItem(title: "próxima", style: .plain, target: self, action: #selector(nextPage))
        let lastButtom = UIBarButtonItem(title: "anterior", style: .plain, target: self, action: #selector(lastPage))
        self.title = "Página 1"
        navigationItem.rightBarButtonItem =  nextButtom
        navigationItem.leftBarButtonItem = lastButtom
    }
    
    
    @objc func nextPage() {
        if self.page == totalPages {
            self.present(alert, animated: true)
            return
        }
        self.page = self.page + 1
        setupUrl(page: self.page )
    }
    
    @objc func lastPage() {
        if self.page == 1 {
            self.present(alert,animated: true)
            return
        }
        self.page = self.page - 1
        setupUrl(page: self.page)
    }
    
}

// Extensions

extension MainViewController : customCellDelegate {
    
    func changeStatusOffavoriteMovieButtom (movie: Movie) {
        guard let index = ids.firstIndex(of: movie.id) else {
            ids.append(movie.id)
            self.tableView.reloadData()
            return
        }
        ids.remove(at: index)
        self.tableView.reloadData()
    }
}
