//
//  CartTableViewCell.swift
//  GamerStore
//
//  Created by Baris Berkin Tasci on 29.12.2020.
//

import UIKit

protocol CartTableViewCellDelegate: class {
    func addGameToCart(addedGame: GameBase)
    func reloadData()
}


class CartTableViewCell: UITableViewCell {
    
    @IBOutlet weak var gameNameLabel: UILabel!
    @IBOutlet weak var gamePriceLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    
    private var selectedItem: GameBase?
    weak var delegate: CartTableViewCellDelegate?
    private var addedGame: GameBase?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCartCell(item: GameBase) {
        selectedItem = item
        gameNameLabel.text = (item.gameName).uppercased()
        gamePriceLabel.text = "$\(item.gamePrice)"
    }
    
    @IBAction func deleteButtonTouched(_ sender: Any) {
        //Delete'e basınca ShoppingCartVC'de row silmeli. Şimdilik çalışmıyor.
        Singleton.shared.printedGame = Singleton.shared.printedGame.filter({
            $0.gameName != self.selectedItem?.gameName
        })
        delegate?.reloadData()
    }
    
}
