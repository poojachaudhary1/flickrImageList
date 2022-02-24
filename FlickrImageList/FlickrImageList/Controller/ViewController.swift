//
//  ViewController.swift
//  FlickrImageList
//
//  Created by Pooja Chaudhary on 22/02/22.
//

import UIKit

class ViewController: UIViewController {
    //MARK: - IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - Variables
    let footerView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
    lazy var viewModel: FlickrImageListViewModel = {
        return FlickrImageListViewModel()
    }()
    lazy var activityIndicatorView: UIActivityIndicatorView = {
        let aiView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        aiView.center = self.view.center
        self.view.addSubview(aiView)
        return aiView
    }()
    
    //MARK: - Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        loadData()
    }
    
    //MARK: - Internal methods
    func registerCell() {
        let nib = UINib(nibName: FlickrImageListCell.identifier, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: FlickrImageListCell.identifier)
        collectionView.register(CollectionViewFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: CollectionViewFooterView.identifier)
        (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.footerReferenceSize = CGSize(width: collectionView.bounds.width, height: Constants.footerViewHeight)
    }
    func loadData() {
        viewModel.loadResponseData = { [weak self] in
            if self?.activityIndicatorView.isAnimating == true {
                self?.activityIndicatorView.stopAnimating()
            }
            if self?.footerView.isAnimating == true {
                self?.footerView.stopAnimating()
            }
            self?.collectionView.reloadData()
        }
        activityIndicatorView.startAnimating()
        viewModel.loadFlickrImages()
    }
}

//MARK: - Extension | UICollectionViewDataSource
extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.flickrImageList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FlickrImageListCell.identifier, for: indexPath) as? FlickrImageListCell else { return UICollectionViewCell() }
        cell.dataSource = viewModel.flickrImageList[indexPath.item]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionFooter {
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CollectionViewFooterView.identifier, for: indexPath)
            footer.addSubview(footerView)
            footerView.frame = CGRect(x: .zero, y: .zero, width: collectionView.bounds.width, height: Constants.footerViewHeight)
            return footer
        }
        return UICollectionReusableView()
    }
}

//MARK: - Extension | UICollectionViewDelegate
extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == viewModel.flickrImageList.count-1,
           let nextPage = viewModel.nextPage {
            footerView.startAnimating()
            viewModel.loadFlickrImages(page: nextPage)
        }
    }
}

//MARK: - Extension | UICollectionViewDelegateFlowLayout
extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (UIScreen.main.bounds.width/3)-4
        return CGSize(width: width, height: width+20)
    }
}
