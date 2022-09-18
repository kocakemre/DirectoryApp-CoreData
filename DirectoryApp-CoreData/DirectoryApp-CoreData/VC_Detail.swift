//
//  VC_Detail.swift
//  DirectoryApp-CoreData
//
//  Created by Emre Kocak on 16.09.2022.
//

import UIKit

class VC_Detail: UIViewController {
    
    // MARK: - UI Elements
    
    @IBOutlet weak var imageViewProfile: UIImageView!
    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var textFieldSurname: UITextField!
    @IBOutlet weak var textFieldNewNumber: UITextField!
    @IBOutlet weak var tableViewNumberList: UITableView!
    @IBOutlet weak var buttonDelete: UIButton!
    
    var beUpdated: Person?
    var uuid = UUID()
    var numberList = [PersonNumber]()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewNumberList.delegate = self
        tableViewNumberList.dataSource = self

        if beUpdated != nil
        {
            uuid = beUpdated!.id!
            textFieldName.text = beUpdated!.name
            textFieldSurname.text = beUpdated!.surname
            
            numberList = DAL.bringPersonNumber(uuid: uuid) ?? []
            
            if beUpdated?.image != nil
            {
                imageViewProfile.image = UIImage(data: beUpdated!.image!)
            }
            
            buttonDelete.isHidden = false
        }
    }
    
    // MARK: - Functions
    
    // MARK: - UI Elements
    @IBAction func buttonNewNumber_TUI(_ sender: UIButton) {
        
        if textFieldNewNumber.isHidden
        {
            textFieldNewNumber.isHidden = false
            sender.setTitle("Kaydet", for: .normal)
        }
        else if textFieldNewNumber.text != ""
        {
            numberList.append(DAL.createNumber(personId: uuid, no: textFieldNewNumber.text!))
            textFieldNewNumber.isHidden = true
            sender.setTitle("Yeni Telefon", for: .normal)
            textFieldNewNumber.text = ""
            tableViewNumberList.reloadData()
        }
                               
    }
    
    @IBAction func buttonSave_TUI(_ sender: Any) {
        if beUpdated == nil
        {
            DAL.addPerson(uuid: uuid, name: textFieldName.text!, surname: textFieldSurname.text!, numbers: numberList)
        }
        else
        {
            beUpdated?.name = textFieldName.text!
            beUpdated?.surname = textFieldSurname.text!
            
            DAL.updatePerson()
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func buttonDelete_TUI(_ sender: Any) {
        let ac = UIAlertController(title: "Uyarı", message: "Kişiyi silmek istediğinize emin misiniz?", preferredStyle: .alert)
        
        ac.addAction(UIAlertAction(title: "Sil", style: .destructive, handler: { _ in
            DAL.deletePerson(person: self.beUpdated!)
            self.navigationController?.popViewController(animated: true)
        }))
        
        ac.addAction(UIAlertAction(title: "Vazgeç", style: .default, handler: nil))
        
        present(ac, animated: true, completion: nil)
    }
    
}

// MARK: - Extension Table View

extension VC_Detail: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = numberList[indexPath.row].number
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            DAL.deleteNumber(number: numberList[indexPath.row])
            numberList.remove(at: indexPath.row)
            tableViewNumberList.reloadData()
        }
    }
}
