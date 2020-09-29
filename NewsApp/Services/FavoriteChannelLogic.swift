//
//  FavoriteChannelLogic.swift
//  TestNewsApp
//
//  Created by Станислав Климов on 28.09.2020.
//

import Foundation

class FavoriteChannelManager {
    
    static let shared = FavoriteChannelManager()
    private let key = "Favourite"
    
    init() {}
    
    
    func takeNewFavoriteChannel(with name: String) {
        if var arrayOfChannel = (UserDefaults.standard.array(forKey: key) ?? []) as? [String] {
            arrayOfChannel.append(name)
            UserDefaults.standard.setValue(arrayOfChannel, forKey: key)
        } else {
            let arrayOfChannel: [String] = [name]
            UserDefaults.standard.setValue(arrayOfChannel, forKey: key)
        }
        
    }
    
    func checkFavoriteChannel(with name: String) -> Bool {
        var favorite = false
        guard let arrayString = UserDefaults.standard.array(forKey: key) as? [String] else { return false }
        for item in arrayString {
            if item == name {
                favorite = true
            }
        }
        return favorite
    }
    
    func fetchFavoriteChannels() -> [String]? {
        guard let array = UserDefaults.standard.array(forKey: key) as? [String] else { return []}
        return array
    }
    
    func deleteFromFavorite(with name: String) {
        guard var array = fetchFavoriteChannels() else { return }
        for (index, item) in array.enumerated() {
            if item == name {
                if index >= array.count {
                    let newIndex = array.count - 1
                    array.remove(at: newIndex)
                } else {
                array.remove(at: index)
                }
            }
        }
        UserDefaults.standard.setValue(array, forKey: key)
    }
    
    
    
    
}
