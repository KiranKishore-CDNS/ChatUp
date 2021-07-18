//
//  LoginViewController.swift
//  ChatUp
//
//  Created by Kiran Kishore on 06/04/21.
//

import UIKit
import Firebase
import IQKeyboardManagerSwift

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var userEmail: UITextField!
    @IBOutlet weak var userPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.userEmail.delegate = self
        self.userPassword.delegate = self
        
    }
    
    //MARK: To unhide navigationbar
    override func viewWillAppear(_ animated: Bool) {
        //self.navigationController?.navigationBar.isHidden = false
        
        
    }
    
    //MARK: Method to dismiss keyboard after entry in textfield with 'return key'
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    
    /*MARK: LOGIN BUTTON PRESSED FUNCTION */
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        
        if let email = userEmail.text, let password = userPassword.text {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    print("Error : \(e)")
                    
                    let alert = UIAlertController.init(title:"Error" , message: "Invalid Login Credentials", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Try Again", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }else{
                    
                    let alert = UIAlertController.init(title:"Success" , message: "Logged in successfully!!!", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Go to chat", style: .default, handler: { UIAlertAction in
                        self.performSegue(withIdentifier: "loginToChat", sender: self)
                    }))
                    self.present(alert, animated: true, completion: nil)
                    
                    
                    
                }
                
                
            }
        }
    }
    
    
    
}
