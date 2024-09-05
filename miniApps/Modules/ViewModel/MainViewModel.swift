//
//  MainViewModel.swift
//  miniApps
//
//  Created by test on 05.09.2024.
//
import UIKit

class MainViewModel {
    
    private let miniApps: [MiniAppType] = [
        .fastViewController,
        .currencyViewController,
        .fastViewController,
        .currencyViewController,
        .fastViewController,
        .currencyViewController,
        .fastViewController,
        .currencyViewController,
        .fastViewController,
        .currencyViewController,
        .fastViewController,
        .currencyViewController
    ]
    
    var numberOfRows: Int {
        return miniApps.count
    }
    
    func heightForRow(at indexPath: IndexPath, screenHeight: CGFloat) -> CGFloat {
        return indexPath.row % 2 == 0 ? screenHeight / 8 : screenHeight / 2
    }
    
    func miniAppForRow(at indexPath: IndexPath) -> MiniAppType {
        return miniApps[indexPath.row]
    }
    
    func didSelectMiniApp(at indexPath: IndexPath) -> UIViewController {
        let selectedMiniApp = miniApps[indexPath.row]
        return selectedMiniApp.getViewController()
    }
}
