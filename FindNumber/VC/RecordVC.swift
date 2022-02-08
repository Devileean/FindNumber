//
//  RecordVC.swift
//  FindNumber
//
//  Created by Алексей Логинов on 08.02.2022.
//

import UIKit

class RecordVC: UIViewController {

    @IBOutlet weak var recordLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let record = UserDefaults.standard.integer(forKey: KeysUserDefaults.recordGame)
        if record != 0 {
            recordLabel.text = "Ваш рекорд - \(record)"
            recordLabel.textColor = .systemYellow
        } else {
            recordLabel.text = "Рекорд не установлен"
            recordLabel.textColor = .systemRed

        }
    }
    @IBAction func closeVC(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
