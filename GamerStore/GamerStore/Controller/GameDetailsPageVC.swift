//
//  GameDetailsPageVC.swift
//  GamerStore
//
//  Created by Baris Berkin Tasci on 29.12.2020.
//

import Foundation
import UIKit

final class GameDetailsPageVC: UIViewController {
    
    // MARK: - OUTLETS
    
    @IBOutlet weak var gameNameLabel: UILabel!
    @IBOutlet weak var gameImageView: UIImageView!
    @IBOutlet weak var gameReleaseDateLabel: UILabel!
    @IBOutlet weak var gameTypeLabel: UILabel!
    @IBOutlet weak var gameSizeLabel: UILabel!
    @IBOutlet weak var gamePublisher: UILabel!
    @IBOutlet weak var gameMetascoreLabel: UILabel!
    @IBOutlet weak var gamePriceLabel: UILabel!
    @IBOutlet weak var addToCartButton: UIButton!
    
    // MARK: - PROPERTIES
    
    var game: GameBase?

    // MARK: - LIFE CYCLE METHODS
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareUIGDPVC()
        prepareLabels()
        
    }
    
    // MARK: - PREPARE UI
    
    fileprivate func prepareUIGDPVC() {
        prepareLayer(object: gameNameLabel as Any)
        prepareLayer(object: gameImageView as Any)
        prepareLayer(object: gameReleaseDateLabel as Any)
        prepareLayer(object: gameTypeLabel as Any)
        prepareLayer(object: gameSizeLabel as Any)
        prepareLayer(object: gamePublisher as Any)
        prepareLayer(object: gameMetascoreLabel as Any)
        prepareLayer(object: gamePriceLabel as Any)
        prepareLayer(object: addToCartButton as Any)
    }
    
    fileprivate func prepareLayer(object: Any) {
        if let object = object as? UILabel {
            object.layer.cornerRadius = 5
            object.layer.masksToBounds = true
        } else if let object = object as? UIButton {
            object.layer.cornerRadius = 5
            object.layer.masksToBounds = true
        } else if let object = object as? UIImageView {
            object.layer.cornerRadius = 5
            object.layer.masksToBounds = true
        }
    }
    
    fileprivate func prepareLabels() {
        gameNameLabel.text = (game?.gameName)?.uppercased()
        gameImageView.image = UIImage(named: game!.gameImage)
        gameReleaseDateLabel.text = "released on \(game!.releaseDate)"
        gameTypeLabel.text = game!.gameType
        gameSizeLabel.text = game!.gameSize
        gamePublisher.text = "created by " + "\(game!.gamePublisher)"
        gameMetascoreLabel.text = "metascore \(game!.metaScore)"
        gamePriceLabel.text = "$\(game!.gamePrice)"
    }
    
    // MARK: - ALERT METHOD
    
    fileprivate func addedToCartAlert() {
        let addedToCarAlert = UIAlertController(title: "", message: "\(game!.gameName) is added to cart!", preferredStyle: .alert)
        //addedToCarAlert.view.backgroundColor = UIColor.green
        self.present(addedToCarAlert, animated: true, completion: nil)
        
        let when = DispatchTime.now() + 1
        DispatchQueue.main.asyncAfter(deadline: when){
            addedToCarAlert.dismiss(animated: true, completion: nil)
        }
    }
    
    // MARK: - ACTIONS
    
    @IBAction func addToCartButtonTouched(_ sender: Any) {
        Singleton.shared.printedGame.append(game!)
        addedToCartAlert()
    }
    
}
