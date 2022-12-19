//
//  RickAndMortyViewController.swift
//  RickAndMortyWithoutSB
//
//  Created by Mahmut Gazi Doğan on 17.12.2022.
//

import UIKit
import SnapKit

protocol RickAndMortyOutput {
    func changeLoading(isLoad: Bool)
    func saveDatas()
}

final class RickAndMortyViewController: UIViewController {
    private let labelTitle: UILabel = UILabel()
    private let tableView: UITableView = UITableView()
    private let indicator: UIActivityIndicatorView = UIActivityIndicatorView()
    lazy var viewModel: IRickAndMortyViewModel = RickAndMortyViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        viewModel.setDelegate(output: self)
        viewModel.fetchItems()
    }
    
    private func configure(){
        view.addSubview(labelTitle)
        view.addSubview(tableView)
        view.addSubview(indicator)
        
        drawDesign()
        makeTableView()
        makeLabel()
        makeIndicator()
    }
    
    private func drawDesign() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RickAndMortyTableViewCell.self, forCellReuseIdentifier: RickAndMortyTableViewCell.Identifier.custom.rawValue)
        tableView.rowHeight = 150	
        DispatchQueue.main.async {
            self.view.backgroundColor = .white
            self.labelTitle.font = .boldSystemFont(ofSize: 25)
            self.labelTitle.text = "Rick And Morty"
            self.indicator.color = .red
        }
        indicator.startAnimating()
    }
    
}

extension RickAndMortyViewController: RickAndMortyOutput {
    func changeLoading(isLoad: Bool) {
        isLoad ? indicator.startAnimating(): indicator.stopAnimating()
    }
    
    func saveDatas() {
        tableView.reloadData()
    }
}

extension RickAndMortyViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.rickAndMortyCharacters.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: RickAndMortyTableViewCell = tableView.dequeueReusableCell(withIdentifier: RickAndMortyTableViewCell.Identifier.custom.rawValue) as? RickAndMortyTableViewCell else {
            return UITableViewCell()
        }
        
        cell.saveModel(model: viewModel.rickAndMortyCharacters[indexPath.row])
        
        return cell
    }
}


extension RickAndMortyViewController {
    
    private func makeTableView() {
        tableView.snp.makeConstraints { make in
            make.top.equalTo(labelTitle.snp.bottom).offset(5)
            make.bottom.equalToSuperview()
            make.left.right.equalTo(labelTitle)
        }
    }
    
    private func makeLabel() {
        labelTitle.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.left.equalTo(view).offset(10)
            make.right.equalTo(view).offset(-10)
            make.height.greaterThanOrEqualTo(10)
        }
    }
    
    private func makeIndicator() {
        indicator.snp.makeConstraints { make in
            make.height.equalTo(labelTitle)
            make.right.equalTo(labelTitle).offset(-5)
            make.top.equalTo(labelTitle)
        }
    }
    
}
