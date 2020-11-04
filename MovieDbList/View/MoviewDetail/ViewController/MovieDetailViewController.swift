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
    var movie:MovieModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableview()
        setUpDisplay()
    }
    
    static func loadFromNib(movie: MovieModel) -> MovieDetailViewController{
        let detailObj = MovieDetailViewController(nibName: "MovieDetailViewController",
                                                  bundle: nil)
        detailObj.movie = movie
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
        self.title = self.movie?.originalTitle ?? "Movie Detail"
        view.backgroundColor = .backgroundGrey
    }
}

// MARK: Button Actions
extension MovieDetailViewController{
    @objc func buttonViewReviewsClicked(){
        let reviewVc = ReviewsViewController.loadFromNib()
        self.navigationController?.pushViewController(reviewVc, animated: true)
    }
}

// MARK: Tableview delegate and data source methods
extension MovieDetailViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: detailsCellIdentifier,
                                                     for: indexPath) as! MovieDeatilHeaderTableViewCell
            cell.selectionStyle = .none
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: reviewCellIdentifier,
                                                     for: indexPath) as! ReviewTableViewCell
            cell.selectionStyle = .none
            cell.buttonViewAll.addTarget(self, action: #selector(buttonViewReviewsClicked), for: .touchUpInside)
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: castCellIdentifier,
                                                     for: indexPath) as! CollectionsTableViewCell
            cell.selectionStyle = .none
            cell.type = .similarResult
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: castCellIdentifier,
                                                     for: indexPath) as! CollectionsTableViewCell
            cell.selectionStyle = .none
            cell.type = .castCrew
            return cell
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
