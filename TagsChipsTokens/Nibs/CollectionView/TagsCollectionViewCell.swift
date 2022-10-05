//
//  TagsCollectionViewCell.swift
//  TagsChipsTokens
//
//  Created by Izaan on 04/10/2022.
//

import UIKit

class TagsCollectionViewCell: UICollectionViewCell {
    
    //MARK: - IBOutlets
    @IBOutlet weak var lblText: UILabel!
    
    //MARK: - Properties
    var delegate: TableViewCellDelegate?
    var indexPath: IndexPath?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    //MARK: - IBOutlets
    @IBAction func crossAction(_ sender: UIButton) {
        self.delegate?.click(indexPath: self.indexPath)
    }

}
