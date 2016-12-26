//
//  ChatViewController.swift
//  Parse Chat
//
//  Created by Nguyen Thanh Thuc on 19/12/2016.
//  Copyright © 2016 Nguyen Thanh Thuc. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController {

    @IBOutlet weak var chatTextFeild: UITextField!
    @IBOutlet weak var tableView: UITableView!
    var textArr: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
        let user = PFUser.current()
        if user == nil {
            //re login
            
        } else {
            //
            let query = PFQuery(className:"MSG")
            query.findObjectsInBackground { (objArr, error) in
                
                if let objArr = objArr {
                    for obj in objArr {
                        let text = obj["msg"] as! String
                        self.textArr.append(text)
                        self.tableView.reloadData()
                    }
                }
            }
        }
        
        
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
    
    @IBAction func onBackAction(_ sender: UIBarButtonItem) {
        
    }
    
    @IBAction func onChatAction(_ sender: UIButton) {
        
        let msgObject = PFObject(className: "MSG")
        msgObject["msg"] = chatTextFeild.text
        let text = msgObject["msg"] as! String
        textArr.append(text)
        
        
        msgObject.saveInBackground { (succeed, error) in
            if succeed {
                //self.showAlert(title: "succeed", message: "succeed")
                self.tableView.reloadData()
                
                let indexPath = IndexPath.init(row: self.textArr.count - 1, section: 0)
                self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
                
            } else {
                
                self.showAlert(title: "error", message: (error?.localizedDescription)!)
            }
        }
    }
}

extension ChatViewController: UITableViewDelegate {
    
}

extension ChatViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if textArr.count != 0 {
          return (textArr.count)
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ChatRowTableViewCell
        cell.messageText = textArr[indexPath.row]
        let user = PFUser.current()
        cell.userText = user?.username
        return cell
    }
}
