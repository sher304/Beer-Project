//
//  ViewController.swift
//  MVVMBeer
//
//  Created by Шермат Эшеров on 27/7/22.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    private lazy var viewModel: ViewModel = {
        return ViewModel()
    }()
    
    private lazy var searchBar: UISearchBar = {
        let searchB = UISearchBar()
        searchB.autocorrectionType = .no
        searchB.searchBarStyle = .minimal
        searchB.placeholder = "Search beer..."
        searchB.delegate = self
        return searchB
    }()
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.register(CustomCell.self, forCellReuseIdentifier: CustomCell.identifier)
        table.delegate = self
        table.dataSource = self
        table.separatorStyle = .none
        return table
    }()
    
    var beersList: [Beer] = []
    var didSearchet = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
        bindViewModel()
    }
}


//  MARK: Constraints
extension ViewController{
    func setupConstraints(){
        
        view.backgroundColor = .white
        
        let elements = [tableView, searchBar]
        for element in elements {
            view.addSubview(element)
        }
        
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(90)
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
            make.height.equalTo(45)
        }
        
        tableView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(searchBar.snp.bottom).offset(30)
        }
        
    }
    
//  MARK: BindwithViewModel
    func bindViewModel(){
        viewModel.fetchAllData()
        viewModel.items.bind { _ in
            DispatchQueue.main.async { [self] in
                self.tableView.reloadData()
            }
        }
    }
    
}


//  MARK: TableView Extension
extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if didSearchet{
            return beersList.count
        }else{
            return viewModel.items.value.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = CustomCell()
        if didSearchet{
            let items = beersList[indexPath.row]
            cell.fetchData(title: items.name, image: items.image_url, tagline: items.tagline, yearLabel: items.first_brewed)
        }else{
            let items = viewModel.items.value[indexPath.row]
            cell.fetchData(title: items.name, image: items.image_url, tagline: items.tagline, yearLabel: items.first_brewed)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 240
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var index = indexPath.row
        index += 1

//  MARK: Send Id & Open DetailViewController        
        let vc = DetailViewController()
        vc.getElementId(id: index.description)
        present(vc, animated: true, completion: nil)
    }
}


//  MARK: SearchBar Extension
extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let datas = viewModel.items.value
        beersList = datas.filter({$0.name.prefix(searchText.count) == searchText})
        didSearchet = true
        tableView.reloadData()
    }
}
