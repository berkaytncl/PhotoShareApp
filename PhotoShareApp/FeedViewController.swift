//
//  FeedViewController.swift
//  PhotoShareApp
//
//  Created by Berkay Tuncel on 6.01.2023.
//

import UIKit
import Firebase
import SDWebImage

class FeedViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var post = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        firebaseTakeDatas()
    }

    func firebaseTakeDatas() {
        
        let firestoreDatabase = Firestore.firestore()
        firestoreDatabase.collection("Post").order(by: "date", descending: true)
            .addSnapshotListener { snapshot, error in
            if error != nil {
                self.errorMessage(titleInput: "Error", messageInput: error!.localizedDescription)
            } else {
                if snapshot?.isEmpty != true && snapshot != nil {
                    
                    self.post.removeAll(keepingCapacity: false)
                    
                    for document in snapshot!.documents {
                        //let doucmentId = document.documentID
                        
                        if let comment = document.get("comment") as? String {
                            if let email = document.get("email") as? String {
                                if let imageUrl = document.get("imageurl") as? String {
                                    self.post.append(Post(email: email, comment: comment, imageUrl: imageUrl))
                                }
                            }
                        }
                    }
                    self.tableView.reloadData()
                }
            }
        }
        
    }
    
    func errorMessage(titleInput: String, messageInput: String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension FeedViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return post.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell", for: indexPath) as! FeedTableViewCell
        cell.emailText.text = post[indexPath.row].email
        cell.commentText.text = post[indexPath.row].comment
        cell.postImageView.sd_setImage(with: URL(string: post[indexPath.row].imageUrl))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return FeedTableViewCell.height
    }
}
