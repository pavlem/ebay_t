//
//  CountdownLabel.swift
//  Ebay_t
//
//  Created by Pavle Mijatovic on 13.5.21..
//

import UIKit

class CountdownLabel: UILabel {

    var vm: CountdownLabelVM? {
        willSet {
            setStyle(vm: newValue)
        }
        
        didSet {
            vm!.startCountdown { [weak self] remainingTimeString in
                self?.text = remainingTimeString
            }
        }
    }
    
    deinit {
        vm!.stopCountdown()
    }
    
    func setStyle(vm: CountdownLabelVM?) {
        guard let vm = vm else { return }
        
        backgroundColor = vm.backgroundColor
        font = vm.textFont
        textColor = vm.textColor
        alpha = vm.alpha
        text = vm.remainingTimeToLaunch
    }
}
