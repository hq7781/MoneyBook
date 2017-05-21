//
//  AnalysisViewController.swift
//  MoneyBook
//
//  Created by HongQuan on 2017/04/30.
//  Copyright © 2017年 Roan.Hong. All rights reserved.
//

import UIKit

class AnalysisViewController: UIViewController, UIScrollViewDelegate,
UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{

    private var pageControl: UIPageControl!
    private var scrollView: UIScrollView!
    
    //MARK: - ========== override methods ==========
    override func viewDidLoad() {
        super.viewDidLoad()
        // 背景の色をCyanに設定する.
        self.view.backgroundColor = UIColor.cyan
        
        // Do any additional setup after loading the view, typically from a nib.
        self.showPageScrollView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
            let myLabel:UILabel = UILabel(frame: CGRect(x: CGFloat(i) * width + width/2 - 40, y: height/2 - 40, width: 80, height: 80))
            myLabel.backgroundColor = UIColor.red
            myLabel.textColor = UIColor.white
            myLabel.textAlignment = NSTextAlignment.center
            myLabel.layer.masksToBounds = true
            myLabel.text = "Page\(i)"
            myLabel.font = UIFont.systemFont(ofSize: UIFont.smallSystemFontSize)
            myLabel.layer.cornerRadius = 40.0
            scrollView.addSubview(myLabel)
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

    //MARK: - ========== UIScrollViewDelegate ==========
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        // スクロール数が1ページ分になったら時.
        if fmod(scrollView.contentOffset.x, scrollView.frame.maxX) == 0 {
            // ページの場所を切り替える.
            pageControl.currentPage = Int(scrollView.contentOffset.x / scrollView.frame.maxX)
        }
    }

    //MARK: - ========== UICollectionViewDelegate ==========
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

