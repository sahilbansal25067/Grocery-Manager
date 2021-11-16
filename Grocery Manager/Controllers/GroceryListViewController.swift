//
//  GroceryListViewController.swift
//  Grocery Manager
//
//  Created by Sahil Kumar Bansal on 13/11/21.
//

import UIKit

class GroceryListViewController: UIViewController {
    @IBOutlet var tableView : UITableView!
    @IBOutlet var totalCost : UILabel!
    var groceryList : [String] = []
    var groceryPrices : [UInt16] =  []
    var groceryCount  : [UInt16] = []
    let cellName = "ListTableViewCell"
    let groceryListKey = "groceries"
    let priceskey = "prices"
    let countKey  = "counts"
    var totalCosts = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Grocery List"
        configureTableView()
        setupData()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Add Items", style: .done , target: self, action: #selector(addMoreItems))
        // Do any additional setup after loading the view.
    }
    private func configureTableView()
    {
        tableView.delegate = self
        tableView.dataSource = self
        let  nib = UINib(nibName: cellName, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: cellName)
    }
    private func setupData()
    {
        guard let counts = defaults.value(forKey: countKey) as? [UInt16] , let names = defaults.value(forKey: groceryListKey) as? [String] ,let prices = defaults.value(forKey: priceskey) as? [UInt16] else {
            return
        }
//        guard let names = defaults.value(forKey: groceryListKey) as? [String] else {
//            return
//        }
//        guard let prices = defaults.value(forKey: priceskey) as? [UInt16] else {
//            return
//        }
        for i in 0...counts.count-1{
            if counts[i] > 0
            {
                groceryList.append(names[i])
                groceryCount.append(counts[i])
                groceryPrices.append(prices[i])
                totalCosts += Int(prices[i] * counts[i])
            }
        }
        totalCost.text = String(totalCosts)
        tableView.reloadData()
    }
    @objc private func addMoreItems()
    {
        navigationController?.popViewController(animated: true)
    }

}
extension GroceryListViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
extension GroceryListViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellName, for: indexPath) as? ListTableViewCell else {
            return UITableViewCell()}
        cell.Grocerylabel.text = groceryList[indexPath.row] + " (" + String(groceryPrices[indexPath.row]) + "Rs)"
        cell.GroceryCostlabel.text = String(groceryCount[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groceryCount.count
    }
}

