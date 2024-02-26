//
//  ViewController.swift
//  Mobikwik Assingment
//
//  Created by Arpit Dwivedi on 25/02/24.
//

import UIKit


class MainViewController: UIViewController {
    
    private let searchBar = UISearchBar()
    private let loadingIndicator = UIActivityIndicatorView(style: .medium)
    private let photosViewModel = PhotosViewModel()
    private let imagesViewModel = ImagesViewModel()
    private var photosArray : [Photo]? = []  {
        didSet {
            imagesViewModel.downloadImagesFromURL(photoArray: photosArray ?? [])
        }
    }
    private var imagesArray : [UIImage]? = [] {
        didSet {
            
            collectionView.reloadData()
            loadingIndicator.stopAnimating()
        }
    }
    
   
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var collectionView: UICollectionView!
    
    fileprivate var itemsPerRow: CGFloat = 2
    fileprivate let sectionInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    fileprivate var currentPageNumber = 1
    fileprivate var searchText = ""
    fileprivate var isLoading : Bool = false
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setUpCollectionView()
        setUpDataBinder()
        setUpView()
    
    }
    
    
    
    private func setupNavigationBar() {
        searchBar.placeholder = "Search for any photos"
        searchBar.delegate = self
        navigationItem.titleView = searchBar
        let menuButton = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal"), style: .plain, target: self, action: #selector(menuButtonTapped))
        navigationItem.rightBarButtonItem = menuButton
        navigationItem.rightBarButtonItem?.tintColor = .label
    }
    
    private func setUpCollectionView() {
        
        collectionView.dataSource = self
        collectionView.delegate = self
        flowLayout.sectionInset = sectionInsets
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 10
    }
    
    private func setUpDataBinder() {
        photosViewModel.photosArray.bind { [weak self] photosArray in
            if let photosArray = photosArray {
                self?.photosArray?.append(contentsOf: photosArray)
            }
            else {
                print("error")
            }
        }
        
        imagesViewModel.imagesArray.bind { imageArray in
            if let imagesArray = imageArray {
                self.imagesArray?.append(contentsOf: imagesArray)
                print(self.imagesArray as Any)
            }
            else {
                print("images error")
            }
        }
        
        imagesViewModel.isLoading.bind { [weak self ] isLoaded in
            self?.isLoading = isLoaded
        }
    }
    
    private func setUpView() {
        
        loadingIndicator.hidesWhenStopped = true
        view.addSubview(loadingIndicator)
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
        ])
    }
    
    
}

// MARK: - UISearchBarDelegate
extension MainViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        guard let searchedText = searchBar.text else { return }
        searchText = searchedText
        currentPageNumber = 1
        photosViewModel.fetchPhotos(pageNo: currentPageNumber, 30, searchText: searchedText)
    }
    
   
}

// MARK: - Menu Button Action
extension MainViewController {
    @objc func menuButtonTapped() {
        let actionSheet = UIAlertController(title: "Select Layout", message: nil, preferredStyle: .actionSheet)
        
       
        let action2 = UIAlertAction(title: "2 Images per Row", style: .default) { (action) in
            self.itemsPerRow = 2
            self.collectionView.collectionViewLayout.invalidateLayout()
        }
        
        
        let action3 = UIAlertAction(title: "3 Images per Row", style: .default) { (action) in
            self.itemsPerRow = 3
            self.collectionView.collectionViewLayout.invalidateLayout()
        }
        
      
        let action4 = UIAlertAction(title: "4 Images per Row", style: .default) { (action) in
            self.itemsPerRow = 4
            self.collectionView.collectionViewLayout.invalidateLayout()
        }
        
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        
        actionSheet.addAction(action2)
        actionSheet.addAction(action3)
        actionSheet.addAction(action4)
        actionSheet.addAction(cancelAction)
        present(actionSheet, animated: true, completion: nil)
    }
}


//MARK: - CollectionView Data Source Functions
extension MainViewController : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let photosArray = self.photosArray , photosArray.count > 0 {
            return photosArray.count
        }
        else {
            return 20
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.identifier, for: indexPath) as! ImageCollectionViewCell
       
    
        if let imagesArray = imagesArray {
            if imagesArray.count > 0 {
                cell.imageVw.image = imagesArray[indexPath.row]
            }
        }
        
        return cell
    }
}

//MARK: - CollectionView Delegate Functions
extension MainViewController : UICollectionViewDelegate {
    
}

//MARK: - CollectionView Flow Layout Functions
extension MainViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = (sectionInsets.left) * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 50)
    }
}

//MARK: - ScrollView Delegate Functions
extension MainViewController : UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.photosArray?.count ?? 0 > 0 {
            currentPageNumber += 1
            
            let offsetY = scrollView.contentOffset.y
            let contentHeight = scrollView.contentSize.height
            let height = scrollView.frame.size.height
            
         
            if offsetY > contentHeight - height && !self.isLoading {
                self.isLoading = true
                self.loadingIndicator.startAnimating()
                photosViewModel.fetchPhotos(pageNo: currentPageNumber, 30, searchText: searchText)
            }
        }
    }
}
