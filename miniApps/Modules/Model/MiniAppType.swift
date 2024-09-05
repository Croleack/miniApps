//
//  MiniAppType.swift
//  miniApps
//
//  Created by test on 04.09.2024.
//

import UIKit
import CurrencyPackage
import FastPackage

enum MiniAppType {
    case fastViewController
    case currencyViewController

    func getView() -> UIView {
        switch self {
        case .fastViewController:
            return FirstMiniAppView()
        case .currencyViewController:
            return CurrencyView()
        }
    }

    func getViewController() -> UIViewController {
        switch self {
        case .fastViewController:
            return PlayViewController()
        case .currencyViewController:
            return CurrencyViewController()
        }
    }
}
