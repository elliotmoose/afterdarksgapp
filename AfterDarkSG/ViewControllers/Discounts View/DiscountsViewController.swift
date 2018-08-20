//
//  DiscountsViewController.swift
//  AfterDarkSG
//
//  Created by Koh Yi Zhi Elliot - Ezekiel on 24/4/18.
//  Copyright © 2018 Kohbroco. All rights reserved.
//

import UIKit

class DiscountsViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UISearchBarDelegate  {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    private var searchResults = [Discount]()
    
    var displayedDiscounts = [Discount]()
    
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
        
        
        
        //middle top navigation item
        let banner_imageView = UIImageView(image: #imageLiteral(resourceName: "AfterDark Logo (White) no subtitle"))
        banner_imageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = banner_imageView
        
        //search bar
        searchBar.delegate = self
        
        DiscountManager.didLoadDiscounts.addHandler {
            self.ReloadData()
        }
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        DismissKeyboard()
    }
    
    @objc func DismissKeyboard()
    {
        view.endEditing(true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if searchBar.text == ""
        {
            return self.displayedDiscounts.count
        }
        else
        {
            return searchResults.count
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DiscountCollectionViewCell", for: indexPath) as! DiscountCollectionViewCell
        
        var discountToDisplay = Discount()
        
        if searchBar.text == "" //if not searching
        {
            if indexPath.row >= 0 && indexPath.row < self.displayedDiscounts.count
            {
                discountToDisplay = self.displayedDiscounts[indexPath.row]
            }
        }
        else
        {
            if indexPath.row >= 0 && indexPath.row < searchResults.count
            {
                discountToDisplay = searchResults[indexPath.row]
            }
        }
        
        cell.DisplayDiscount(discountToDisplay,mode: .windowShop)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var discountToDisplay : Discount? = nil

        if searchBar.text == ""
        {
            if indexPath.row >= 0 && indexPath.row < self.displayedDiscounts.count
            {
                let discount = self.displayedDiscounts[indexPath.row]
                
                if discount.curAvailCount != 0
                {
                    discountToDisplay = discount
                }
            }
        }
        else
        {
            if indexPath.row >= 0 && indexPath.row < searchResults.count
            {
                discountToDisplay = searchResults[indexPath.row]
            }
        }
        
        if let discount = discountToDisplay
        {
            let discountDetailViewCont = DiscountDetailViewController(nibName: "DiscountDetailViewController", bundle: Bundle.main)
            discountDetailViewCont.SetMode(.windowShop)
            discountDetailViewCont.DisplayDiscount(discount)
            self.navigationController?.pushViewController(discountDetailViewCont, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (Sizing.ScreenHeight() - 235/*photo gallery + button heights*/ - collectionView.contentInset.top*3 - Sizing.statusBarHeight - Sizing.tabBarHeight - Sizing.navBarHeight)/2
        return CGSize(width: (Sizing.ScreenWidth() - 16/*border*/ - 6/*intercell*/)/2 , height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchResults.removeAll()
        
        var highest_priority_result = [Discount]()
        var high_priority_result = [Discount]()
        var low_priority_result = [Discount]()
        
        if let search = searchBar.text?.lowercased()
        {
            for discount in DiscountManager.GetDiscounts()
            {
                switch discount.ShouldBeResult(withQuery: search)
                {
                case 1: low_priority_result.append(discount)
                case 2: high_priority_result.append(discount)
                case 3: highest_priority_result.append(discount)
                default: continue;
                }
            }
            
            highest_priority_result = highest_priority_result.sorted(by: { (a, b) -> Bool in
                return a.curAvailCount > b.curAvailCount
            })
            
            high_priority_result = high_priority_result.sorted(by: { (a, b) -> Bool in
                return a.curAvailCount > b.curAvailCount
            })
            
            low_priority_result = low_priority_result.sorted(by: { (a, b) -> Bool in
                return a.curAvailCount > b.curAvailCount
            })
            
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
    
    func ReloadData()
    {
        DispatchQueue.main.async {
            //sort
            self.displayedDiscounts = DiscountManager.GetDiscounts().sorted(by: { (a, b) -> Bool in
                return a.curAvailCount > b.curAvailCount
            })
            
            //reload data
            self.collectionView.reloadData()
        }
    }

}
