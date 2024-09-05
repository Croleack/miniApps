//
//  ViewController.swift
//  miniApps
//
//  Created by test on 04.09.2024.
//

import UIKit

class MainViewController: UIViewController {
    //MARK: - Variables
    private let tableView = UITableView()
    private let viewModel = MainViewModel()
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    ///для айпадов
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        tableView.reloadData()
    }

    // MARK: - viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.topItem?.title = ""
    }
    
    // MARK: - functions
    private func setupUI() {
        title = Constants.titleName
        view.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.titleCell)
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

//MARK: - extension MainViewController
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let screenHeight = UIScreen.main.bounds.height
        return viewModel.heightForRow(at: indexPath, screenHeight: screenHeight)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.titleCell, for: indexPath)
        cell.contentView.subviews.forEach { $0.removeFromSuperview() }
        
        let miniAppView = viewModel.miniAppForRow(at: indexPath).getView()
        cell.contentView.addSubview(miniAppView)
        miniAppView.translatesAutoresizingMaskIntoConstraints = false
        miniAppView.layer.cornerRadius = Constants.miniAppCornerRadius
        miniAppView.clipsToBounds = true
        
        cell.backgroundColor = .systemBackground
        cell.layer.cornerRadius = Constants.cellCornerRadius
        cell.clipsToBounds = true

        NSLayoutConstraint.activate([
            miniAppView.topAnchor.constraint(equalTo: cell.contentView.topAnchor, constant: Constants.miniAppViewConstraint),
            miniAppView.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor, constant: -Constants.miniAppViewConstraint),
            miniAppView.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: Constants.miniAppViewConstraint),
            miniAppView.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -Constants.miniAppViewConstraint)
        ])
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewController = viewModel.didSelectMiniApp(at: indexPath)
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}

// MARK: - Constants
fileprivate extension MainViewController {
    
    enum Constants {
        static let miniAppViewConstraint = 16.0
        static let cellCornerRadius: CGFloat = 10.0
        static let miniAppCornerRadius: CGFloat = 15.0
        
        static let titleName = "Mini Apps"
        static let titleCell = "cell"
    }
}
