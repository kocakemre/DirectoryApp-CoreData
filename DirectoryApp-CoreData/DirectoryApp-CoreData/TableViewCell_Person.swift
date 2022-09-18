//
//  TableViewCell_Person.swift
//  DirectoryApp-CoreData
//
//  Created by Emre Kocak on 16.09.2022.
//

import UIKit

class TableViewCell_Person: UITableViewCell {

    // MARK: - UI Elements
    @IBOutlet weak var imageViewPhoto: UIImageView!
    @IBOutlet weak var labelNameSurname: UILabel!
    
    // MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func bindData(person: Person) {
        
        if person.image == nil {
            imageViewPhoto.image = UIImage(named: "profil")
        }
        
        labelNameSurname.text = (person.name ?? "") + " " + (person.surname ?? "")
    }
    
}
