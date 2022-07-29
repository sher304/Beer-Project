//
//  Dynamic.swift
//  MVVMBeer
//
//  Created by Шермат Эшеров on 27/7/22.
//

import Foundation


class Dynamic<T>{
    
    typealias Listener = (T) -> ()
    private var listener: Listener?
    
    func bind(_ listener: Listener?){
        self.listener = listener
    }
    
    var value: T {
        didSet{
            listener?(value)
        }
    }
    
    init(_ v: T){
        self.value = v
    }
    
}
