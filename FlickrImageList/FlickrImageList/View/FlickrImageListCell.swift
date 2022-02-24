//
//  FlickrImageListCell.swift
//  FlickrImageList
//
//  Created by Pooja Chaudhary on 22/02/22.
//

import UIKit
import SDWebImage
class FlickrImageListCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageTitle: UILabel!
    
    class var identifier: String {
        return String(describing: self)
    }
    var dataSource: FlickrImageModel? {
        didSet {
            guard let data = dataSource else { return }
            if let farm = data.farm, let server = data.server, let id = data.id, let secret = data.secret {
                let imageURLString = String(format: Constants.downloadImageURL, "\(farm)", server, id, secret)
                imageView.sd_setImage(with: URL(string: imageURLString), completed: nil)
            }
            imageTitle.text = data.title
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
