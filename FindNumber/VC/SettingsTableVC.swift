//
//  SettingsTableVC.swift
//  FindNumber
//
//  Created by Алексей Логинов on 07.02.2022.
//

import UIKit

class SettingsTableVC: UITableViewController {

    @IBOutlet weak var switchTimer: UISwitch!
    @IBOutlet weak var timeGameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadSettings()
    }
    
    @IBAction func changeTimerState(_ sender: UISwitch) {
        Settings.shared.currentSettings.timeState = sender.isOn
    }
    
    func loadSettings() {
        timeGameLabel.text = "\(Settings.shared.currentSettings.timeForGame) сек"
        switchTimer.isOn = Settings.shared.currentSettings.timeState
    }
    
    
    @IBAction func resetSettings(_ sender: Any) {
        Settings.shared.resetSettings()
        loadSettings()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "selectTimeVC" :
            if let vc = segue.destination as? SelectTimeVC {
                vc.data = [10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 110, 120]
            }
            
        default:
            break
        }
    }
}
