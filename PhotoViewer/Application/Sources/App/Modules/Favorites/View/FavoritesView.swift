//
//  FavoritesView.swift
//  PhotoViewerApp_Example
//
//  Created by David Duarte on 09/12/2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

protocol FavoritesViewInterface {
    
}

class FavoritesViewImpl: UIViewController {
    
    typealias Dependencies = FavoritesPresenterFactory
    let dependencies: Dependencies
    
    required init(dependencies: Dependencies) {
        self.dependencies = dependencies
        tableView.register(FavoritePhotoCell.self, forCellReuseIdentifier: cellIdentifier)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    let cellIdentifier = "favoriteCell"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.estimatedRowHeight = 100
        
        self.addViews()
        
        // observe when the photos are added to update the view
        self.dependencies.makeFavoritesPresenter().favoritesPhotos.bind { _ in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    //
    // MARK: View methods
    //
    func addViews(){
        self.view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
    }
}

//
// MARK: TableView methods
//
extension FavoritesViewImpl: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rows = self.dependencies.makeFavoritesPresenter().tableViewRows()
        if rows > 0 {
            tableView.restore()
        } else {
            tableView.setEmptyView(title: "You don't have any photo saved.", message: "Return to home tab to start liking photos.")
        }
        return rows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! FavoritePhotoCell
        cell.delegate = self
        if let url = self.dependencies.makeFavoritesPresenter().getPhotoUrl(for: indexPath.row) {
            cell.photoImageView.loadImage(at: url)
            cell.photoImageView.delegate = self
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
        
    }
}

extension FavoritesViewImpl: ImageViewDelegate {
    func notifyPhotoLoaded() {
        tableView.beginUpdates()
        tableView.endUpdates()
    }
}

//
// MARK: Cell Delegate extension
//
extension FavoritesViewImpl: FavoritePhotoCellDelegate {
    func photoLiked(at cell: UITableViewCell) {
        guard let indexPath = self.tableView.indexPath(for: cell) else { return }
        self.dependencies.makeFavoritesPresenter().likedPhoto(at: indexPath)
    }
}
