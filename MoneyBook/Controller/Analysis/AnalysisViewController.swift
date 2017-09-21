//
//  AnalysisViewController.swift
//  MoneyBook
//
//  Created by HongQuan on 2017/04/30.
//  Copyright © 2017年 Roan.Hong. All rights reserved.
//

import UIKit
import Persei

let k_CELLNAME_AnalysisMenuTableViewCell: String = "AnalysisMenuCell"

class AnalysisViewController: UIViewController {

    fileprivate var pageControl: UIPageControl!
    fileprivate var scrollView: UIScrollView!

    fileprivate var menu: MenuView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var AnalysisMenuCell: UITableViewCell!
    
    //MARK: - ========== override methods ==========
    override func viewDidLoad() {
        super.viewDidLoad()
        // 背景の色をCyanに設定する.
        self.view.backgroundColor = UIColor.cyan
        title = model.description
        // Do any additional setup after loading the view, typically from a nib.

        self.LoadMenuView()
        self.showPageScrollView()
        AppUtils.googleTracking("AnalysisView")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func LoadMenuView() {
        DispatchQueue.main.async(execute: {
            self.imageView = UIImageView()
            self.imageView.image = self.model.image
            
            self.menu = {
                let menu = MenuView()
                menu.delegate = self
                menu.items = self.items
                return menu
            }()
            
            self.tableView.addSubview(self.menu)
        })
    }
    // MARK: - Items
    fileprivate let items = (0..<7).map {
        MenuItem(image: UIImage(named: "menu_icon_\($0)")!)
    }
    // MARK: - Model
    fileprivate var model: ContentType = .income {
        didSet {
            title = model.description
            
            if isViewLoaded {
                let center: CGPoint = {
                    let itemFrame = menu.frameOfItem(at: menu.selectedIndex!)
                    let itemCenter = CGPoint(x: itemFrame.midX, y: itemFrame.midY)
                    var convertedCenter = imageView.convert(itemCenter, from: menu)
                    convertedCenter.y = 0
                    
                    return convertedCenter
                }()
                
                let transition = CircularRevealTransition(layer: imageView.layer, center: center)
                transition.start()
                
                imageView.image = model.image
            }
        }
    }
    
    // MARK: - Actions ->>>  link to storyboad pls
    @IBAction fileprivate func switchMenu() {
        menu.setRevealed(!menu.revealed, animated: true)
    }
    
    // MARK: - show PageScrollview View
    func showPageScrollView() {
        // Update the user interface for the detail item.
        // ビューの縦、横のサイズを取得する.
        let width = self.view.frame.maxX, height = self.view.frame.maxY
        scrollView = UIScrollView(frame: self.view.frame)
        // ページ数を定義する.
        let pageSize = 6
        // 縦方向と、横方向のインディケータを非表示にする.
        scrollView.showsHorizontalScrollIndicator = false;
        scrollView.showsVerticalScrollIndicator = false
        // ページングを許可する.
        scrollView.isPagingEnabled = true
        // ScrollViewのデリゲートを設定する.
        scrollView.delegate = self
        // スクロールの画面サイズを指定する.
        scrollView.contentSize = CGSize(width: CGFloat(pageSize) * width, height: 0)
        // ScrollViewをViewに追加する.
        self.view.addSubview(scrollView)
        
        // ページ数分ボタンを生成する.
        for i in 0 ..< pageSize {
            // ページごとに異なるラベルを生成する.
            let hintLabel:UILabel = UILabel(frame: CGRect(x: CGFloat(i) * width + width/2 - 40, y: height/2 - 40, width: 80, height: 80))
            hintLabel.backgroundColor = UIColor.red
            hintLabel.textColor = UIColor.white
            hintLabel.textAlignment = NSTextAlignment.center
            hintLabel.layer.masksToBounds = true
            hintLabel.text = "Page\(i)"
            hintLabel.font = UIFont.systemFont(ofSize: UIFont.smallSystemFontSize)
            hintLabel.layer.cornerRadius = 40.0
            scrollView.addSubview(hintLabel)
        }
        // PageControlを作成する.
        pageControl = UIPageControl(frame: CGRect(x:0, y:self.view.frame.maxY - 100, width:width, height:50))
        pageControl.backgroundColor = UIColor.orange
        // PageControlするページ数を設定する.
        pageControl.numberOfPages = pageSize
        pageControl.currentPageIndicatorTintColor = UIColor.yellow
        // 現在ページを設定する.
        pageControl.currentPage = 0
        pageControl.isUserInteractionEnabled = false
        self.view.addSubview(pageControl)
        
    }
}

// MARK: - ========== UIScrollViewDelegate ==========
extension AnalysisViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // スクロール数が1ページ分になったら時.
        if fmod(scrollView.contentOffset.x, scrollView.frame.maxX) == 0 {
            // ページの場所を切り替える.
            pageControl.currentPage = Int(scrollView.contentOffset.x / scrollView.frame.maxX)
        }
    }
}

// MARK: - ========== UITableViewDelegate, UITableViewDataSource ==========
extension AnalysisViewController: UITableViewDelegate, UITableViewDataSource{

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    /// Tells the data source to return the number of rows in a given section of a table view.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: k_CELLNAME_AnalysisMenuTableViewCell, for: indexPath) as? AnalysisMenuTableViewCell
            //let cell = self.AnalysisMenuCell as UITableViewCell
            //cell?.imgView.image = nil //UIImage(named: data[indexPath.row].image)
            cell?.textLabel?.text = "Text"
            cell?.detailTextLabel?.text = "detailText"
            return cell!
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexPath = tableView.indexPathForSelectedRow
        _ = tableView.cellForRow(at: indexPath!)!
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.frame.size.height / 12
    }
}

