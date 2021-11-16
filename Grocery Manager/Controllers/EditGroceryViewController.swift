//
//  EditGroceryViewController.swift
//  Grocery Manager
//
//  Created by Sahil Kumar Bansal on 13/11/21.
//

import UIKit

class EditGroceryViewController: UIViewController {
    var initalName : String = "Enter Grocery Name"
    var initalCost : String = "Enter Grocery Price"
    
    var editHandler : ((_ name: String , _ price: UInt16)->Void)?
    var deleteHandler : (()->Void)?
    let popView :  UIView = {
      let view = UIView()
        view.layer.cornerRadius  = 12
        view.backgroundColor = .white
        return view
    }()
    
    private let groceryName: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Enter Grocery Name"
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        return field
        
    }()
    private let groceryCost: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Enter Grocery Price"
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        return field
        
    }()
    private let saveChanges: UIButton = {
        let button = UIButton()
        button.setTitle("Save", for: .normal)
        button.backgroundColor = .link
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.masksToBounds =  true
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        return button
    }()
    private let deleteGrocery: UIButton = {
        let button = UIButton()
        button.setTitle("Delete Grocery", for: .normal)
        button.backgroundColor = .link
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.masksToBounds =  true
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        return button
    }()
    private let cancelChanges: UIButton = {
        let button = UIButton()
        button.setTitle("Cancel Changes", for: .normal)
        button.backgroundColor = .link
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.masksToBounds =  true
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        
        
        saveChanges.addTarget(self,
                              action: #selector(saveChangesButtonTapped),
                              for: .touchUpInside)
        cancelChanges.addTarget(self,
                                    action: #selector(cancelChangesButtonTapped)
                                    , for: .touchUpInside)
        deleteGrocery.addTarget(self,
                                    action: #selector(deleteButtonTapped)
                                    , for: .touchUpInside)
        groceryName.text = initalName
        groceryCost.text = initalCost
        groceryCost.becomeFirstResponder()
        
        view.addSubview(popView)
        popView.addSubview(groceryName)
        popView.addSubview(groceryCost)
        popView.addSubview(saveChanges)
        popView.addSubview(deleteGrocery)
        popView.addSubview(cancelChanges)
    }
    @objc private func deleteButtonTapped()
    {
        deleteHandler!()
        dismiss(animated: true, completion: nil)
    }
    @objc private func saveChangesButtonTapped()
    {
        if groceryName.text == ""
        {
            let alert = UIAlertController(title: "Alert",
                                          message: "Please Enter the grocery name",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok",
                                          style: .default,
                                          handler: nil))
            alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: {[weak self]_ in
                self?.dismiss(animated: true, completion: nil)
            }))
            present(alert,animated: true)
        }
        else if groceryCost.text == ""
        {
            let alert = UIAlertController(title: "Alert",
                                          message: "Please Enter the grocery price",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok",
                                          style: .default,
                                          handler: nil))
            alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: {[weak self]_ in
                self?.dismiss(animated: true, completion: nil)
            }))
            present(alert,animated: true)
        }
        else{
        guard let name = groceryName.text else {
            dismiss(animated: true, completion: nil)
            return}
        guard let price = groceryCost.text else {
            dismiss(animated: true, completion: nil)
            return}
        guard let price2 = UInt16(price) else {dismiss(animated: true, completion: nil)
            return}
        
        editHandler!(name,price2)
            dismiss(animated: true, completion: nil)}
    }
    @objc private func cancelChangesButtonTapped()
    {
        dismiss(animated: true, completion: nil)

    }
    override func viewDidLayoutSubviews(){
        let size = view.frame.width
        let height = view.frame.height
        super.viewDidLayoutSubviews()
        popView.frame = CGRect(x: 0, y: height/2 - 115 - 120, width: size, height: 330)
        groceryName.frame = CGRect(x: 10,
                                   y: 20,
                                   width: size - 20,
                                   height: 50)
        groceryCost.frame = CGRect(x: 10,
                                   y: groceryName.bottom  + 10,
                                   width: size - 20,
                                   height: 50)
        saveChanges.frame = CGRect(x: 10,
                                   y: groceryCost.bottom  + 10,
                                   width: size - 20,
                                   height: 50)
        deleteGrocery.frame = CGRect(x: 10,
                                   y: saveChanges.bottom  + 10,
                                   width: size - 20,
                                   height: 50)
        cancelChanges.frame = CGRect(x: 10,
                                   y: deleteGrocery.bottom  + 10,
                                   width: size - 20,
                                   height: 50)
    }
    


}

