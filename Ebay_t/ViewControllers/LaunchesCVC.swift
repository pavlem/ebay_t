//
//  LaunchesCVC.swift
//  Ebay_t
//
//  Created by Pavle Mijatovic on 12.5.21..
//

import UIKit

class LaunchesCVC: UICollectionViewController, Storyboarded {

    // MARK: - API
    weak var coordinator: MainCoordinator?
    
    // MARK: - Properties
    private var launches = [LaunchVM]()
    private var filteredLaunches = [LaunchVM]() {
        didSet {
            DispatchQueue.main.async {
                self.refreshUI()
            }
        }
    }
    private var launchesVM: LaunchesVM! {
        didSet {
            updateUI()
        }
    }
    
    // Search
    private let searchController = UISearchController(searchResultsController: nil)
    private var isFiltering: Bool {
        return searchController.isActive && !isSearchBarEmpty
    }
    private var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
        
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setModels()
        setSearchController()
        setUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        fetchLaunches()
    }
    
    // MARK: - Helper
    private func refreshUI() {
        collectionView.reloadData()
    }
    
    private func setSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = launchesVM.searchPlaceholder
        searchController.searchBar.keyboardAppearance = .dark
        definesPresentationContext = true
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    private func fetchLaunches() {
        
        launchesVM.fetch(launchRequest: LaunchRequest(), completion: { [weak self] result in
   
            guard let `self` = self else { return }

            switch result {
            case .failure(let err):
                AlertHelper.simpleAlert(message: err.errorDescription, vc: self) {
                    self.launchesVM = LaunchesVM(isLoadingScreenShown: false)
                }
            case .success(let launches):
                self.launches = launches

                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.launchesVM = LaunchesVM(isLoadingScreenShown: false)
                    self.collectionView.reloadData()
                }
            }
        })
    }
    
    private func setModels() {
        launchesVM = LaunchesVM(isLoadingScreenShown: true)
    }
    
    private func setUI() {
        title = launchesVM.launchesListTitle
        collectionView.backgroundColor = launchesVM.backgroundColor
    }
    
    private func updateUI() {
        DispatchQueue.main.async {
            self.launchesVM.isLoadingScreenShown ? BlockingScreen.start(vc: self) : BlockingScreen.stop()
        }
    }
    
    private func filter(searchText: String) {
        filteredLaunches = launches.filter { (launchVM: LaunchVM) -> Bool in
            return
                launchVM.nameDescription.lowercased().contains(searchText.lowercased()) ||
                launchVM.launchDescription.lowercased().contains(searchText.lowercased()) ||
                launchVM.familyDescription.lowercased().contains(searchText.lowercased()) ||
                launchVM.locationDescription.lowercased().contains(searchText.lowercased())
        }
    }
}

// MARK: UICollectionViewDelegate
extension LaunchesCVC {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as? LaunchCell
        let img = cell?.launchImgView.image
        
        var launchVM: LaunchVM

        if isFiltering {
            launchVM = filteredLaunches[indexPath.row]
        } else {
            launchVM = launches[indexPath.row]
        }
        
        coordinator?.openLaunchDetails(vm: LaunchDetailsVM(launchVM: launchVM, image: img))
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension LaunchesCVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let vm = launches[indexPath.row]
        return CGSize(width: self.view.frame.size.width, height: vm.cellHeight)
    }
}

// MARK: - UICollectionViewDataSource
extension LaunchesCVC {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if isFiltering {
            return filteredLaunches.count
        } else {
            return launches.count
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LaunchCell.id, for: indexPath) as? LaunchCell else { return UICollectionViewCell() }
        
        
        var vm: LaunchVM

        if isFiltering {
            vm = filteredLaunches[indexPath.row]
        } else {
            vm = launches[indexPath.row]
        }

        cell.vm = vm
        return cell
    }
}

// MARK: - UISearchResultsUpdating
extension LaunchesCVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filter(searchText: searchController.searchBar.text!)
    }
}
