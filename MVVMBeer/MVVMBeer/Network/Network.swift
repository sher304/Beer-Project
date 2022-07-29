//
//  Network.swift
//  MVVMBeer
//
//  Created by Шермат Эшеров on 27/7/22.
//

import Foundation

protocol NetworkDelegate {
    func parse(comp: @escaping ([Beer]) -> Void)
    func parseById(id: String, comp: @escaping ([Beer]) -> Void)
}


class Network: NetworkDelegate{
    let session = URLSession.shared

    func parse(comp: @escaping ([Beer]) -> Void) {
        guard let url = URL(string: "https://api.punkapi.com/v2/beers") else { return }
        session.dataTask(with: url) { data, _, _ in
            DispatchQueue.main.async {
                guard let data = data else {
                    return
                }
                guard let responce = try? JSONDecoder().decode([Beer].self, from: data) else { return }
                comp(responce)
            }
        }.resume()
    }

    func parseById(id: String, comp: @escaping ([Beer]) -> Void){
        guard let url = URL(string: "https://api.punkapi.com/v2/beers/\(id)") else { return }
        session.dataTask(with: url) { data, _, _ in
            DispatchQueue.main.async {
                guard let data = data else {
                    return
                }
                guard let request = try? JSONDecoder().decode([Beer].self, from: data) else { return }
                comp(request)
            }
        }.resume()
    }
}
