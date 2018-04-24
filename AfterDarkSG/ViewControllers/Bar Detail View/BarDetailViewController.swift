//
//  BarDetailViewController.swift
//  AfterDarkSG
//
//  Created by Koh Yi Zhi Elliot - Ezekiel on 19/4/18.
//  Copyright © 2018 Kohbroco. All rights reserved.
//

import UIKit

class BarDetailViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    public static let singleton = BarDetailViewController(nibName: "BarDetailViewController", bundle: Bundle.main)
    
    
    private let images = [#imageLiteral(resourceName: "image-bank-0"),#imageLiteral(resourceName: "image-bank-1"),#imageLiteral(resourceName: "image-bank-2"),#imageLiteral(resourceName: "image-bank-3"),#imageLiteral(resourceName: "image-bank-4"),#imageLiteral(resourceName: "image-bank-5"),#imageLiteral(resourceName: "image-bank-6"),#imageLiteral(resourceName: "image-bank-7"),#imageLiteral(resourceName: "image-bank-8"),#imageLiteral(resourceName: "image-bank-9")]
    @IBOutlet weak var discountTabButton: UIButton!
    @IBOutlet weak var aboutTabButton: UIButton!
    @IBOutlet weak var aboutTextView: UITextView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var displayedBar : Bar?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: "BarDetailViewController", bundle: Bundle.main)
        Bundle.main.loadNibNamed("BarDetailViewController", owner: self, options: nil)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "DiscountCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "DiscountCollectionViewCell")
        
        DiscountManager.didLoadDiscounts.addHandler {
            self.ReloadData()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    override func viewDidDisappear(_ animated: Bool) {
        ResetScene()
    }
    
    public func ResetScene()
    {
        DidSelectTab(discountTabButton)
        displayedBar = nil
    }
    
    @IBAction func DidSelectTab(_ sender: UIButton) {
        if sender == discountTabButton
        {
            discountTabButton.setTitleColor(UIColor.white, for: .normal)
            discountTabButton.backgroundColor = UIColor.black
            aboutTabButton.setTitleColor(UIColor.black, for: .normal)
            aboutTabButton.backgroundColor = UIColor.white
            
            aboutTextView.alpha = 0
            collectionView.alpha = 1
        }
        else
        {
            aboutTabButton.setTitleColor(UIColor.white, for: .normal)
            aboutTabButton.backgroundColor = UIColor.black
            discountTabButton.setTitleColor(UIColor.black, for: .normal)
            discountTabButton.backgroundColor = UIColor.white
            
            aboutTextView.alpha = 1
            collectionView.alpha = 0
        }
    }

    
    public func DisplayBar(_ bar : Bar)
    {
        self.title = bar.name
        
        aboutTextView.text = bar.about
        
        displayedBar = bar
        
        ReloadData()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let bar = displayedBar
        {
            return bar.discounts.count
        }
        else
        {
            return 0
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DiscountCollectionViewCell", for: indexPath) as! DiscountCollectionViewCell
        
        if let discount = displayedBar?.DiscountAtIndex(indexPath.row)
        {
            cell.DisplayDiscount(discount)
            
            
            var index = indexPath.row
            
            while index >= 10
            {
                index = index - 10
            }
            
            cell.imageView.image = images[index]
        }
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let discount = displayedBar?.DiscountAtIndex(indexPath.row)
        {
            if discount.curAvailCount != 0
            {
                DiscountDetailViewController.singleton.DisplayDiscount(discount)
            self.navigationController?.pushViewController(DiscountDetailViewController.singleton, animated: true)
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
