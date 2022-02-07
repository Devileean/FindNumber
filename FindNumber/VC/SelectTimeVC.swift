//
//  SelectTimeVC.swift
//  FindNumber
//
//  Created by Алексей Логинов on 07.02.2022.
//

import UIKit

class SelectTimeVC: UIViewController {

    
    var data:[Int] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }

}
extension SelectTimeVC: UITableViewDataSource {
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    } (1)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { //кол-во строк секций
//        if section == 0 {
//            return 5
//        } (1)
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { // указать что будут за ячейки
        let cell = tableView.dequeueReusableCell(withIdentifier: "timeCell", for: indexPath)
        // cell.textLabel?.text = "section - \(indexPath.section) row - \(indexPath.row)" (1)
        
        cell.textLabel?.text = String(data[indexPath.row])
        return cell
    }
    
    
}

extension SelectTimeVC: UITableViewDelegate {
    
}
