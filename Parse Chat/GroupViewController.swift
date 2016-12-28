//
//  GroupViewController.swift
//  Parse Chat
//
//  Created by Nguyen Thanh Thuc on 28/12/2016.
//  Copyright © 2016 Nguyen Thanh Thuc. All rights reserved.
//

import UIKit
import Parse

class GroupViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var myID: String?
    var chatMateArr: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
        let query = PFUser.query()
        query?.addAscendingOrder("username")
        query?.whereKey("username", notEqualTo: myID!)
        query?.findObjectsInBackground(block: { (objectArr, error) in
            guard let objarr = objectArr else {return}
            for obj in objarr {
                let username = obj["username"] as! String
                self.chatMateArr.append(username)
            }
            self.tableView.reloadData()
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let dest = segue.destination as! ChatViewController
        let indexPath = tableView.indexPath(for: (sender as! UITableViewCell))
        dest.userRecipient = chatMateArr[indexPath!.row]
        
    }
}

extension GroupViewController: UITableViewDelegate {
    
    
}

extension GroupViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "groupCell") as! GroupTableViewCell
        cell.groupText = chatMateArr[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatMateArr.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
