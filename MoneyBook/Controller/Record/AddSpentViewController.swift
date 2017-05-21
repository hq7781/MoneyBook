//
//  AddSpentViewController.swift
//  MoneyBook
//
//  Created by HongQuan on 2017/05/01.
//  Copyright © 2017年 Roan.Hong. All rights reserved.
//

import UIKit

let D_addSpentVC_name = "AddSpentVC"

protocol AddSpentViewControllerDelegate {
    func setData(str: String)
}


class AddSpentViewController: UIViewController, AddSpentViewControllerDelegate {
    //MARK: - ========== internal methods ==========
    internal func setData(str: String) {
        lblParent.text = str
    }
    //MARK: - ==========  var define ==========
    var delegate : SpentViewControllerDelegate? = nil
    
    @IBOutlet var viewParent: UIView!
    @IBOutlet var tfName: UITextField!
    @IBOutlet var lblParent: UILabel!
    @IBOutlet var tfStatus: UITextField!
    
    //MARK: - ========== override methods ==========
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        lblParent.text = ""
        let gesture = UITapGestureRecognizer(target: self, action:  #selector (self.someAction (_:)))
        self.viewParent.addGestureRecognizer(gesture)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - ========== ViewController methods ==========
    func someAction(_ sender:UITapGestureRecognizer){
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: D_ParentVC_name) as! ParentViewController
        secondViewController.delegate = self as AddSpentViewControllerDelegate
        self.navigationController?.pushViewController(secondViewController, animated: true)
    }
    
    //MARK: - ========== IBACtions ==========
    @IBAction func doneDidTap(_ sender: UIButton) {
        if checkBoo() {
            let child = ChildIndex()
            child.childName = tfName.text!
            child.status = tfStatus.text!
            DB.share().insertChildToParentIndex( lblParent.text!, child : child)

            self.delegate?.reloadData()
            self.navigationController?.popViewController(animated: true)
        } else {
            let alert = UIAlertController(title: "Ops!!", message: "Something went wrong", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    //MARK: - ========== privete methods ==========
    func checkBoo() -> Bool {
        var boo = true
        if tfName.text == "" || lblParent.text == ""{
            boo = false
        }
        return boo
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
