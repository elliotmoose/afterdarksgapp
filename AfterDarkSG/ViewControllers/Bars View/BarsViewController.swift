//
//  BarsViewController.swift
//  AfterDarkSG
//
//  Created by Koh Yi Zhi Elliot - Ezekiel on 19/4/18.
//  Copyright © 2018 Kohbroco. All rights reserved.
//

import UIKit

class BarsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    public static var singleton : BarsViewController? = nil
    
    @IBOutlet weak var tableView: UITableView!
    
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
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return BarManager.GetList().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "BarTableViewCell") as? BarTableViewCell
        
        if cell == nil
        {
            cell = BarTableViewCell()
        }
        
        if let bar = BarManager.BarAtIndex(indexPath.row)
        {
            cell?.DisplayBar(bar)
        }
        
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
}
