//
//  MovieDetailViewController.swift
//  MovieDbList
//
//  Created by webwerks on 03/11/20.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak var tableview: UITableView!
    
    //MARK: Class properties
    let reviewCellIdentifier = "ReviewTableViewCell"
    let castCellIdentifier = "CollectionsTableViewCell"
    let detailsCellIdentifier = "MovieDeatilHeaderTableViewCell"
    var similarResultCollectionsTableViewCell:CollectionsTableViewCell?
    var moviewDetailViewModel : MoviewDetailViewModel?
    var similarMovieViewModel : SimilarMovieViewModel?
    var movieCastViewModel : MovieCastViewModel?
    var movieReviewViewModel : MovieReviewViewModel?
    var taskGroup : DispatchGroup?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableview()
        setUpDisplay()
        bindViewModel()
        getMovieDetail()
    }
    
    static func loadFromNib(movie: MovieModel) -> MovieDetailViewController{
        let detailObj = MovieDetailViewController(nibName: "MovieDetailViewController",
                                                  bundle: nil)
        detailObj.moviewDetailViewModel = MoviewDetailViewModel(movie: movie)
        detailObj.similarMovieViewModel = SimilarMovieViewModel(movieId: movie.id)
        detailObj.movieCastViewModel = MovieCastViewModel(movieId: movie.id)
        detailObj.movieReviewViewModel = MovieReviewViewModel(movieId: movie.id)
        return detailObj
    }
}


// MARK: Custom methods
extension MovieDetailViewController {
    
    private func setupTableview() {
        
        tableview.backgroundColor = .backgroundGrey
        tableview.delegate = self
        tableview.dataSource = self
        tableview.estimatedRowHeight = UITableView.automaticDimension
        tableview.backgroundColor = UIColor.white
        tableview.separatorStyle = .none
        tableview.register(UINib(nibName: reviewCellIdentifier,
                                 bundle: nil ),
                           forCellReuseIdentifier: reviewCellIdentifier)
        tableview.register(UINib(nibName: castCellIdentifier,
                                 bundle: nil ),
                           forCellReuseIdentifier: castCellIdentifier)
        tableview.register(UINib(nibName: detailsCellIdentifier,
                                 bundle: nil ),
                           forCellReuseIdentifier: detailsCellIdentifier)
    }
    
    private func setUpDisplay(){
        self.title = "Movie Detail"
        view.backgroundColor = .backgroundGrey
    }
}

// MARK: Get Movie Detail Data
extension MovieDetailViewController {
    func getMovieDetail(){
        //Create DispatchGroup to execute MultiTask
        taskGroup = DispatchGroup()
        self.showSpinner(onView: self.view)
        
        taskGroup?.enter()
        moviewDetailViewModel?.loadMoviewDetail()
        
        taskGroup?.enter()
        movieCastViewModel?.loadMovieCastAPI()
        
        taskGroup?.enter()
        movieReviewViewModel?.loadMovieReviewAPI()
        
        taskGroup?.enter()
        similarMovieViewModel?.loadSimilarMovieAPI()
        
        //All tasks are done
        taskGroup?.notify(queue: .main) {
            self.removeSpinner()
            self.taskGroup = nil
        }
    }
}
// MARK: Bind View Model
extension MovieDetailViewController {
    func bindViewModel(){
        bindMoviewDetailViewModel()
        bindSimilarMovieViewModel()
        bindMovieCastViewModel()
        bindMovieReviewViewModel()
    }
    func bindMoviewDetailViewModel() {
        self.moviewDetailViewModel?.bindMoviewDetailViewModelToController = {
            self.taskGroup?.leave()
            self.tableview.reloadData()
        }
        self.moviewDetailViewModel?.onErrorHandling = {error in
            self.taskGroup?.leave()
            CommonMethods.showToast(messsage: error?.description ?? "", view: self.view)
        }
    }
    func bindSimilarMovieViewModel(){
        self.similarMovieViewModel?.bindSimilarMovieViewModelToController = {
            self.taskGroup?.leave()
            self.tableview.reloadData()
        }
        self.similarMovieViewModel?.onErrorHandling = {error in
            self.taskGroup?.leave()
        }
    }
    func bindMovieCastViewModel(){
        self.movieCastViewModel?.bindMovieCastViewModelToController = {
            self.taskGroup?.leave()
            self.tableview.reloadData()
        }
        self.movieCastViewModel?.onErrorHandling = {error in
            self.taskGroup?.leave()
        }
    }
    func bindMovieReviewViewModel(){
        self.movieReviewViewModel?.bindMovieReviewViewModelToController = {
            self.taskGroup?.leave()
            self.tableview.reloadData()
        }
        self.movieReviewViewModel?.onErrorHandling = {error in
            self.taskGroup?.leave()
        }
    }
}

