//
//  MovieListViewController.swift
//  MovieDbList
//
//  Created by webwerks on 03/11/20.
//

import UIKit

class MovieListViewController: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak var tableview: UITableView!
    
    // MARK: Class Properties
    let cellIdentifier = "MovieListTableViewCell"
    var viewModel = MovieViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableview()
        setUpNavigationBar()
        bindViewModel()
        getMovies()
    }
    // MARK: Init MovieListViewController
    static func loadFromNib() -> MovieListViewController{
        return MovieListViewController(nibName: "MovieListViewController",
                                       bundle: nil)
    }
}

// MARK: Custom methods
extension MovieListViewController {
    private func setUpNavigationBar(){
        self.title = "Movie List"
        let button = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(buttonSearchClicked))
        navigationItem.rightBarButtonItem = button
    }
    
    private func setupTableview() {
        tableview.delegate = self
        tableview.dataSource = self
        tableview.estimatedRowHeight = UITableView.automaticDimension
        tableview.backgroundColor = UIColor.white
        tableview.separatorStyle = .none
        tableview.register(UINib(nibName: cellIdentifier,
                                 bundle: nil ),
                           forCellReuseIdentifier: cellIdentifier)
    }
    
    private func bindViewModel(){
        self.viewModel.bindMovieViewModelToController = {
            self.removeSpinner()
            self.tableview.reloadData()
        }
        self.viewModel.onErrorHandling = {error in
            self.removeSpinner()
            CommonMethods.showToast(messsage: error?.description ?? "", view: self.view)
        }
    }
    
    private func getMovies() {
        self.showSpinner(onView: self.view)
        viewModel.loadNowPlaying()
    }
    // Goto SearchMovieViewController
    @objc func buttonSearchClicked() {
        let searchVc = SearchMovieViewController.loadFromNib(movieViewModel: self.viewModel)
        self.navigationController?.pushViewController(searchVc, animated: true)
    }
}

//MARK: Button actions
extension MovieListViewController{
    @objc func buttonBookClicked(_ sender: UIButton){
        let movie = viewModel.moviesArray[sender.tag]
        let detailVc = MovieDetailViewController.loadFromNib(movie: movie)
        self.navigationController?.pushViewController(detailVc, animated: true)
    }
}

// MARK: Tableview delegate and data source methods
extension MovieListViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier,
                                                 for: indexPath) as! MovieListTableViewCell
        cell.selectionStyle = .none
        cell.movieObj = viewModel.moviesArray[indexPath.row]
        cell.buttonBook.tag = indexPath.row
        cell.buttonBook.addTarget(self, action: #selector(buttonBookClicked(_:)), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        //Load more movies using paginaiton
        if viewModel.canLoadNow(index: indexPath.row){
            viewModel.loadNowPlaying()
        }
    }
}
