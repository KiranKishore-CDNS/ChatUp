//
//  SignUpViewController.swift
//  ChatUp
//
//  Created by Kiran Kishore on 06/04/21.
//

import UIKit
import Firebase
import IQKeyboardManagerSwift

class SignUpViewController: UIViewController, UITextFieldDelegate{
    
    @IBOutlet weak var userEmail: UITextField!
    @IBOutlet weak var userPassword: UITextField!
    
    @IBOutlet weak var confirmUserPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.userEmail.delegate = self
        self.userPassword.delegate = self
        self.confirmUserPassword.delegate = self
        // Do any additional setup after loading the view.
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
    
    
    
    /*MARK: REGISTER BUTTON PRESSED FUNCTION */
    @IBAction func registerButtonPressed(_ sender: UIButton) {
        
        
        if let email = userEmail.text, let password = userPassword.text {
            
            Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
                
                if let e = error {
                    print("Error: \(e)")
                    
                    let alert = UIAlertController.init(title: "Error", message: "Account Creation Failed", preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "try Again", style: .default, handler: nil))
                    
                    self.present(alert, animated: true, completion: nil)
                    
                }else{
                    
                    let alert = UIAlertController.init(title: "Success", message: "Account Created", preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "Go to Chat", style: .default, handler: { UIAlertAction in
                        self.performSegue(withIdentifier: "registerToChat", sender: nil)
                    }))
                    
                    self.present(alert, animated: true, completion: nil)
                }
            }
            
            
        }
        
        
    }
}













