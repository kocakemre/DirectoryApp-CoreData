//
//  ViewController.swift
//  DirectoryApp-CoreData
//
//  Created by Emre Kocak on 16.09.2022.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - UI Elements
    @IBOutlet weak var tableViewList: UITableView!
    
    var list = [Person]()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewList.delegate = self
        tableViewList.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DAL.getContext().rollback()
        list = DAL.allBringContacts() ?? []
        tableViewList.reloadData()
    }
    
    // MARK: - Functions

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sgDetail" {
            let vc = segue.destination as! VC_Detail
            vc.beUpdated = list[sender as! Int]
        }
    }
}

// MARK: - Extension Table View

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let person = list[indexPath.row]
        
        let cell = Bundle.main.loadNibNamed("TableViewCell_Person", owner: self, options: nil)?.first as! TableViewCell_Person
        
        cell.bindData(person: person)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "sgDetail", sender: indexPath.row)
        
    }
    
}
