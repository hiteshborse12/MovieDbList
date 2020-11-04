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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Reviews"
        setupTableview()
    }
    
    static func loadFromNib() -> ReviewsViewController{
        return ReviewsViewController(nibName: "ReviewsViewController",
                                       bundle: nil)
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
}

// MARK: Tableview delegate and data source methods
extension ReviewsViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier,
                                                 for: indexPath) as! ReviewTableViewCell
        cell.selectionStyle = .none
        cell.viewBottom.isHidden = true
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
}
