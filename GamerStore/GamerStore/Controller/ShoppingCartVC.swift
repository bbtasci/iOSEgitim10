//
//  ShoppingCartVC.swift
//  GamerStore
//
//  Created by Baris Berkin Tasci on 29.12.2020.
//

import UIKit

final class ShoppingCartVC: UIViewController {
    

    // MARK: - OUTLETS
    
    @IBOutlet weak var myCartLabel: UILabel!
    @IBOutlet weak var shoppingCartTableView: UITableView!
    @IBOutlet weak var totalCostLabel: UILabel!
    @IBOutlet weak var paymentButton: UIButton!
    
    // MARK: - PROPERTIES
    
    var listOfGamesAddedToCart: [GameBase] = []
    var totalCost: Int = 0
    
    // MARK: - LIFE CYCLE METHODS
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareUISCVC()
        prepareTableView()
        calcTotalCost()
    }
    
    // MARK: - PREPARE UI
    
    fileprivate func prepareUISCVC() {
        prepareLayer(object: myCartLabel as Any)
        prepareLayer(object: totalCostLabel as Any)
        prepareLayer(object: shoppingCartTableView as Any)
        prepareLayer(object: paymentButton as Any)
        
    }
    
    // MARK: - PREPARE LAYERS
    
    fileprivate func prepareLayer(object: Any) {
        if let object = object as? UILabel {
            object.layer.cornerRadius = 5
            object.layer.masksToBounds = true
        } else if let object = object as? UIButton {
            object.layer.cornerRadius = 5
            object.layer.masksToBounds = true
        } else if let object = object as? UITableView {
            object.layer.cornerRadius = 5
            object.layer.masksToBounds = true
        }
    }
    
    fileprivate func prepareTableView() {
        shoppingCartTableView.delegate = self
        shoppingCartTableView.dataSource = self
        //shoppingCartTableView.separatorStyle = .none
        shoppingCartTableView.register(UINib(nibName: "CartTableViewCell", bundle: nil), forCellReuseIdentifier: "CartTableViewCell")
        shoppingCartTableView.reloadData()
    }
    
    fileprivate func calcTotalCost() {
        totalCost = 0
        for item in Singleton.shared.printedGame {
            totalCost += Int(item.gamePrice)!
        }
        totalCostLabel.text = "TOTAL PRICE: $\(totalCost)"
    }

    // MARK: - ACTIONS
    
    @IBAction func paymentButtonTouched(_ sender: Any) {
        Singleton.shared.printedGame.removeAll()
        totalCostLabel.text = "Cart is empty!"
        shoppingCartTableView.reloadData()
    }

}

// MARK: - UITableViewDataSource Methods

extension ShoppingCartVC: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Singleton.shared.printedGame.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CartTableViewCell") as? CartTableViewCell {
            cell.setCartCell(item: Singleton.shared.printedGame[indexPath.row])
            cell.delegate = self
            return cell
        }
        
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

extension ShoppingCartVC: CartTableViewCellDelegate {
    func addGameToCart(addedGame: GameBase) {
    }
    
    func reloadData() {
        shoppingCartTableView.reloadData()
        calcTotalCost()
    }
    
    
}
