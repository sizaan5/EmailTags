//
//  ViewController.swift
//  TagsChipsTokens
//
//  Created by Izaan on 04/10/2022.
//

import UIKit

class ViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var lblEmails: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - Properties
    var emails: [String] = []
    
    //MARK: - view LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Enter Emails"
        self.registerCollectionView()
        
        let b = UIBarButtonItem(
            title: "Save",
            style: .plain,
            target: self,
            action: #selector(self.showEmailsAction)
        )
        b.tintColor = Constants.Colors.themeColor
        self.navigationItem.rightBarButtonItem = b
    }
    
    //MARK: - Helper Methods
    func registerCollectionView() {
        self.collectionView.register(
            UINib(
                nibName: TagsCollectionViewCell.identifier,
                bundle: nil),
            forCellWithReuseIdentifier: TagsCollectionViewCell.identifier
        )
        self.collectionView.register(
            UINib(
                nibName: TagsTextCollectionViewCell.identifier,
                bundle: nil
            ),
            forCellWithReuseIdentifier: TagsTextCollectionViewCell.identifier
        )
    }
    
    @objc func showEmailsAction() {
        var emailsText = ""
        for email in self.emails {
            if emailsText == "" {
                emailsText = email
            } else {
                emailsText = "\(emailsText), \(email)"
            }
        }
        self.lblEmails.text = emailsText
    }

}

//MARK: - UICollectionViewDelegate
extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.view.endEditing(true)
    }
}

//MARK: - UICollectionViewDataSource
extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.emails.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == self.emails.count {
            if let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: TagsTextCollectionViewCell.identifier, for: indexPath) as? TagsTextCollectionViewCell {
                cell.delegate = self
                cell.indexPath = indexPath
                return cell
            }
        } else {
            if let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: TagsCollectionViewCell.identifier, for: indexPath) as? TagsCollectionViewCell {
                let obj = self.emails[indexPath.row]
                cell.lblText.text = obj
                cell.delegate = self
                cell.indexPath = indexPath
                return cell
            }
        }
        return UICollectionViewCell()
    }
}

//MARK: - TableViewCellDelegate
extension ViewController: TableViewCellDelegate {
    func click(indexPath: IndexPath?) {
        self.view.endEditing(true)
        if let indexPath = indexPath {
            if self.emails.indices.contains(indexPath.row) {
                self.emails.remove(at: indexPath.row)
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
    func click(indexPath: IndexPath?, value: Any?) {
        if let indexPath = indexPath {
            if let value = value as? String {
                if value.contains(where: { ( $0 == " " ) } ) {
                    let email = value.replacingOccurrences(of: " ", with: "")
                    if AppHelper.isValid(email: email) {
                        if !self.emails.contains(where: { ( $0 == email ) } ) {
                            self.emails.append(email)
                            if let cell = self.collectionView.cellForItem(at: indexPath) as? TagsTextCollectionViewCell {
                                cell.txtText.text = ""
                            }
                            self.collectionView.reloadItems(at: [indexPath])
                        } else {
                            print("Email already exists")
                        }
                    } else {
                        print("Email is not valid")
                    }
                }
            }
        }
    }
}