// MARK: Button Actions
extension MovieDetailViewController{
    @objc func buttonViewReviewsClicked(){
        let reviewVc = ReviewsViewController.loadFromNib(movieId: moviewDetailViewModel?.movie?.id)
        self.navigationController?.pushViewController(reviewVc, animated: true)
    }
}

// MARK: Tableview delegate and data source methods
extension MovieDetailViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            if moviewDetailViewModel?.isMoviewDetail() ?? false{return 1}
            return 0
        case 1:
            if movieCastViewModel?.numberOfCasts() ?? 0 > 0{return 1}
            return 0
        case 2:
            if movieCastViewModel?.numberOfCrews() ?? 0 > 0{return 1}
            return 0
        case 3:
            if movieReviewViewModel?.numberOfRows() ?? 0 > 0{return 1}
            return 0
        case 4:
            if similarMovieViewModel?.numberOfRows() ?? 0 > 0{return 1}
            return 0
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: detailsCellIdentifier,
                                                     for: indexPath) as! MovieDeatilHeaderTableViewCell
            cell.moviewDetailModel = self.moviewDetailViewModel?.moviewDetail
            cell.selectionStyle = .none
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: castCellIdentifier,
                                                     for: indexPath) as! CollectionsTableViewCell
            cell.selectionStyle = .none
            cell.type = .cast
            cell.movieCastViewModel = movieCastViewModel
            cell.reloadCollectionView()
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: castCellIdentifier,
                                                     for: indexPath) as! CollectionsTableViewCell
            cell.selectionStyle = .none
            cell.type = .Crew
            cell.movieCastViewModel = movieCastViewModel
            cell.reloadCollectionView()
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: reviewCellIdentifier,
                                                     for: indexPath) as! ReviewTableViewCell
            cell.selectionStyle = .none
            cell.buttonViewAll.addTarget(self, action: #selector(buttonViewReviewsClicked), for: .touchUpInside)
            if let review = movieReviewViewModel?.moviesReviewArray.first{
                cell.movieReviewModel = review
            }
            return cell
        case 4:
            if let cell = self.similarResultCollectionsTableViewCell{
                cell.type = .similarResult
                cell.similarMovieViewModel = similarMovieViewModel
                self.similarResultCollectionsTableViewCell = cell
                cell.reloadCollectionView()
                return cell
            }
            let cell = tableView.dequeueReusableCell(withIdentifier: castCellIdentifier,
                                                     for: indexPath) as! CollectionsTableViewCell
            cell.selectionStyle = .none
            cell.type = .similarResult
            cell.similarMovieViewModel = similarMovieViewModel
            self.similarResultCollectionsTableViewCell = cell
            cell.reloadCollectionView()
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section != 0 {
            let header = MoviewDetailsSectionHeader.loadNib()
            switch section {
            case 1:
                header.labelSectionTitle.text = "Cast"
            case 2:
                header.labelSectionTitle.text = "Crew"
            case 3:
                header.labelSectionTitle.text = "Reviews"
            case 4:
                header.labelSectionTitle.text = "Similar Results"
            default:
                break
            }
            return header
        }
        
        return nil
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        if section != 0 {
            return 80
        }
        return 0
    }
}
