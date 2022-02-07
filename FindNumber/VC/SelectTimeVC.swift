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
        //tableView.reloadData() //чтобы обновлять ячеки
  
    }

}
extension SelectTimeVC: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { //кол-во строк секций

        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { // указать что будут за ячейки
        let cell = tableView.dequeueReusableCell(withIdentifier: "timeCell", for: indexPath)
        // cell.textLabel?.text = "section - \(indexPath.section) row - \(indexPath.row)" (1)
        
        cell.textLabel?.text = String(data[indexPath.row])
        cell.textLabel?.textColor = .systemYellow
        
        return cell
    }
    
    
}

extension SelectTimeVC: UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
       
        Settings.shared.currentSettings.timeForGame = data[indexPath.row]
        navigationController?.popViewController(animated: true)
    }
}
