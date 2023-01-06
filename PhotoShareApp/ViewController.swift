//
//  ViewController.swift
//  PhotoShareApp
//
//  Created by Berkay Tuncel on 5.01.2023.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func loginClicked(_ sender: Any) {
        
    }
    
    @IBAction func signupClicked(_ sender: Any) {
        
        if checkSignUp() {
            //sign up user
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { authDataResult, error in
                if error != nil {
                    self.errorMessage(titleInput: "Error", messageInput: error?.localizedDescription ?? "Please enter valid email or password!")
                } else {
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
            
        } else {
            errorMessage(titleInput: "Error", messageInput: "Please enter valid email or password!")
        }
        
    }
    
    func errorMessage(titleInput: String, messageInput: String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    func checkSignUp() -> Bool {
        emailTextField.text != "" && emailTextField.text != nil && passwordTextField.text != "" && passwordTextField.text != nil
    }
}
