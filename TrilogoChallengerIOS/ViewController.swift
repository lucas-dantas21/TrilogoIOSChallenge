//
//  ViewController.swift
//  TrilogoChallengerIOS
//
//  Created by Trilogo Tecnologia on 25/04/21.
//

import UIKit

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var results = [Movie]()
    let tableView: UITableView = {
        let table = UITableView()
        table.register(CustomCell.self, forCellReuseIdentifier: "cell")
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUrl()
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView )// Do any additional setup after loading the view.
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
        if let data = try? Data(contentsOf: results[indexPath.row].posterURL){
            cell.imagePoster.image = UIImage(data: data)
        }
        cell.movieTitleLabel.text = results[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dt = DetailsViewController(movie: results[indexPath.row])
        self.navigationController?.pushViewController(dt, animated: true)
    }
    
    func setupUrl() {
        if let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=c2e78b4a8c14e65dd6e27504e6df95ad&language=en-US&page=1") {
            URLSession.shared.dataTask(with: url){ data, response, error in
                if let data = data {
                    do {
                        let res = try JSONDecoder().decode(ResponseOfMovies.self, from: data)
                        self.results.append(contentsOf: res.results)
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                        print(self.results)
                    } catch let error {
                        print(error)
                    }
                }
            }.resume()
        }
    }

}
