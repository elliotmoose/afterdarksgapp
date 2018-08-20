//
//  SettingsViewController.swift
//  AfterDarkSG
//
//  Created by Koh Yi Zhi Elliot - Ezekiel on 2/5/18.
//  Copyright © 2018 Kohbroco. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "SettingsTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "SettingsTableViewCell")
    }

    override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "SettingsTableViewCell") as? SettingsTableViewCell
        
        if cell == nil
        {
            cell = SettingsTableViewCell()
        }
        
        
//        switch indexPath.row
//        {
//        case 0:
//            cell?.label.text = "Settings"
//        case 1:
//            cell?.label.text = "About Us"
//        case 2:
//            cell?.label.text = "Fair Use Policy"
//        case 3:
//            cell?.label.text = "Contact Us"
//        case 4:
//            cell?.label.text = "FAQ"
//        case 5:
//            cell?.label.text = "Share Afterdark"
//
//        default:
//            break;
//        }
        
        switch indexPath.row
        {
        case 0:
            cell?.label.text = "Contact Us"
        case 1:
            cell?.label.text = "Share Afterdark"
        case 2:
            cell?.label.text = "Help"
        default:
            break;
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        if indexPath.row == 0
        {
            navigationController?.pushViewController(ContactUsViewController.singleton, animated: true)
        }
        else if indexPath.row == 1
        {
            let vc = UIActivityViewController(activityItems: ["https://itunes.apple.com/app/id1181931586 \n Check out this cool app that helps me get epic discounts at bars!"], applicationActivities: [])
            present(vc, animated: true)
        }
        else if indexPath.row == 2
        {
            navigationController?.pushViewController(TextDisplayViewController.singleton, animated: true)
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 48
    }
}
