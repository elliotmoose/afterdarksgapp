//
//  DiscountsViewController.swift
//  AfterDarkSG
//
//  Created by Koh Yi Zhi Elliot - Ezekiel on 24/4/18.
//  Copyright © 2018 Kohbroco. All rights reserved.
//

import UIKit

class DiscountsViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout  {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: "DiscountsViewController", bundle: Bundle.main)
        Bundle.main.loadNibNamed("DiscountsViewController", owner: self, options: nil)
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
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DiscountManager.GetDiscounts().count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DiscountCollectionViewCell", for: indexPath) as! DiscountCollectionViewCell
        
        
        if indexPath.row >= 0 && indexPath.row < DiscountManager.GetDiscounts().count
        {
            cell.DisplayDiscount(DiscountManager.GetDiscounts()[indexPath.row],mode: .windowShop)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.row >= 0 && indexPath.row < DiscountManager.GetDiscounts().count
        {
            let discount = DiscountManager.GetDiscounts()[indexPath.row]
            
            if discount.curAvailCount != 0
            {
                let discountDetailViewCont = DiscountDetailViewController(nibName: "DiscountDetailViewController", bundle: Bundle.main)
                discountDetailViewCont.SetMode(.windowShop)
                discountDetailViewCont.DisplayDiscount(discount)
                self.navigationController?.pushViewController(discountDetailViewCont, animated: true)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (Sizing.ScreenHeight() - 235/*photo gallery + button heights*/ - collectionView.contentInset.top*3 - Sizing.statusBarHeight - Sizing.tabBarHeight - Sizing.navBarHeight)/2
        return CGSize(width: (Sizing.ScreenWidth() - 16/*border*/ - 6/*intercell*/)/2 , height: height)
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
