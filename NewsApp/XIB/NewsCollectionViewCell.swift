//
//  NewsCollectionViewCell.swift
//  NewsApp
//
//  Created by Юрий Девятаев on 14.03.2022.
//

import UIKit

class NewsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var customContentView: UIView!
    @IBOutlet weak var imageNews: UIImageView!
    @IBOutlet weak var textNews: UILabel!
    
    static let identifier = "NewsCollectionViewCell"
    
    var cellTap: (() -> ())?
    var indexPath: IndexPath?
    
    static func nib() -> UINib {
        return UINib(nibName: "NewsCollectionViewCell",
                     bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    override func select(_ sender: Any?) {
        print("select")
        cellTap?()
    }

}
