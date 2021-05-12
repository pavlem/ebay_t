//
//  HomeImageView.swift
//  Ebay_t
//
//  Created by Pavle Mijatovic on 10.5.21..
//

import UIKit

class LaunchImageView: UIImageView {
    
    // MARK: - API
    var vm: LaunchImageVM! {
        didSet {
            setImage(withUrlString: vm.imageUrlString) { _ in }
        }
    }
    
    func cancelImageDownload() {
        vm.cancelImageDownload()
    }
    
    // MARK: - Inits
    override init(image: UIImage?) {
        super.init(image: image)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    
        guard vm.isRounded else { return }
        layer.cornerRadius = self.frame.size.height / 2
        clipsToBounds = true
        contentMode = .scaleToFill
    }
        
    // MARK: - Helper
    private func setImage(withUrlString imageUrlString: String?, fail: @escaping (NetworkError) -> Void) {
        image = UIImage(named: vm.imagePlaceholderName)
        guard let urlString = imageUrlString else { return }
        
        if let image = vm?.getCachedImage(imageName: urlString) {
            set(image: image)
            return
        }
        
        vm?.getImage(withName: urlString, completion: { result in
            switch result {
            case .failure(let err):
                fail(err)
            case .success(let image):
                self.vm?.cache(image: image, key: urlString)
                self.set(image: image, withTransition: self.vm?.imageTransition)
            }
        })
    }
        
    // MARK: - Helper
    private func set(image: UIImage, withTransition transition: Double? = nil) {
        guard let transition = transition else {
            DispatchQueue.main.async {
                self.image = image
            }
            return
        }
        
        DispatchQueue.main.async {
            self.image = nil
            UIView.transition(with: self,
                              duration: transition,
                              options: .transitionCrossDissolve,
                              animations: { self.image = image },
                              completion: nil)
        }
    }
}
