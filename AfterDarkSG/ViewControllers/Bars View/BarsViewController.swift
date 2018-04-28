//
//  BarsViewController.swift
//  AfterDarkSG
//
//  Created by Koh Yi Zhi Elliot - Ezekiel on 19/4/18.
//  Copyright © 2018 Kohbroco. All rights reserved.
//

import UIKit

class BarsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate {

    public static var singleton : BarsViewController? = nil
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var searchResults = [Bar]()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: "BarsViewController", bundle: Bundle.main)
        Bundle.main.loadNibNamed("BarsViewController", owner: self, options: nil)

    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        if BarsViewController.singleton == nil
        {
            BarsViewController.singleton = self
        }
        
    }

    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "BarTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "BarTableViewCell")
        
        
        BarManager.didLoadBars.addHandler {
            self.ReloadData()
        }
        
        ImageManager.didLoadABarImage.addHandler { (bar_id) in
            self.ReloadData()
        }
        
        
        //middle top navigation item
        let banner_imageView = UIImageView(image: #imageLiteral(resourceName: "AfterDark Logo (White) no subtitle"))
        banner_imageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = banner_imageView
        
        //search bar
        searchBar.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if tableView.visibleCells.count == 0
        {
            if BarManager.GetList().count == 0
            {
                BarManager.LoadBars()
            }
            else
            {
                self.ReloadData()
            }
        }
    }
    
    func ReloadData()
    {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.tableView.contentOffset = CGPoint(x: 0, y: 0)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchBar.text == ""
        {
            return BarManager.GetList().count
        }
        else
        {
            return searchResults.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "BarTableViewCell") as? BarTableViewCell
        
        if cell == nil
        {
            cell = BarTableViewCell()
        }
        
        var barToDisplay = Bar();
        
        if searchBar.text == "" //if searching
        {
            if let bar = BarManager.BarAtIndex(indexPath.row)
            {
                barToDisplay = bar
            }
        }
        else
        {
            if indexPath.row >= 0 && indexPath.row < searchResults.count
            {
                barToDisplay = searchResults[indexPath.row]
            }
        }

        cell?.DisplayBar(barToDisplay)
        
        return cell!
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let bar = BarManager.BarAtIndex(indexPath.row)
        {
            BarDetailViewController.singleton.DisplayBar(bar)
            self.navigationController?.pushViewController(BarDetailViewController.singleton, animated: true)
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    //delegate method
    func DidLoadBars() {
        ReloadData()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchResults.removeAll()
        
        var highest_priority_result = [Bar]()
        var high_priority_result = [Bar]()
        var low_priority_result = [Bar]()
        
        if let search = searchBar.text?.lowercased()
        {
            for bar in BarManager.GetList()
            {
                switch bar.ShouldBeResult(withQuery: search)
                {
                case 1: low_priority_result.append(bar)
                case 2: high_priority_result.append(bar)
                case 3: highest_priority_result.append(bar)
                default: continue;
                }
            }
            
            searchResults = highest_priority_result + high_priority_result + low_priority_result
        }
        else
        {
            
        }
        
        
        self.ReloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
}
