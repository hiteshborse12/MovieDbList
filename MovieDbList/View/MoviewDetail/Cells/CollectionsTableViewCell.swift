//
//  CollectionsTableViewCell.swift
//  MovieDbList
//
//  Created by webwerks on 03/11/20.
//

import UIKit

enum CollectionType {
    case cast
    case Crew
    case similarResult
}

class CollectionsTableViewCell: UITableViewCell {
    
    //MARK: Class properties
    let castCellIndetifier = "CastCrewCollectionViewCell"
    let similarCellIndetifier = "SimilarResultsCollectionViewCell"
    
    var type: CollectionType?
    var similarMovieViewModel:SimilarMovieViewModel?
    var movieCastViewModel:MovieCastViewModel?
    //MARK: IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpCollectionView()
    }
    
}

//MARK: Custom Methods
extension CollectionsTableViewCell {
    
    func setUpCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: castCellIndetifier, bundle: nil),
                                forCellWithReuseIdentifier: castCellIndetifier)
        collectionView.register(UINib(nibName: similarCellIndetifier, bundle: nil),
                                forCellWithReuseIdentifier: similarCellIndetifier)
    }
    
    func reloadCollectionView() {
        self.collectionView.reloadData()
    }
}

//MARK: Collection view delegate and datasource methods
extension CollectionsTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch type {
        case .cast:
            return movieCastViewModel?.numberOfCasts() ?? 0
        case .Crew:
            return movieCastViewModel?.numberOfCrews() ?? 0
        case .similarResult:
            return similarMovieViewModel?.numberOfRows() ?? 0
        default:
            return 10
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch type {
        case .cast:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: castCellIndetifier, for: indexPath) as! CastCrewCollectionViewCell
            cell.cast = movieCastViewModel?.movieCastArray[indexPath.row]
            return cell
        case .Crew:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: castCellIndetifier, for: indexPath) as! CastCrewCollectionViewCell
            cell.crew = movieCastViewModel?.movieCrewArray[indexPath.row]
            return cell
        case .similarResult:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: similarCellIndetifier, for: indexPath) as! SimilarResultsCollectionViewCell
            cell.movie = similarMovieViewModel?.moviesArray[indexPath.row]
            return cell
        default:
            return UICollectionViewCell()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var width: CGFloat = 110
        var height: CGFloat = collectionView.frame.height - 10
        if self.type == .similarResult{
            width = 130.0
            height = collectionView.frame.height
        }
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 0)
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        switch type {
        case .similarResult:
            if similarMovieViewModel?.canLoadNow(index: indexPath.row) ?? false{
                similarMovieViewModel?.loadSimilarMovieAPI()
            }
        default:
            print(type ?? "")
        }
    }
}

