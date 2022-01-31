//
//  GameVC.swift
//  FindNumber
//
//  Created by Алексей Логинов on 31.01.2022.
//

import UIKit

class GameVC: UIViewController {

    @IBOutlet var buttons: [UIButton]! //создаем IBOutlet collections(чтобы обьеденить туда 16 кнобок)
    
    override func viewDidLoad() {
        super.viewDidLoad()

    

    
    }

    @IBAction func pressButton(_ sender: UIButton) {
        sender.isHidden = true // заставляем кнопку исчезнуть по нажатии
 
    }
}
