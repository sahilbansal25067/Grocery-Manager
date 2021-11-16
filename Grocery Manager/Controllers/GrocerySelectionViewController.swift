//
//  ViewController.swift
//  Grocery Manager
//
//  Created by Sahil Kumar Bansal on 13/11/21.
//

import UIKit
import Foundation
let defaults = UserDefaults()


class GrocerySelectionViewController: UIViewController {
    var groceryList = [
        "Soap" , "Shampoo" , "Biscuits" , "Bread" , "Rice" , "Pasta" , "Cereals" , "Cheese"
    ]
    var groceryPrices : [UInt16] =  [50,200,30,35,100,55,76,90]
    var groceryCount  : [UInt16] = [0,0,0,0,0,0,0,0]
    let cellName = "groceryCountCell"
    let groceryListKey = "groceries"
    let priceskey = "prices"
    let countKey  = "counts"
    @IBOutlet var tableView : UITableView!
    @IBOutlet var doneButton : UIButton!
    @IBAction func doneButtonclicked()
    {
        let viewController:UIViewController = (UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "List") as! GroceryListViewController)
        self.present(viewController, animated: false, completion: nil)
        
        //        let vc = GroceryListViewController()
        //        vc.groceryPrices = groceryPrices
        //        vc.groceryCount = groceryCount
        //        vc.groceryList = groceryList
        //        navigationController?.pushViewController(vc, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        title  = "Grocery Manager"
        setDefaults()
        tableViewConfigure()
        doneButtonUI()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAddButton))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(cleanBasket))
        tableView.reloadData()
    }
    @objc private func cleanBasket()
    {
        let alert = UIAlertController(title: "Clean Basket",
                                      message: "Are your sure you want to clean the basket?",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes",
                                      style: .default,
                                      handler: {[weak self] _ in
            guard let strongSelf = self else {
                return
            }
            for i in 0...strongSelf.groceryList.count-1{
                strongSelf.groceryCount[i] = 0
            }
            defaults.setValue(strongSelf.groceryCount, forKey: strongSelf.countKey)
            strongSelf.tableView.reloadData()
        }))
        alert.addAction(UIAlertAction(title: "No", style: .default, handler: nil))
        present(alert,animated: true)
        
    }
    @objc private func didTapAddButton()
    {
        let vc = AddGroceryViewController()
        
        vc.saveHandler = {[weak self] gName,gPrice
            in
            guard let strongSelf = self else {return }
            for i in 0...strongSelf.groceryList.count - 1{
                if strongSelf.groceryList[i] == gName
                {
                    let alert = UIAlertController(title: "Alert",
                                                  message: "Item was already present",
                                                  preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: {_ in return}))
                    strongSelf.dismiss(animated: true, completion: nil)
                    strongSelf.present(alert,animated: true)
                    return
                }
            }
            strongSelf.groceryList.append(gName)
            strongSelf.groceryPrices.append(gPrice)
            strongSelf.groceryCount.append(0)
            defaults.setValue(strongSelf.groceryList, forKey: strongSelf.groceryListKey)
            defaults.setValue(strongSelf.groceryPrices, forKey: strongSelf.priceskey)
            defaults.setValue(strongSelf.groceryCount, forKey: strongSelf.countKey)
            
            strongSelf.tableView.reloadData()
        }
        //        vc.modalPresentationStyle = .overCurrentContext
        //        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true, completion: nil)
        //        navigationController?.pushViewController(vc, animated: true)
    }
    //checking if userDefaults were set previously or not, if it were set then groceries dict is set from it
    private func setDefaults()
    {
        guard let items = defaults.value(forKey: groceryListKey) as? [String] ,let prices = defaults.value(forKey: priceskey) as? [UInt16] , let counts = defaults.value(forKey: countKey) as? [UInt16] else {
            defaults.setValue(groceryList, forKey: groceryListKey)
            defaults.setValue(groceryPrices, forKey: priceskey)
            defaults.setValue(groceryCount, forKey: countKey)
            return
        }
//        guard let prices = defaults.value(forKey: priceskey) as? [UInt16] else {
//            defaults.setValue(groceryPrices, forKey: priceskey)
////            return
//        }
//        guard let counts = defaults.value(forKey: countKey) as? [UInt16] else {
//            defaults.setValue(groceryCount, forKey: countKey)
//            return
//        }
        groceryList = items
        groceryPrices = prices
        groceryCount = counts
        
    }
    private func doneButtonUI(){
        doneButton.setTitle("Get Grocery List", for: .normal)
        doneButton.backgroundColor = .link
        doneButton.setTitleColor(.white, for: .normal)
        doneButton.layer.cornerRadius = 12
        doneButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        
    }
    private func tableViewConfigure()
    {
        
        tableView.dataSource = self
        tableView.delegate = self
        let  nib = UINib(nibName: cellName, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: cellName)
    }
    
    
}
extension GrocerySelectionViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = EditGroceryViewController()
        vc.initalCost  = String(groceryPrices[indexPath.row])
        vc.initalName  = String(groceryList[indexPath.row])
        vc.editHandler = {[weak self] gName,gPrice
            in
            guard let strongSelf = self else {return }
            strongSelf.groceryList[indexPath.row] = gName
            strongSelf.groceryPrices[indexPath.row] = gPrice
            defaults.setValue(strongSelf.groceryList, forKey: strongSelf.groceryListKey)
            defaults.setValue(strongSelf.groceryPrices, forKey: strongSelf.priceskey)
            strongSelf.tableView.reloadData()
        }
        vc.deleteHandler = {
            [weak self]
            in
            guard let strongSelf = self else {return }
            strongSelf.groceryList.remove(at: indexPath.row)
            strongSelf.groceryCount.remove(at: indexPath.row)
            strongSelf.groceryPrices.remove(at: indexPath.row)
            defaults.setValue(strongSelf.groceryList, forKey: strongSelf.groceryListKey)
            defaults.setValue(strongSelf.groceryPrices, forKey: strongSelf.priceskey)
            defaults.setValue(strongSelf.groceryCount, forKey: strongSelf.countKey)
            
            strongSelf.tableView.reloadData()
            
        }
        //        vc.modalPresentationStyle = .overCurrentContext
        //        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true, completion: nil)
        //        navigationController?.pushViewController(vc, animated: true)
    }
}
extension GrocerySelectionViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellName, for: indexPath) as? groceryCountCell else {return UITableViewCell()}
        cell.tableGroceryNameLabel.text = groceryList[indexPath.row]
        cell.count = String(groceryCount[indexPath.row])
        cell.totalCost = Int(groceryCount[indexPath.row]) * Int(groceryPrices[indexPath.row])
        cell.tableHandler = {[weak self]
            count in
            guard let strongSelf = self else {return }
            strongSelf.groceryCount[indexPath.row] = count
            defaults.setValue(strongSelf.groceryCount, forKey: strongSelf.countKey)
            cell.totalCost = cell.totalCost + Int(strongSelf.groceryPrices[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groceryList.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}



