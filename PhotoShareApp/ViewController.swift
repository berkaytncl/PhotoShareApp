//
//  ViewController.swift
//  PhotoShareApp
//
//  Created by Berkay Tuncel on 5.01.2023.
//

import UIKit

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
        performSegue(withIdentifier: "toFeedVC", sender: nil)
    }
}
