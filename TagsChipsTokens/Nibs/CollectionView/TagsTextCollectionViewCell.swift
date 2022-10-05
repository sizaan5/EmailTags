//
//  TagsTextCollectionViewCell.swift
//  TagsChipsTokens
//
//  Created by Izaan on 04/10/2022.
//

import UIKit

class TagsTextCollectionViewCell: UICollectionViewCell {
    
    //MARK: - IBOutlets
    @IBOutlet weak var txtText: UITextField!
    
    //MARK: - Properties
    var delegate: TableViewCellDelegate?
    var indexPath: IndexPath?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.txtText.delegate = self
        self.txtText.addTarget(self, action: #selector(self.textFieldDidChange), for: .editingChanged)
    }
    
    //MARK: - Helper Methods
    @objc func textFieldDidChange() {
        self.delegate?.click(indexPath: self.indexPath, value: self.txtText.text)
    }

}

//MARK: - UITextFieldDelegate
extension TagsTextCollectionViewCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
}
