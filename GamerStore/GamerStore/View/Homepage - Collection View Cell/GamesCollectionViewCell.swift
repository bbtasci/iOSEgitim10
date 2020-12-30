//
//  GamesCollectionViewCell.swift
//  GamerStore
//
//  Created by Baris Berkin Tasci on 29.12.2020.
//

import UIKit

protocol GamesCollectionViewCellDelegate: class {
    func goGameDetail(game: GameBase)
}

class GamesCollectionViewCell: UICollectionViewCell {
    
    // MARK: - OUTLETS
    
    @IBOutlet weak var gameImageView: UIImageView!
    @IBOutlet weak var gameNameLabel: UILabel!
    
    // MARK: - PROPERTIES
    
    weak var delegate: GamesCollectionViewCellDelegate?
    private var game: GameBase?
    
    // MARK: - CUSTOM METHODS
    
    func setCell(item: GameBase) {
        gameImageView.image = UIImage(named: item.gameImage)
        gameNameLabel.text = item.gameName
    }
    
    
}
