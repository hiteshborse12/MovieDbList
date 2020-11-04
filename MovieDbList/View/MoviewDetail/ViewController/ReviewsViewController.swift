//
//  ReviewsViewController.swift
//  MovieDbList
//
//  Created by webwerks on 03/11/20.
//

import UIKit

class ReviewsViewController: UIViewController {
    // MARK: IBOutlets
    @IBOutlet weak var tableview: UITableView!
    
    // MARK: Class Properties
    let cellIdentifier = "ReviewTableViewCell"
    var movieReviewViewModel : MovieReviewViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Reviews"
        setupTableview()
        bindViewModel()
        movieReviewViewModel?.loadMovieReviewAPI()
    }
    
    static func loadFromNib(movieId: Int?) -> ReviewsViewController{
        let detailObj = ReviewsViewController(nibName: "ReviewsViewController",
                                  bundle: nil)
        detailObj.movieReviewViewModel = MovieReviewViewModel(movieId: movieId)
        return detailObj
    }
}

// MARK: Custom methods
extension ReviewsViewController {
    
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
    func bindViewModel(){
        self.movieReviewViewModel?.bindMovieReviewViewModelToController = {
            self.tableview.reloadData()
        }
        self.movieReviewViewModel?.onErrorHandling = {error in
            CommonMethods.showToast(messsage: error?.description ?? "", view: self.view)
        }
    }
}

// MARK: Tableview delegate and data source methods
extension ReviewsViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieReviewViewModel?.numberOfRows() ?? 0
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier,
                                                 for: indexPath) as! ReviewTableViewCell
        cell.selectionStyle = .none
        cell.movieReviewModel = movieReviewViewModel?.moviesReviewArray[indexPath.row]
        cell.viewBottom.isHidden = true
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if movieReviewViewModel?.canLoadNow(index: indexPath.row) ?? false{
            movieReviewViewModel?.loadMovieReviewAPI()
        }
    }
}
