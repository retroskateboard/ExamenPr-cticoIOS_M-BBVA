//
//  UsersTableViewCell.swift
//  Constrains
//
//  Created by Eric Rojas Pech on 26/11/23.
//

import UIKit

class UsersTableViewCell: UITableViewCell {
    
    
    static let identifier = "UsersTableViewCell"
    
    static func nib() -> UINib{
        return UINib(nibName: "UsersTableViewCell", bundle: nil)
        
    }
    
    
    @IBOutlet weak var imageUR: UIImageView!
    @IBOutlet weak var nombreUR: UILabel!
    @IBOutlet weak var emailUR: UILabel!
    @IBOutlet weak var nickUR: UILabel!
    @IBOutlet weak var direccionUR: UILabel!
    @IBOutlet weak var telUR: UILabel!
    @IBOutlet weak var edadUR: UILabel!
    @IBOutlet weak var natioUR: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imageUR.layer.cornerRadius = imageUR.frame.size.width / 2
        imageUR.clipsToBounds = true
        imageUR.layer.borderWidth = 6.0
        imageUR.layer.borderColor = UIColor.lightGray.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
        if selected {
                setSelected(false, animated: true)
            }
    }
    
}
