//
//  AgreementViewController.swift
//  MoneyBook
//
//  Created by HongQuan on 2017/5/29.
//  Copyright © 2017年 Roan.Hong. All rights reserved.
//

import UIKit


class AgreementViewController: UIPageViewController /* UIViewController */, UIScrollViewDelegate {
    private var pageControl: UIPageControl!
    private var scrollView: UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        showPageScrollView()
        AppUtils.googleTracking("AgreementView")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

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

}
