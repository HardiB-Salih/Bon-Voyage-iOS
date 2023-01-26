//
//  ThumnailCell.swift
//  bon voyage
//
//  Created by HardiBSalih on 16.01.2023.
//

import UIKit
import SDWebImage

class ThumnailCell: UICollectionViewCell {
    @IBOutlet weak var thumnailImg: UIImageView!
    
    func configureCell(urlImage: String) {
        guard let url = URL(string: urlImage) else {return}
        thumnailImg.layer.cornerRadius = 5
        thumnailImg.sd_imageIndicator = SDWebImageActivityIndicator.medium
        thumnailImg.sd_setImage(with: url, placeholderImage: UIImage(named: Constants.ImagePlaceHolder))
    }
}
