//
//  VacationCell.swift
//  bon voyage
//
//  Created by HardiBSalih on 16.01.2023.
//

import UIKit
import SDWebImage

class VacationCell: UITableViewCell {
    
    @IBOutlet weak var vacationImg: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowRadius = 3.0
        layer.shadowOpacity = 1.0
        layer.shadowOffset = CGSize(width: 0, height: 0)
    }
    
    func confugerCell(vacation: Vacation){
        titleLbl.text = vacation.title
        priceLbl.text = vacation.price.formatIntToString()
        
        let imageUrl = vacation.images[0]
        if let url = URL(string: imageUrl){
            vacationImg.sd_imageIndicator = SDWebImageActivityIndicator.medium
            vacationImg.sd_setImage(with: url, placeholderImage: UIImage(named: Constants.ImagePlaceHolder))
        }
    }
}
