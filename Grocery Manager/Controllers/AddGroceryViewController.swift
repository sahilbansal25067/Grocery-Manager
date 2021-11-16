//
//  AddGroceryViewController.swift
//  Grocery Manager
//
//  Created by Sahil Kumar Bansal on 13/11/21.
//

import UIKit

import UIKit

class AddGroceryViewController: UIViewController , UITextFieldDelegate {
    var initalName : String = "Enter Grocery Name"
    var initalCost : String = "Enter Grocery Price"
    
    var saveHandler : ((_ name: String , _ price: UInt16)->Void)?
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
    private let addGrocery: UIButton = {
        let button = UIButton()
        button.setTitle("Add Grocery", for: .normal)
        button.backgroundColor = .link
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.masksToBounds =  true
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        return button
    }()
    private let cancel: UIButton = {
        let button = UIButton()
        button.setTitle("Cancel", for: .normal)
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
        
        
        addGrocery.addTarget(self,
                              action: #selector(addGroceryButtonTapped),
                              for: .touchUpInside)
        cancel.addTarget(self,
                                    action: #selector(cancelButtonTapped)
                                    , for: .touchUpInside)

        groceryName.becomeFirstResponder()
        groceryCost.delegate = self
        groceryName.delegate = self
        view.addSubview(popView)
        popView.addSubview(groceryName)
        popView.addSubview(groceryCost)
        popView.addSubview(addGrocery)
        popView.addSubview(cancel)
       
    }
    
    @objc private func addGroceryButtonTapped()
    {
        if groceryName.text == ""
        {
            let alert = UIAlertController(title: "Alert",
                                          message: "Please Enter the grocery name",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok",
                                          style: .default,
                                          handler: nil))
//            alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: {[weak self]_ in
//                self?.dismiss(animated: true, completion: nil)
//            }))
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
//            alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: {[weak self]_ in
//                self?.dismiss(animated: true, completion: nil)
//            }))
            present(alert,animated: true)
        }
        else{
        guard let name = groceryName.text else {
            dismiss(animated: true, completion: nil)
            return}
        guard let price = groceryCost.text else {
            dismiss(animated: true, completion: nil)
            return}
        guard let price2 = UInt16(price) else {
            
            dismiss(animated: true, completion: nil
            )
            return}
        
        saveHandler!(name,price2)
            dismiss(animated: true, completion: nil)}
    }
    @objc private func cancelButtonTapped()
    {
        dismiss(animated: true, completion: nil)

    }
    override func viewDidLayoutSubviews(){
        let size = view.frame.width
        let height = view.frame.height
        super.viewDidLayoutSubviews()
        popView.frame = CGRect(x: 0, y: height/2 - 135 - 55, width: size, height: 270)
        groceryName.frame = CGRect(x: 10,
                                   y: 20,
                                   width: size - 20,
                                   height: 50)
        groceryCost.frame = CGRect(x: 10,
                                   y: groceryName.bottom  + 10,
                                   width: size - 20,
                                   height: 50)
        addGrocery.frame = CGRect(x: 10,
                                   y: groceryCost.bottom  + 10,
                                   width: size - 20,
                                   height: 50)
        cancel.frame = CGRect(x: 10,
                                   y: addGrocery.bottom  + 10,
                                   width: size - 20,
                                   height: 50)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
          // Try to find next responder
        if textField == groceryName {
               textField.resignFirstResponder()
               groceryCost.becomeFirstResponder()
            } else if textField == groceryCost {
                groceryCost.resignFirstResponder()

            }

           return true
       }
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        if textField == groceryName {
//               textField.resignFirstResponder()
//               groceryCost.becomeFirstResponder()
//            } else if textField == groceryCost {
//                groceryCost.resignFirstResponder()
//
//            }
//    }


}


