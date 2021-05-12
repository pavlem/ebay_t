//
//  MainCoordinator.swift
//  Ebay_t
//
//   Created by Pavle Mijatovic on 12.5.21..
//

import UIKit

class MainCoordinator: Coordinator {
    var childCoordinator = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = LaunchesCVC.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func openLaunchDetails(vm: LaunchDetailsVM) {
        let vc = LaunchDetailsVC.instantiate()
        vc.vm = vm
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func openWebView(urlString: String) {
        let vc = WebVC()
        vc.urlString = urlString
        navigationController.pushViewController(vc, animated: true)
    }
}
