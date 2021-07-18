//
//  ChatViewController.swift
//  ChatUp
//
//  Created by Kiran Kishore on 14/07/21.
//

import UIKit
import Firebase
import FirebaseFirestore


class ChatViewController: UIViewController, UITextFieldDelegate, UITableViewDataSource {
    
    @IBOutlet weak var chatTextField: UITextField!
    
    @IBOutlet weak var chatTableView: UITableView!
    
    //Dummy data to populate tableView
    var messages: [Message] = [Message(sender: "a@z.com", body: "Hello"), Message(sender: "b@z.com", body: "Aloha "), Message(sender: "y@z.com", body: "Hola ")]
    
    //FIRESTORE OBJECT TO ACCESS FIRESTORE DATABASE(SAME TO BE DONE IN APPDELEGATE)
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chatTextField.delegate = self
        
        //TO RESIZE TABLEVIEW CELL ROW HEIGHT BASED ON THE CONTENT
        chatTableView.rowHeight = UITableView.automaticDimension
        
        
        //TO REGISTER CUSTOM CELL INTO THE TABLEVIEW
        chatTableView.register(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        //TO LOAD PREVIOUS MESSAGES WHEN TABLEVIEW LOADS
        loadMessages()
    }
    
    //MARK: FUNCTION TO LOAD PREVIOUS MESSAGES WHEN TABLEVIEW LOADS
    func loadMessages(){
        
        db.collection("messages").addSnapshotListener { [self] querysnapshot, error in
            
            self.messages = [] //To avoid repetition of messages
            
            if let e = error {
                print("There was an issue retrieving data: \(e)")
            }else{
                
                if let snapshotDoc = querysnapshot?.documents{
                    for doc in snapshotDoc{
                        print(doc.data())
                        
                        let data = doc.data()//'data()' recieved is in dictionary format of ["String" : Any]
                        
                        if let senderMessage = data["sender"] as? String, let message = data["messageBody"] as? String {
                            let newMessage = Message(sender: senderMessage, body: message)
                            self.messages.append(newMessage)
                            
                            //TO RELOAD ALL DATA IN CELLS AFTER APPENDING
                            self.chatTableView.reloadData()
                            
                            
                        }
                    }
                }
            }
            
        }
        
        
    }
    
    //MARK: Method to dismiss keyboard after entry in textfield with return key
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        messages.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = chatTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MessageCell
        
        
        cell.senderLabel.text = messages[indexPath.row].sender
        cell.messageBodyLabel.text = messages[indexPath.row].body
        
        return cell
    }
    
    //MARK: FUNCTION TO SEND MESSAGE INTO FIRESTORE DATABASE COLLECTION
    @IBAction func sendMessagePressed(_ sender: UIButton) {
        
        if let messageBody = chatTextField.text, let messageSender = Auth.auth().currentUser?.email{
            
            db.collection("messages").addDocument(data: ["sender" : messageSender, "messageBody" : messageBody]){ error in
                
                if let e = error{
                    print("Data saving failed: \(e)")
                }else {
                    print("Data saved successfully")
                }
                
            }
            
        }
        
        chatTextField.text = ""
        
    }
    
    
    //MARK: FUNCTION TO LOG OUT CURRENT USER
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
            
            let alert = UIAlertController.init(title: "Success", message: "Logged out successfully", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: { UIAlertAction in
                self.navigationController?.popToRootViewController(animated: true)
            }))
            
            self.present(alert, animated: true, completion: nil)
            
        }catch let signOutError as NSError {
            print("Error signing out: \(signOutError)")
            
            let alert = UIAlertController.init(title: "Error", message: "Logout failed", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }
        
    }
   
}
