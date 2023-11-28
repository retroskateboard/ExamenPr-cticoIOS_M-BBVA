//
//  TableViewController.swift
//  Constrains
//
//  Created by Eric Rojas Pech on 26/11/23.
//

import UIKit

class TableViewController: UIViewController {
    
    let model = UsersTableModel()
    let apiController = APIController()

    
    @IBOutlet weak var exitButton: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    {
        didSet{
            tableView.register(UINib(nibName: "UsersTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UsersTableViewCell.nib(), forCellReuseIdentifier: UsersTableViewCell.identifier)
        
        apiController.getUsers { (error) in
            if let error = error{
                print("Error performing datatask \(error)")
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    
    
    @IBAction func exitButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    


}

extension TableViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UsersTableViewCell.identifier) as? UsersTableViewCell
        
        let user = apiController.users[indexPath.row]
        
        cell?.nombreUR.text = user.name.first + " " + user.name.last
        cell?.direccionUR.text = user.location.city + ", " + user.location.state
        cell?.telUR.text = user.phone
        cell?.emailUR.text = user.email
        cell?.nickUR.text = user.login.username
        cell?.edadUR.text = String(user.dob.age)
        cell?.natioUR.text = user.nat
        if let imageURL = URL(string: user.picture.large) {
            let session = URLSession.shared
            let task = session.dataTask(with: imageURL) { data, _, error in
            if let error = error {
                            print("Error loading image: \(error)")
                            return
                        }

                        if let data = data, let image = UIImage(data: data) {
                            DispatchQueue.main.async {
                                cell?.imageUR.image = image
                            }
                        }
                    }

                    task.resume()
                }
        return cell!
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return apiController.users.count
    }
    
}

extension TableViewController: UITableViewDelegate{
    
}

