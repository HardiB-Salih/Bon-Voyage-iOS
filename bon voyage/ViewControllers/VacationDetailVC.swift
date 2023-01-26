//
//  VacationDetailVC.swift
//  bon voyage
//
//  Created by HardiBSalih on 16.01.2023.
//

import UIKit
import SDWebImage

class VacationDetailVC: UIViewController {
    @IBOutlet weak var highliteLbl: UILabel!
    @IBOutlet weak var activitiesLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var numberOfNight: UILabel!
    @IBOutlet weak var airFairLbl: UILabel!
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var vacation: Vacation!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
        setMainImage(index: 0)
        setUpCollectionView()
        
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destanation = segue.destination as? CheckoutVC {
            destanation.vacation = self.vacation
        }
    }
    
    func setUpCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    func setUpUI(){
        mainImage.layer.cornerRadius = 10
        title = vacation.title
        highliteLbl.text = vacation.description
        activitiesLbl.text = vacation.activities
        priceLbl.text = "All inclusive price: " + vacation.price.formatIntToString()
        numberOfNight.text = "\(vacation.numberOfDays) night accomodations"
        airFairLbl.text = vacation.airFare
    }
    
    func setMainImage(index: Int) {
        let imageUrl = vacation.images[index]
        if let url = URL(string: imageUrl){
            mainImage.sd_imageIndicator = SDWebImageActivityIndicator.medium
            mainImage.sd_setImage(with: url, placeholderImage: UIImage(named: Constants.ImagePlaceHolder))
        }
    }
    
}


extension VacationDetailVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vacation.images.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.ThumnailCell, for: indexPath) as! ThumnailCell
        cell.configureCell(urlImage: vacation.images[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        setMainImage(index: indexPath.item)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 120)
    }
    
}
