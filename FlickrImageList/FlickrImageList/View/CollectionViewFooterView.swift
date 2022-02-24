//
//  CollectionViewFooterView.swift
//  FlickrImageList
//
//  Created by Pooja Chaudhary on 22/02/22.
//

import Foundation
import UIKit

public class CollectionViewFooterView: UICollectionReusableView {
    class var identifier: String {
        return String(describing: self)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
