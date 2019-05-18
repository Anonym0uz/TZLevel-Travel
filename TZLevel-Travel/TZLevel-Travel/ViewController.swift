//
//  ViewController.swift
//  TZLevel-Travel
//
//  Created by Alexander Orlov on 07.05.2019.
//  Copyright © 2019 Alexander Orlov. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    private let cellIdentifier: String = "TZCellIdent"
    private var tableView: UITableView!
    private var arrayObj: NSMutableArray!
    
    //
    private var searchBar: UISearchBar!
    
    //
    private var segmentedControl: UISegmentedControl!
    
    //
    private var dimView: UIView!
    
    // MARK: - View life's cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        TZFunctions().setupNavigationController(navigationCtrl: self.navigationController, navigationItem: self.navigationItem, navigationTitle: "", hideBackButton: true, leftButton: nil, rightButton: nil)
        self.createSegmentControl()
        self.createSearchBar()
        self.createViewElements()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    // MARK: - Create main elements
    func createViewElements() {
        arrayObj = NSMutableArray()
        for i in 0..<10 {
            arrayObj.add("Cell: \(i)")
        }
        
        let hideKBGesture = UITapGestureRecognizer(target: self, action: #selector(hideKB))
        hideKBGesture.delegate = self
        self.view.addGestureRecognizer(hideKBGesture)
        
        self.navigationItem.titleView = self.segmentedControl
        
        self.tableView = TZFunctions().createTableView(style: .plain,
                                                       delegate: self,
                                                       dataSource: self,
                                                       parentView: self.view)
        self.tableView.register(CustomCell.self, forCellReuseIdentifier: cellIdentifier)
        
        self.view.setNeedsUpdateConstraints()
    }
    
    // MARK: - Update constraints
    override func updateViewConstraints() {
        self.searchBar.snp.remakeConstraints { (make) in
            make.top.left.right.equalTo(0)
            make.height.equalTo(60)
        }
        self.tableView.snp.remakeConstraints { (make) in
            make.bottom.left.right.equalTo(self.view)
            make.top.equalTo(self.searchBar.snp.bottom)
        }
        super.updateViewConstraints()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayObj.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        let cell: CustomCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CustomCell
        cell.cellTitle.text = "\(arrayObj[indexPath.row])"
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("cell selected: \(indexPath.row)")
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

extension ViewController: UISearchBarDelegate {
    func createSegmentControl() {
        segmentedControl = UISegmentedControl(items: ["iTunes", "Last.fm"])
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(segmentedControlSelected(sender:)), for: .valueChanged)
        self.segmentedControlSelected(sender: segmentedControl)
    }
    
    @objc func segmentedControlSelected(sender: UISegmentedControl!) {
        print("Name for selected index: " + sender.titleForSegment(at: sender.selectedSegmentIndex)!)
        if sender.titleForSegment(at: sender.selectedSegmentIndex) == "iTunes" {
            TZAPI().getItunesDatas()
        } else if sender.titleForSegment(at: sender.selectedSegmentIndex) == "Last.fm" {
            TZAPI().getLastFmDatas()
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
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.text = ""
    }
}

// MARK: - Gestures
extension ViewController: UIGestureRecognizerDelegate {
    @objc func hideKB() {
        self.searchBar.resignFirstResponder()
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if ((touch.view?.isDescendant(of: self.tableView))! && !self.searchBar.isFirstResponder) {
            return false
        }
        return true
    }
}
