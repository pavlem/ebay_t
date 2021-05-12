//
//  LaunchDetailsVC.swift
//  Ebay_t
//
//  Created by Pavle Mijatovic on 12.5.21..
//

import UIKit

class LaunchDetailsVC: UIViewController, Storyboarded {
    
    // MARK: - API
    weak var coordinator: MainCoordinator?
    
    var vm: LaunchDetailsVM?
    
    // MARK: - Properties
    @IBOutlet weak var rocketImage: UIImageView!
    @IBOutlet weak var mapImageView: LaunchImageView!
    @IBOutlet weak var countdownLbl: CountdownLabel!
    @IBOutlet weak var visualFilterView: UIView!
    @IBOutlet weak var detailsTxtView: UITextView!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }
    
    // MARK: - Helper
    private func setUI() {
        guard let vm = vm else { return }
        
        detailsTxtView.backgroundColor = vm.viewBackground
        detailsTxtView.font = vm.textFont
        detailsTxtView.textColor = vm.textColor
        detailsTxtView.alpha = vm.viewAlpha
        detailsTxtView.text = vm.launchText
        detailsTxtView.isEditable = vm.isTextEditable
        
        visualFilterView.backgroundColor = vm.viewBackground
        detailsTxtView.alpha = vm.viewAlpha
        
        countdownLbl.vm = CountdownLabelVM(date: vm.windowEndDate)
        
        title = vm.missionName
        rocketImage.image = vm.image
        rocketImage.contentMode = .scaleAspectFill
        
        let imageVM = LaunchImageVM(imageUrlString: vm.padMapImageUrl, imagePlaceholderName: "")
        imageVM.isRounded = vm.isMapImageRounded
        imageVM.imageTransition = vm.mapImageTransition
        mapImageView.vm = imageVM
        
        addTapGesture()
    }
    
    private func addTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        mapImageView.addGestureRecognizer(tap)
        mapImageView.isUserInteractionEnabled = true
    }
    
    // MARK: - Actions
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        guard let vm = vm else { return }
        coordinator?.openWebView(urlString: vm.padMapUrl)
    }
}
