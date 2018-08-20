//
//  BarDetailViewController.swift
//  AfterDarkSG
//
//  Created by Koh Yi Zhi Elliot - Ezekiel on 19/4/18.
//  Copyright © 2018 Kohbroco. All rights reserved.
//

import UIKit
import WebKit

class BarDetailViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    public static let singleton = BarDetailViewController(nibName: "BarDetailViewController", bundle: Bundle.main)
    
    
    @IBOutlet weak var barNameLabel: UILabel!
    @IBOutlet weak var discountTabButton: UIButton!
    @IBOutlet weak var aboutTabButton: UIButton!
    @IBOutlet weak var guestlistTabButton: UIButton!
    @IBOutlet weak var aboutTextView: UITextView!
    @IBOutlet weak var imageContainerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var guestlistWebView: WKWebView!
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
        
        //image gradient layer
        let gradientMaskLayer = CAGradientLayer()
        gradientMaskLayer.frame = CGRect(x: 0, y: 0, width: Sizing.ScreenWidth(), height: imageView.frame.height)
        gradientMaskLayer.colors = [UIColor.black.cgColor,UIColor.clear.cgColor]
        gradientMaskLayer.locations = [0.4,1]
        imageView.layer.mask = gradientMaskLayer
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
    }
    
    @IBAction func DidSelectTab(_ sender: UIButton) {
        if sender == discountTabButton
        {
            discountTabButton.setTitleColor(UIColor.white, for: .normal)
            discountTabButton.backgroundColor = UIColor.black
            aboutTabButton.setTitleColor(UIColor.black, for: .normal)
            aboutTabButton.backgroundColor = UIColor.white
            guestlistTabButton.setTitleColor(UIColor.black, for: .normal)
            guestlistTabButton.backgroundColor = UIColor.white
            
            aboutTextView.alpha = 0
            collectionView.alpha = 1
            guestlistWebView.alpha = 0
        }
        else if sender == aboutTabButton
        {
            aboutTabButton.setTitleColor(UIColor.white, for: .normal)
            aboutTabButton.backgroundColor = UIColor.black
            discountTabButton.setTitleColor(UIColor.black, for: .normal)
            discountTabButton.backgroundColor = UIColor.white
            guestlistTabButton.setTitleColor(UIColor.black, for: .normal)
            guestlistTabButton.backgroundColor = UIColor.white
            
            aboutTextView.alpha = 1
            collectionView.alpha = 0
            guestlistWebView.alpha = 0
        }
        else if sender == guestlistTabButton
        {
            aboutTabButton.setTitleColor(UIColor.black, for: .normal)
            aboutTabButton.backgroundColor = UIColor.white
            discountTabButton.setTitleColor(UIColor.black, for: .normal)
            discountTabButton.backgroundColor = UIColor.white
            guestlistTabButton.setTitleColor(UIColor.white, for: .normal)
            guestlistTabButton.backgroundColor = UIColor.black
            
            aboutTextView.alpha = 0
            collectionView.alpha = 0
            guestlistWebView.alpha = 1
        }
    }

    
    public func DisplayBar(_ bar : Bar)
    {
        //format page -- gueslist
        if let gueslistlink = bar.guestlistLink,let url = URL(string: gueslistlink)
        {
            guestlistTabButton.isHidden = false
            discountTabButton.isHidden = true
            DidSelectTab(guestlistTabButton)
            guestlistWebView.loadHTMLString("", baseURL: nil)
            guestlistWebView.load(URLRequest(url: url))
        }
        else
        {
            guestlistTabButton.isHidden = true
            discountTabButton.isHidden = false
        }
        
        //self.title = bar.name
        barNameLabel.text = bar.name
        
        aboutTextView.text = bar.about
        
        let gap = NSMutableAttributedString(string: "\n")
        let aboutAttString = NSMutableAttributedString(string: bar.about)
        aboutAttString.addAttributes([NSAttributedStringKey.foregroundColor : UIColor.white], range: NSRange.init(location: 0, length: aboutAttString.length))
        let addressAttString = NSMutableAttributedString(string: "Address:")
        addressAttString.addAttributes([NSAttributedStringKey.foregroundColor : UIColor.white], range: NSRange.init(location: 0, length: addressAttString.length))
        let addressDetailAttString = NSMutableAttributedString(string: bar.address_full)
        addressDetailAttString.addAttributes([NSAttributedStringKey.foregroundColor : UIColor.gray], range: NSRange.init(location: 0, length: addressDetailAttString.length))
        let openingAttString = NSMutableAttributedString(string: "Opening Hours:")
        openingAttString.addAttributes([NSAttributedStringKey.foregroundColor : UIColor.white], range: NSRange.init(location: 0, length: openingAttString.length))
        let openingDetailAttString = NSMutableAttributedString(string: bar.openingHours)
        openingDetailAttString.addAttributes([NSAttributedStringKey.foregroundColor : UIColor.gray], range: NSRange.init(location: 0, length: openingDetailAttString.length))
        let contactAttString = NSMutableAttributedString(string: "Contact:")
        contactAttString.addAttributes([NSAttributedStringKey.foregroundColor : UIColor.white], range: NSRange.init(location: 0, length: contactAttString.length))
        let contactDetailAttString = NSMutableAttributedString(string: bar.contact)
        contactDetailAttString.addAttributes([NSAttributedStringKey.foregroundColor : UIColor.gray], range: NSRange.init(location: 0, length: contactDetailAttString.length))
        
        let finalText = NSMutableAttributedString(attributedString: aboutAttString)
        finalText.append(gap)
        finalText.append(gap)
        finalText.append(addressAttString)
        finalText.append(gap)
        finalText.append(addressDetailAttString)
        finalText.append(gap)
        finalText.append(gap)
        finalText.append(openingAttString)
        finalText.append(gap)
        finalText.append(openingDetailAttString)
        finalText.append(gap)
        finalText.append(gap)
        finalText.append(contactAttString)
        finalText.append(gap)
        finalText.append(contactDetailAttString)
        
        finalText.addAttributes([NSAttributedStringKey.font : UIFont(name: "Avenir Next Condensed", size: 17) as Any], range: NSRange.init(location: 0, length: finalText.length))
        aboutTextView.attributedText = finalText
        aboutTextView.textAlignment = .center
        
        
        imageView.image = bar.GetDisplayImage()
    
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
            cell.DisplayDiscount(discount,mode: .windowShop)
        }
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let discount = displayedBar?.DiscountAtIndex(indexPath.row)
        {
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
