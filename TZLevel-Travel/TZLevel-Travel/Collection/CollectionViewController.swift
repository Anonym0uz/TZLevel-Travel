//
//  CollectionViewController.swift
//  TZLevel-Travel
//
//  Created by Alexander Orlov on 08.05.2019.
//  Copyright © 2019 Alexander Orlov. All rights reserved.
//

import UIKit

class CollectionViewController: UICollectionViewController {
    
    var datas: NSMutableDictionary = [:]
    
    var datasArray: NSMutableArray = []
    
    private let cellIdentAlbums = "CellIDAlbums"
    private let cellIdentSongs = "CellIDSongs"
    private let cellIdentAudiobooks = "CellIDAudiobooks"
    private let cellIdentSongsFM = "CellIDSongsFM"
    
    //
    private var searchBar: UISearchBar!
    
    //
    private var segmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = UIColor.white
        collectionView.register(AlbumsCollectionCell.self, forCellWithReuseIdentifier: cellIdentAlbums)
        collectionView.register(SongsCollectionCell.self, forCellWithReuseIdentifier: cellIdentSongs)
        collectionView.register(AudioBooksCollectionCell.self, forCellWithReuseIdentifier: cellIdentAudiobooks)
        collectionView.register(SongsFMCollectionCell.self, forCellWithReuseIdentifier: cellIdentSongsFM)
        collectionView.delegate = self
        let hideKBGesture = UITapGestureRecognizer(target: self, action: #selector(hideKB))
        hideKBGesture.delegate = self
        self.view.addGestureRecognizer(hideKBGesture)
        TZFunctions().setupNavigationController(navigationCtrl: self.navigationController, navigationItem: self.navigationItem, navigationTitle: "", leftButton: nil, rightButton: nil)
        self.createMainElements()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    func createMainElements() {
        self.createSearchBar()
        self.createSegmentControl()
        self.navigationItem.titleView = self.segmentedControl
        self.view.setNeedsUpdateConstraints()
    }
    
    override func updateViewConstraints() {
        self.searchBar.snp.remakeConstraints { (make) in
            make.left.right.top.equalTo(self.view)
            make.height.equalTo(60)
        }
        collectionView.snp.remakeConstraints { (make) in
            make.left.right.bottom.equalTo(self.view)
            make.top.equalTo(self.searchBar.snp.bottom)
        }
        super.updateViewConstraints()
    }
    
}

extension CollectionViewController: UICollectionViewDelegateFlowLayout {
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Or we can make hardcode to self.segmentedControl.selectedSegmentIndex == 0 || 1
        if (self.segmentedControl.titleForSegment(at: self.segmentedControl.selectedSegmentIndex) == "iTunes") {
            if (indexPath.row == 0) {
                if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentAlbums, for: indexPath) as? AlbumsCollectionCell {
                    cell.updateModel(model: self.datasArray.object(at: indexPath.row) as! NSMutableArray)
                    return cell
                }
            }
            if (indexPath.row == 1) {
                if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentSongs, for: indexPath) as? SongsCollectionCell {
                    cell.updateModel(model: self.datasArray.object(at: indexPath.row) as! NSMutableArray)
                    return cell
                }
            }
            if (indexPath.row == 2) {
                if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentAudiobooks, for: indexPath) as? AudioBooksCollectionCell {
                    cell.updateModel(model: self.datasArray.object(at: indexPath.row) as! NSMutableArray)
                    return cell
                }
            }
        } else if (self.segmentedControl.titleForSegment(at: self.segmentedControl.selectedSegmentIndex) == "Last.fm") {
//            if (indexPath.row == 0) {
                if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentSongsFM, for: indexPath) as? SongsFMCollectionCell {
                    cell.updateModel(model: self.datasArray.object(at: indexPath.row) as! NSMutableArray)
                    return cell
                }
//            }
        }
        
//        let cell: SongsCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdent, for: indexPath) as! SongsCollectionCell
//        cell.model = modeliTunes
        return collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.datasArray.count != 0 {
            return self.datasArray.count
        } else {
            return 0
        }