// MARK: - MenuViewDelegate
extension AnalysisViewController: MenuViewDelegate {
    func menu(_ menu: MenuView, didSelectItemAt index: Int) {
        model = model.next()
    }
}

// MARK: - ========== UICollectionViewDelegate ==========
extension AnalysisViewController: UICollectionViewDelegate,
UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    // PlayerCollectionView
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return BankManager.shared.players.count + 1 // Bank + Players
        return 1
    }
    
    @available(iOS 6.0, *)
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            // StatisticalCell Cell
            let bankCell = collectionView.dequeueReusableCell(withReuseIdentifier: "StatisticalCell", for: indexPath)
            return bankCell
        } else {
            // AnalysisCell Cell
            let playerCell = collectionView.dequeueReusableCell(withReuseIdentifier: "AnalysisCell", for: indexPath) //as! PlayerCollectionViewCell
            //let player = BankManager.shared.players[indexPath.item-1]
            //            playerCell.nameLabel.text = ""//player.name
            // playerCell.balanceLabel.text = BankManager.shared.numberFormatter.string(from: player.balance as NSNumber)!
            //            if player.balance > 0 {
            //                playerCell.balanceLabel.textColor = UIColor.black
            //            } else {
            //                playerCell.balanceLabel.textColor = UIColor.red
            //            }
            //            playerCell.tokenView.image = UIImage(named: player.token.rawValue)?.withRenderingMode(.alwaysTemplate)
            return playerCell
        }
    }
    
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    //        if indexPath.item == 0 {
    //            return bankCellSize
    //        } else {
    //            return playerCellSize
    //        }
    //    }
    
    //    var bankCellSize: CGSize {
    //        let flowLayout = playerCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
    //        let horizintalInsets = flowLayout.sectionInset.left+flowLayout.sectionInset.right
    //        return CGSize(width: playerCollectionView.bounds.width-horizintalInsets, height: playerCollectionView.bounds.height/8)
    //    }
    //
    //    var playerCellSize: CGSize {
    //        let flowLayout = playerCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
    //        let horizintalInsets = flowLayout.sectionInset.left+flowLayout.sectionInset.right
    //        let verticalInsets = flowLayout.sectionInset.top + flowLayout.sectionInset.bottom
    //
    //        let horizontalSpace = horizintalInsets + (flowLayout.minimumInteritemSpacing * (numberOfPlayersPerRow - 1))
    //        let width = (playerCollectionView.bounds.width-horizontalSpace)/numberOfPlayersPerRow
    //
    //        let verticalSpace = verticalInsets + (flowLayout.minimumLineSpacing * ceil(CGFloat(maxPlayers)/numberOfPlayersPerRow))
    //        let height = (playerCollectionView.bounds.height-verticalSpace-(playerCollectionView.bounds.height/8))/ceil(CGFloat(maxPlayers)/numberOfPlayersPerRow)
    //
    //        return CGSize(width: width, height: height)
    //    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //        if indexPath.item != 0 {
        //            let cell = collectionView.cellForItem(at: indexPath)!
        //            let player = BankManager.shared.players[indexPath.item-1]
        //            let playerAlertController = UIAlertController(title: "\(player.name): \(BankManager.shared.numberFormatter.string(from: player.balance as NSNumber)!)", message: "What do you want to do with this player?", preferredStyle: .actionSheet)
        //            //
        //            playerAlertController.popoverPresentationController?.sourceView = cell.contentView
        //            playerAlertController.popoverPresentationController?.sourceRect = cell.contentView.frame
        //            let quickAddAction = UIAlertAction(title: "Add \(BankManager.shared.numberFormatter.string(from: BankManager.shared.quickAddAmount as NSNumber)!)", style: .default, handler: { action in
        //                player.balance += BankManager.shared.quickAddAmount
        //                BankManager.shared.save()
        //                collectionView.reloadData()
        //            })
        //            playerAlertController.addAction(quickAddAction)
        //            let renameAction = UIAlertAction(title: "Rename", style: .default, handler: { action in
        //                let renameAlertController = UIAlertController(title: "Rename Player", message: "Enter a new name for \(player.name).", preferredStyle: .alert)
        //                renameAlertController.addTextField(configurationHandler: { $0.autocapitalizationType = .words })
        //                let okAction = UIAlertAction(title: "OK", style: .default, handler: { action in
        //                    if !renameAlertController.textFields!.first!.text!.isEmpty {
        //                        player.name = renameAlertController.textFields!.first!.text!
        //                        BankManager.shared.save()
        //                        collectionView.reloadData()
        //                    }
        //                })
        //                renameAlertController.addAction(okAction)
        //                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        //                renameAlertController.addAction(cancelAction)
        //                self.present(renameAlertController, animated: true)
        //            })
        //            playerAlertController.addAction(renameAction)
        //            let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: { action in
        //                BankManager.shared.players.remove(at: indexPath.item-1)
        //                BankManager.shared.save()
        //                collectionView.reloadData()
        //                self.playerNumberChanged()
        //            })
        //            playerAlertController.addAction(deleteAction)
        //            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        //            playerAlertController.addAction(cancelAction)
        //            present(playerAlertController, animated: true)
        //        }
    }

}
