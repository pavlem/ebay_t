//
//  LaunchCell.swift
//  Ebay_t
//
//  Created by Pavle Mijatovic on 12.5.21..
//

import UIKit

class LaunchCell: UICollectionViewCell {
    
    // MARK: - API
    static let id = "LauncCellID"
    
    var vm: LaunchVM? {
        willSet {
            updateUI(vm: newValue)
        }
    }
    
    // MARK: - Properties
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var launchDateLbl: UILabel!
    @IBOutlet weak var familyLbl: UILabel!
    @IBOutlet weak var locationLbl: UILabel!
    @IBOutlet weak var seperatorView: UIView!
    @IBOutlet weak var launchImgView: LaunchImageView!
    
    // MARK: - Overrides
    override func prepareForReuse() {
        super.prepareForReuse()
        
        launchImgView.cancelImageDownload()
    }
    
    // MARK: - Helper
    private func updateUI(vm: LaunchVM?) {
        guard let vm = vm else { return }
        
        nameLbl.text = vm.nameDescription
        launchDateLbl.text = vm.launchDescription
        familyLbl.text = vm.familyDescription
        locationLbl.text = vm.locationDescription
        
        nameLbl.font = vm.nameLblFont
        launchDateLbl.font = vm.launchDateLblFont
        familyLbl.font = vm.familyLblFont
        locationLbl.font = vm.locationLblFont
        
        nameLbl.textColor = vm.txtColor
        launchDateLbl.textColor = vm.txtColor
        familyLbl.textColor = vm.txtColor
        locationLbl.textColor = vm.txtColor
        
        contentView.backgroundColor = vm.backgroundColor
        seperatorView.backgroundColor = vm.seperatorColor
        
        if let imageUrlString = vm.imageUrl {
            launchImgView.vm = LaunchImageVM(imageUrlString: imageUrlString)
        }
    }
}
