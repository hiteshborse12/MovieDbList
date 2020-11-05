//
//  SearchMovieViewController.swift
//  MovieDbList
//
//  Created by webwerks on 04/11/20.
//

import UIKit

class SearchMovieViewController: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    // MARK: Class Properties
    let cellIdentifier = "SeartchTableViewCell"
    var searchMovieViewModel:SearchMovieViewModel?
    var filterMoviesArray = [MovieModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Search"
        setupTableview()
        setUpDisplay()
        bindViewModel()
        getRecentSearchMovie()
    }
    static func loadFromNib(movieViewModel:MovieViewModel?) -> SearchMovieViewController{
        let vc = SearchMovieViewController(nibName: "SearchMovieViewController",
                                      bundle: nil)
        vc.searchMovieViewModel = SearchMovieViewModel(movieViewModel: movieViewModel)
        return vc
    }
}

// MARK: Custom methods
extension SearchMovieViewController {
    
    private func setupTableview() {
        
        tableview.backgroundColor = .backgroundGrey
        tableview.delegate = self
        tableview.dataSource = self
        tableview.estimatedRowHeight = UITableView.automaticDimension
        tableview.backgroundColor = UIColor.white
        tableview.separatorStyle = .none
        tableview.register(UINib(nibName: cellIdentifier,
                                 bundle: nil ),
                           forCellReuseIdentifier: cellIdentifier)
    }
    private func getRecentSearchMovie() {
        searchMovieViewModel?.getMovieForRecentSearch()
    }
    
    private func setUpDisplay(){
        searchBar.delegate = self
        searchBar.tintColor = .backgroundGrey
        view.backgroundColor = .backgroundGrey
    }
    
    private func bindViewModel(){
        self.searchMovieViewModel?.bindSearchMovieViewModelToController = {
            self.tableview.reloadData()
        }
    }
}

// MARK: Tableview delegate and data source methods
extension SearchMovieViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return searchMovieViewModel?.numberOfSections() ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchMovieViewModel?.numberOfRows() ?? 0
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier,
                                                 for: indexPath) as! SeartchTableViewCell
        cell.selectionStyle = .none
        cell.movieObj = searchMovieViewModel?.searchMovieArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if searchMovieViewModel?.isRecentSearch ?? false {
            let header = SettingSectionHeader.loadNib()
            return header
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        if searchMovieViewModel?.isRecentSearch ?? false {
            return 50
        }
        return 0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let movie = searchMovieViewModel?.searchMovieArray[indexPath.row]{
            searchMovieViewModel?.savMovieForRecentSearch(movie: movie)
            let detailVc = MovieDetailViewController.loadFromNib(movie: movie)
            self.navigationController?.pushViewController(detailVc, animated: true)
        }
    }
}

// MARK: Search delegate methods
extension SearchMovieViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchMovieViewModel?.searchMovie(text: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
        searchMovieViewModel?.searchMovie(text: searchBar.text ?? "")
    }
}
