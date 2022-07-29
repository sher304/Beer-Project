//
//  DetailViewModel.swift
//  MVVMBeer
//
//  Created by Шермат Эшеров on 28/7/22.
//

import Foundation

protocol DetailDelegate{
    var idIndx: String { get set }
    func fetchById(id: String)
}

class DetailViewModel: DetailDelegate{
    
    var idIndx: String = ""
    private var network = Network()
    let items = Dynamic([Beer]())
    
    
//  MARK: Fetch Id From ViewController
    func fetchById(id: String){
        idIndx = id
    }
    
    func fetchData(){
        network.parseById(id: idIndx) { [self] datas in
            items.value = datas
        }
    }
    
}
