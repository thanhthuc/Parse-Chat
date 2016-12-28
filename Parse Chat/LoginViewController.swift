//
//  ViewController.swift
//  Parse Chat
//
//  Created by Nguyen Thanh Thuc on 19/12/2016.
//  Copyright © 2016 Nguyen Thanh Thuc. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    var myID: String?
    var loginSucceed = false
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    func presentGroupViewController() {
        let sb = UIStoryboard.init(name: "Main", bundle: nil)
        let groupVC = sb.instantiateViewController(withIdentifier: "GroupViewController") as! GroupViewController
        groupVC.myID = self.myID
        show(groupVC, sender: self)
    }
    
    
    
    @IBAction func onLogin(_ sender: UIButton) {
        
        PFUser.logInWithUsername(inBackground: usernameTextField.text!, password: passwordTextField.text!) { (user, error) in
            if let error = error {
                self.showAlert(title: "ERROR", message: error.localizedDescription)
            } else {
                DispatchQueue.main.async {
                    self.myID = user?.username
                    self.loginSucceed = true
                    self.presentGroupViewController()
                }
            }
        }
    }

}

