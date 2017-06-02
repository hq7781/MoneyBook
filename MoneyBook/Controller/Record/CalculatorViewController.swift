//
//  CalculatorViewController.swift
//  MoneyBook
//
//  Created by HongQuan on 2017/05/01.
//  Copyright © 2017年 Roan.Hong. All rights reserved.
//

import UIKit
let D_calVC_name     = "CalVC"

class CalculatorViewController: UIViewController {
    //MARK: - ==========  var define ==========
    var delegate: RecordsViewControllerDelegate? = nil
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var lblResult: UILabel!
    
    var resultLbl: String = ""
    var result: Double!
    var checkBoo: Bool = true

    //MARK: - ========== override methods ==========
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        defaultInfo()
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - ========== init methods ==========
    func defaultInfo() {
        lblResult.text = "0"
        doneButton.setTitle("done", for: .normal)
        resultLbl = ""
        self.result = 0.0
    }
    
    //MARK: - ========== IBAction methods ==========
    @IBAction func doneButtonDidTap(_ sender: Any) {
        if doneButton.titleLabel?.text == "done" {
            if Double(lblResult.text!)! > 100000000000 {
                let alert = UIAlertController(title: "Warning!", message: "Its big data1 ", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } else {
                self.delegate?.sendValue(value: lblResult.text!,view: D_calVC_name)
                _ = self.navigationController?.popViewController(animated: true)
            }
        } else if doneButton.titleLabel?.text == "=" {
            self.checkBoo = false
            if !(resultLbl[resultLbl.length-1] == "+" || resultLbl[resultLbl.length-1] == "-" || resultLbl[resultLbl.length-1] == "x" || resultLbl[resultLbl.length-1] == "/" || resultLbl[resultLbl.length-1] == ".") {
                
                getResults(str: resultLbl)
                if self.result > 100000000000 {
                    let alert = UIAlertController(title: "Warning!", message: "Its big data2", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }else {
                    if (self.result < 0){
                        let alert = UIAlertController(title: "Warning!", message: "Its date < 0", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }else {
                        doneButton.setTitle("done", for: .normal)
                        resultLbl = String(UInt(self.result))
                        lblResult.text = String(UInt(self.result))
                    }
                }
            }
        }
    }
    
    @IBAction func dotDidTap(_ sender: UIButton) {
        if !getEqua(str: self.resultLbl, location: self.resultLbl.length-1) && self.resultLbl[self.resultLbl.length - 1] != "." && lblResult.text != "0" && doneButton.titleLabel?.text != "done"{
            resultLbl.append(".")
            lblResult.text = resultLbl
        }
    }
    @IBAction func numberDidTap(_ sender: UIButton) {
        var boo : Bool = true
        if (sender.titleLabel?.text == "0" || sender.titleLabel?.text == "000"){
            if !(getEqua(str: resultLbl, location: resultLbl.length-1) || resultLbl == "0" || resultLbl == "") {
                for i in resultLbl.characters {
                    if String(i) == "x" || String(i) == "+" || String(i) == "-" || String(i) == "/"{
                        boo = false
                        break
                    }
                }
                
                if boo {
                    doneButton.setTitle("done", for: .normal)
                } else {
                    doneButton.setTitle("=", for: .normal)
                }
                
                resultLbl.append((sender.titleLabel?.text)!)
                lblResult.text = resultLbl
            }
        } else {
            if !self.checkBoo {
                resultLbl = ""
            }
            for i in resultLbl.characters {
                if String(i) == "x" || String(i) == "+" || String(i) == "-" || String(i) == "/"{
                    boo = false
                    break
                }
            }
            
            if boo {
                doneButton.setTitle("done", for: .normal)
            } else {
                doneButton.setTitle("=", for: .normal)
            }
            
            resultLbl.append((sender.titleLabel?.text)!)
            lblResult.text = resultLbl
            self.checkBoo = true
        }
    }
    
    @IBAction func backSpaceButtonDidTap(_ sender: UIButton) {
        if !resultLbl.isEmpty{
            let truncated = resultLbl.substring(to: resultLbl.index(before: resultLbl.endIndex))
            resultLbl = truncated
            lblResult.text = resultLbl
        }
    }
    
    @IBAction func calcuDidTap(_ sender: UIButton) {
        if !resultLbl.isEmpty {
            self.checkBoo = true
            if doneButton.titleLabel?.text == "done" {
                doneButton.setTitle("=", for: .normal)
            }
            let last = resultLbl[resultLbl.index(before: resultLbl.endIndex)]
            if(last == "/" || last == "+" || last == "x" || last == "-" ){
                let truncated = resultLbl.substring(to: resultLbl.index(before: resultLbl.endIndex))
                resultLbl = truncated
                //lblResult.text = resultLbl
                resultLbl.append((sender.titleLabel?.text)!)
                lblResult.text = resultLbl
            }else {
                resultLbl.append((sender.titleLabel?.text)!)
                lblResult.text = resultLbl
            }
        }
        
    }
    
    @IBAction func refreshButtonDidTap(_ sender: UIButton) {
        defaultInfo()
    }
    

    //MARK: - ========== privete methods ==========
    func getResults(str : String) {
        var resultArr : [String] = []
        var remember : [Int] = [-1]
        var chuoi : String!
        for i in 0...str.length - 1 {
            if getEqua(str: str, location: i)  {
                if str[i] == "+" || str[i] == "-"{
                    chuoi = " " + str[i] + " "
                    resultArr.append(str[remember[remember.count - 1] + 1..<i])
                    resultArr.append(chuoi)
                    remember.append(i)
                } else {
                    resultArr.append(str[remember[remember.count - 1] + 1..<i])
                    resultArr.append(str[i])
                    remember.append(i)
                }
                
            } else if i == str.length - 1 {
                resultArr.append(str[remember[remember.count - 1] + 1..<i+1])
            }
        }
        actionCal(arr: resultArr)
    }
    
    func actionCal(arr: [String]) {
        var boo : Bool = true
        var boo1 : Bool = true
        var boo2 : Bool = false
        var arrNext: [String] = []
        var result1 : Double!
        print(arr.count)
        if arr.count == 1 {
            boo = false
            result1 = Double(arr[0])
        }
        if boo {
            for i in 0...arr.count - 1{
                if (arr[i] == "x" || arr[i] == "/" || arr[i] == " + " || arr[i] == " - ") {
                    if arr[i] == "x" {
                        result1 = Double(arr[i-1])! * Double(arr[i+1])!
                        boo2 = true
                        print(result1)
                    } else if arr[i] == "/"{
                        result1 = Double(arr[i-1])! / Double(arr[i+1])!
                        boo2 = true
                    } else if arr[i] == " + " || arr[i] == " - "{
                        for a in i+1...arr.count-1 {
                            if arr[a] == "x" || arr[a] == "/" {
                                boo1 = false
                                break
                            }
                        }
                        if boo1 {
                            if arr[i] == " + " {
                                result1 = Double(arr[i-1])! + Double(arr[i+1])!
                                boo2 = true
                            } else if arr[i] == " - " {
                                result1 = Double(arr[i-1])! - Double(arr[i+1])!
                                boo2 = true
                            }
                        }
                    }
                    if boo2 {
                        print(i)
                        for j in 0...arr.count - 1{
                            if !(j == i || j == i+1 || j == i-1){
                                arrNext.append(arr[j])
                            } else if j == i-1 {
                                arrNext.append(String(result1))
                            }
                        }
                        break
                    }
                }
            }
            actionCal(arr: arrNext)
            
        } else {
            self.result = result1
        }
    }
    
    func getEqua(str : String , location : Int)->Bool {
        var boo : Bool = false
        if str[location] == "x" || str[location] == "/" || str[location] == "+" || str[location] == "-"{
            boo = true
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
