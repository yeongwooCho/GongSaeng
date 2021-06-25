//
//  ImmediationViewController.swift
//  GongSaeng
//
//  Created by 조영우 on 2021/06/16.
//

import UIKit

class ImmediationViewController: UIViewController {

    let viewModel: PublicViewModel = PublicViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func usingButtonHandler(_ sender: Any) {
    
    }
}

extension ImmediationViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.numOfSection
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return viewModel.usingPublics.count
        } else {
            return viewModel.availablePublics.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImmediationCell", for: indexPath) as? ImmediationCell else { return UICollectionViewCell() }
        
        var item: Public
        if indexPath.section == 0 {
            item = viewModel.usingPublics[indexPath.item]
        } else {
            item = viewModel.availablePublics[indexPath.item]
        }
        cell.updateUI(at: item)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "PublicHeaderView", for: indexPath) as? PublicHeaderView else {
                return UICollectionReusableView()
            }
            guard let section = PublicViewModel.Section(rawValue: indexPath.section) else {
                return UICollectionReusableView()
                
            }
            header.updateUI(sectionTitleString: section.title)
            return header
        default:
            return UICollectionReusableView()
        }
    }
}

extension ImmediationViewController: UICollectionViewDelegate {
    
}

extension ImmediationViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = self.view.bounds.width
        let height: CGFloat = CGFloat(75.0)
        return CGSize(width: width, height: height)
    }
}

class ImmediationCell: UICollectionViewCell {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var isDoneLabel: UILabel!
    @IBOutlet weak var useingButton: UIButton!
    @IBOutlet weak var finalTimeLabel: UILabel!
    @IBOutlet weak var remainingTimeLabel: UILabel!

    func updateUI(at index: Public) {
        DispatchQueue.main.async {
            self.imgView.image = UIImage(named: "\(index.imgTitle)")
            self.titleLabel.text = index.title
            if index.isDone {
                self.useingButton.isHidden = true
                self.finalTimeLabel.isHidden = false
                self.remainingTimeLabel.isHidden = false

                self.isDoneLabel.text = "사용중"
                self.finalTimeLabel.text = "\(index.finalTime)분 종료"
                self.remainingTimeLabel.text = "\(index.remainingTime)분 남음"
            } else {
                self.finalTimeLabel.isHidden = true
                self.remainingTimeLabel.isHidden = true
                self.useingButton.isHidden = false

                self.isDoneLabel.text = "사용가능"
            }
        }
    }
}

class PublicHeaderView: UICollectionReusableView {
    @IBOutlet weak var sectionTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func updateUI(sectionTitleString: String) {
        DispatchQueue.main.async {
            self.sectionTitleLabel.text = sectionTitleString
        }
    }
}
