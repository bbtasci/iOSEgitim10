//
//  ViewController.swift
//  GamerStore
//
//  Created by Baris Berkin Tasci on 29.12.2020.
//

import UIKit

final class MainPageVC: UIViewController {
    
    // MARK: - OUTLETS
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var gamesCollectionView: UICollectionView!
    @IBOutlet weak var goToCartButton: UIButton!
    
    // MARK: - PROPERTIES
    
    var games = [GameBase]()
    
    // MARK: - LIFE CYCLE METHODS
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareItems()
        prepareUIMPVC()
        gamesCollectionView.reloadData()
        prepareNavigationItem()
        prepareCartButtonTitle()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        prepareCartButtonTitle()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        goGameDetail(game: games[indexPath.row])
    }
    
    // MARK: - PREPARE UI
    
    fileprivate func prepareItems() {
        let gameCOD = GameBase(gameName: "Call Of Duty Cold War", gamePrice: "120", gameImage: "cod-icongs", gameSize: "100 GB", gamePublisher: "Activision", releaseDate: "November 13th, 2020", gameType: "FPS", metaScore: "2.9/10")
        let gameCSGO = GameBase(gameName: "Counter-Strike: GO", gamePrice: "50", gameImage: "csgo-icongs", gameSize: "25 GB", gamePublisher: "Valve", releaseDate: "August 21st, 2012", gameType: "FPS", metaScore: "7.3/10")
        let gameFIFA = GameBase(gameName: "FIFA 21", gamePrice: "250", gameImage: "fifa21-icongs", gameSize: "50 GB", gamePublisher: "EA Sports", releaseDate: "October 9th, 2020", gameType: "Sports", metaScore: "1.2/10")
        let gameLOL = GameBase(gameName: "League of Legends", gamePrice: "40", gameImage: "lol-icongs", gameSize: "45 GB", gamePublisher: "Riot Games", releaseDate: "October 27th, 2009", gameType: "Role-Playing", metaScore: "5.3/10")
        let gameGTA = GameBase(gameName: "Grand Theft Auto V", gamePrice: "200", gameImage: "gtav-icongs", gameSize: "180 GB", gamePublisher: "Rockstar", releaseDate: "April 13th, 2015", gameType: "Adventure", metaScore: "7.8/10")
        let gameNFS = GameBase(gameName: "Need For Speed Heat", gamePrice: "80", gameImage: "nfs-icongs", gameSize: "10 GB", gamePublisher: "Electronic Arts", releaseDate: "November 8th, 2019", gameType: "Racing", metaScore: "5.4/10")
        let gameTLD = GameBase(gameName: "The Long Dark", gamePrice: "10", gameImage: "tld-icongs", gameSize: "5 GB", gamePublisher: "Hinterland Studio", releaseDate: "September 22nd, 2014", gameType: "Survival", metaScore: "5.4/10")
        let gameCP = GameBase(gameName: "CyberPunk 2077", gamePrice: "185", gameImage: "cp-icongs", gameSize: "110 GB", gamePublisher: "Richard Borzymowski", releaseDate: "December 10th, 2020", gameType: "Role-Playing", metaScore: "8.2/10")
        let gameMC = GameBase(gameName: "Minecraft", gamePrice: "20", gameImage: "mc-icongs", gameSize: "15 GB", gamePublisher: "Microsoft", releaseDate: "May 17th, 2009", gameType: "Open-World", metaScore: "6.6/10")
        
        
        games = [gameCOD, gameCSGO, gameFIFA, gameLOL, gameGTA, gameNFS, gameTLD, gameCP, gameMC]
    }
    
    fileprivate func prepareUIMPVC() {
        prepareLayer(object: logoImageView as Any)
        prepareLayer(object: gamesCollectionView as Any)
        prepareLayer(object: goToCartButton as Any)
        
        gamesCollectionView.delegate = self
        gamesCollectionView.dataSource = self
        gamesCollectionView.reloadData()
    }
    
    fileprivate func prepareLayer(object: Any) {
        if let object = object as? UIImageView {
            object.layer.cornerRadius = 5
            object.layer.masksToBounds = true
        } else if let object = object as? UIButton {
            object.layer.cornerRadius = 5
            object.layer.masksToBounds = true
        } else if let object = object as? UICollectionView {
            object.layer.cornerRadius = 5
            object.layer.masksToBounds = true
        }
    }
    
    fileprivate func prepareNavigationItem() {
        navigationItem.title = "GAMER STORE"
        navigationItem.backButtonTitle = "Back"
    }
    
    fileprivate func prepareCartButtonTitle() {
        gamesCollectionView.reloadData()
        goToCartButton.setTitle("GO TO CART - \(Singleton.shared.printedGame.count)", for: .normal)
    }
    
    // MARK: - ACTIONS
    
    @IBAction func goToCartButtonTouched(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let scvc = storyboard.instantiateViewController(identifier: "ShoppingCartVC") as! ShoppingCartVC
        navigationController?.pushViewController(scvc, animated: true)
    }
    
}

// MARK: - UITableViewDelegate - UITableViewData Source Methods

extension MainPageVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return games.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let game = games[indexPath.row]
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "gameCell", for: indexPath) as? GamesCollectionViewCell {
            cell.setCell(item: game)
            cell.layer.borderWidth = 0.5
            cell.layer.borderColor = UIColor.white.cgColor
            cell.layer.cornerRadius = 5
            cell.layer.masksToBounds = true
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func goGameDetail(game: GameBase) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "GameDetailsPageVC") as! GameDetailsPageVC
        vc.game = game
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

// MARK: - UICollectionViewDelegate FlowLayout Methods

extension MainPageVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        //let width: CGFloat = 150.0
        //let width = self.view.frame.width - 10 * 2
        
        let width = (self.view.frame.width - 60)/2
        let height: CGFloat = 150.0
        
        return CGSize(width: width, height: height)
    }
}
