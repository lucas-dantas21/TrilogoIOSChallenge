//
//  ViewController.swift
//  TrilogoChallengerIOS
//
//  Created by Trilogo Tecnologia on 25/04/21.
//

import UIKit

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    //Variables
    var page = 1
    var totalPages = 1
    var ids = [Int]()
    var results = [Movie]()
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
    
    // tableSetup
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CustomCell else {
            return UITableViewCell()
        }
        if let data = try? Data(contentsOf: results[indexPath.row].posterURL){
            cell.imagePoster.image = UIImage(data: data)
        }else {
            cell.imagePoster.image = UIImage.init(imageLiteralResourceName: "SemImagem")
        }
        cell.imagePoster.tintColor = .orange
        cell.delegate = self
        cell.movie = results[indexPath.row]
        cell.movieTitleLabel.text = results[indexPath.row].title
        cell.releaseDataLabel.text = "Estreia : \(results[indexPath.row].release_date)"
        if ids.contains(results[indexPath.row].id) {
            cell.favoriteButtom.tintColor = .blue
        }else{
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
        let api_key = "c2e78b4a8c14e65dd6e27504e6df95ad"
        let baseAPIUrl = "https://api.themoviedb.org/3/movie/now_playing?"
        let language = "pt-BR"
        let urlSession = URLSession.shared
        
        https://api.themoviedb.org/3/movie/now_playing?api_key=c2e78b4a8c14e65dd6e27504e6df95ad&language="pt-BR"&page=1
        
        if let url = URL(string: "\(baseAPIUrl)api_key=\(api_key)&language=\(language)&page=\(page)") {
            urlSession.dataTask(with: url){ data, response, error in
                if let data = data {
                    do {
                        let res = try JSONDecoder().decode(ResponseOfMovies.self, from: data)
                        self.results.append(contentsOf: res.results)
                        self.totalPages = res.total_pages
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    } catch let error {
                        print(error)
                    }
                }
                
            }.resume()
        }
        setupTitle()
    }
    
    // ButtomsBarSetup
    
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
        if self.page <= 0 {
            //mostrar toast dizendo "você está na primeira página, experimente ir adiante"
        }
        setupUrl(page: self.page)
        setupTitle()
    }
    
}

// Extensions

extension MainViewController : customCellDelegate {
    
    func changeStatusOffavoriteMovieButtom (movie: Movie) {
        guard let index = ids.firstIndex(of: movie.id)else {
            ids.append(movie.id)
            self.tableView.reloadData()
            return
        }
        ids.remove(at: index)
        self.tableView.reloadData()
    }
}
