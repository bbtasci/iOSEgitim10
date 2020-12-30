//
//  Singleton.swift
//  GamerStore
//
//  Created by Baris Berkin Tasci on 30.12.2020.
//

import Foundation

class Singleton {
    static let shared = Singleton()
    
    var printedGame: [GameBase] = []
}
