//
//  FavoriteStops.swift
//  MHDTabula
//
//  Created by Jakub Jelínek on 23/07/2022.
//

import Foundation

class FavoriteStops: ObservableObject {
    private var favoriteStops: Set<Int>
    
    private let saveKey = "FavoriteStops"
    
    init() {
        
        guard let savedData = UserDefaults.standard.array(forKey: self.saveKey) as? [Int]
        else {
            self.favoriteStops = []
            return
        }
        self.favoriteStops = Set(savedData)
    }
    
    func contains(_ stop: Stop) -> Bool {
        return self.favoriteStops.contains(stop.value)
    }
    
    func add(_ stop: Stop) -> Void {
        objectWillChange.send()
        self.favoriteStops.insert(stop.value)
        save()
    }
    
    func remove(_ stop: Stop) -> Void {
        objectWillChange.send()
        self.favoriteStops.remove(stop.value)
        save()
    }
    
    func save() {
        UserDefaults.standard.set(Array(self.favoriteStops), forKey: self.saveKey)
        print("saved")
    }
}
