//
//  WalletViewController.swift
//  AfterDarkSG
//
//  Created by Koh Yi Zhi Elliot - Ezekiel on 24/4/18.
//  Copyright © 2018 Kohbroco. All rights reserved.
//

import UIKit

class WalletViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var walletCountLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var refreshButton : UIBarButtonItem?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: "WalletViewController", bundle: Bundle.main)
        Bundle.main.loadNibNamed("WalletViewController", owner: self, options: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        ReloadData()

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "DiscountCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "DiscountCollectionViewCell")
        
        DiscountManager.didLoadDiscounts.addHandler {
            self.ReloadData()
        }
        
        UserManager.didUpdateWallet.addHandler {
            self.ReloadData()
        }
        
        refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(Refresh))
        refreshButton?.tintColor = UIColor.white
        navigationItem.rightBarButtonItem = refreshButton
    }
    
    @objc func Refresh()
    {
        UserManager.LoadWallet()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let count = UserManager.wallet.count
        walletCountLabel.text = "\(count)/4"
        return count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DiscountCollectionViewCell", for: indexPath) as! DiscountCollectionViewCell
        
        
        if indexPath.row >= 0 && indexPath.row < UserManager.wallet.count
        {
            cell.DisplayDiscount(UserManager.wallet[indexPath.row],mode: .wallet)
//
//
//            var index = indexPath.row
//
//            while index >= 10
//            {
//                index = index - 10
//            }
//            
//            cell.imageView.image = DiscountManager.images[index]
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.row >= 0 && indexPath.row < UserManager.wallet.count
        {
            let discount = UserManager.wallet[indexPath.row]

            let discountDetailViewCont = DiscountDetailViewController(nibName: "DiscountDetailViewController", bundle: Bundle.main)
            discountDetailViewCont.SetMode(.wallet)
            discountDetailViewCont.DisplayDiscount(discount)
            self.navigationController?.pushViewController(discountDetailViewCont, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //let height = (Sizing.ScreenHeight() - 235/*photo gallery + button heights*/ - collectionView.contentInset.top*3 - Sizing.statusBarHeight - Sizing.tabBarHeight - Sizing.navBarHeight)/2
        let width = (Sizing.ScreenWidth() - 16/*border*/ - 6/*intercell*/)/2
        return CGSize(width:  width , height: width*1.2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func ReloadData()
    {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }

}