//        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
    }
}

extension CollectionViewController: UISearchBarDelegate {
    func createSegmentControl() {
        segmentedControl = UISegmentedControl(items: ["iTunes", "Last.fm"])
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(segmentedControlSelected(sender:)), for: .valueChanged)
        self.segmentedControlSelected(sender: segmentedControl)
    }
    
    @objc func segmentedControlSelected(sender: UISegmentedControl!) {
        print("Name for selected index: " + sender.titleForSegment(at: sender.selectedSegmentIndex)!)
        if sender.titleForSegment(at: sender.selectedSegmentIndex) == "iTunes" {
            if (self.searchBar.text?.count != 0) {
                self.iTunesSearchRequest(searchText: self.searchBar.text!)
            }
        } else if sender.titleForSegment(at: sender.selectedSegmentIndex) == "Last.fm" {
            if (self.searchBar.text?.count != 0) {
                self.lastFMSearchRequest(searchText: self.searchBar.text!)
            }
        }
    }
    
    func createSearchBar() {
        searchBar = UISearchBar(frame: .zero)
        searchBar.showsCancelButton = false
        searchBar.delegate = self
        searchBar.placeholder = "Search"
        view.addSubview(searchBar)
    }
    
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        DispatchQueue.main.async {
//            self.datas.removeAllObjects()
            self.datasArray.removeAllObjects()
            self.collectionView.reloadData()
        }
        
        if (self.segmentedControl.titleForSegment(at: self.segmentedControl.selectedSegmentIndex) == "iTunes") {
            self.iTunesSearchRequest(searchText: searchBar.text!)
        } else if (self.segmentedControl.titleForSegment(at: self.segmentedControl.selectedSegmentIndex) == "Last.fm") {
            self.lastFMSearchRequest(searchText: searchBar.text!)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.text = ""
    }
}

// MARK: - Search helpers
extension CollectionViewController {
    func iTunesSearchRequest(searchText: String) {
        self.datasArray.removeAllObjects()
        self.collectionView.reloadData()
        TZAPI().getItunesDatas(searchString: searchText) { (success, responce, error) in
            if success && error.count == 0 {
                let data = (responce as! TZiTunesData).results! as NSArray
                let albumsArray: NSMutableArray = []
                let songsArray: NSMutableArray = []
                let audiobooksArray: NSMutableArray = []
                for i in 0..<data.count {
                    guard let object: iTunesObject = data.object(at: i) as? iTunesObject else { return }
                    if (object.wrapperType == "track") {
                        if (object.trackCount != nil && object.trackCount! > 1) {
                            albumsArray.add(object)
                            songsArray.add(object)
                        } else {
                            songsArray.add(object)
                        }
                    } else if (object.wrapperType == "audiobook") {
                        audiobooksArray.add(object)
                    }
                }
                if (albumsArray.count != 0) { self.datasArray.add(albumsArray) }
                if (songsArray.count != 0) { self.datasArray.add(songsArray) }
                if (audiobooksArray.count != 0) { self.datasArray.add(audiobooksArray) }
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
    func lastFMSearchRequest(searchText: String) {
        self.datasArray.removeAllObjects()
        self.collectionView.reloadData()
        TZAPI().getLastFmDatas(searchString: searchText) { (success, responce, error) in
            if success && error.count == 0 {
                let data = (responce as! TZLastFMData).results?.trackmatches?.track as NSArray?
                let songs: NSMutableArray = []
                songs.addObjects(from: data as! [Any])
                self.datasArray.add(songs)
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
    }
}

// MARK: - Gestures
extension CollectionViewController: UIGestureRecognizerDelegate {
    @objc func hideKB() {
        self.searchBar.resignFirstResponder()
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if ((touch.view?.isDescendant(of: self.collectionView))! && !self.searchBar.isFirstResponder) {
            return false
        }
        return true
    }
}
