//
//  ViewModel.swift
//  MVVMBeer
//
//  Created by Шермат Эшеров on 27/7/22.
//

import Foundation

protocol ViewModelDelegate{
    func fetchAllData()
    var delegate: DetailDelegate? {get set}
}

class ViewModel: ViewModelDelegate{
    
    let items = Dynamic([Beer]())
    let networks = Network()
    var delegate: DetailDelegate?
    
    func fetchAllData() {
        networks.parse { [self] datas in
            items.value = datas
        }
    }
}
