//
//  GameVC.swift
//  FindNumber
//
//  Created by Алексей Логинов on 31.01.2022.
//

import UIKit

class GameVC: UIViewController {

    @IBOutlet var buttons: [UIButton]! //создаем IBOutlet collections(чтобы обьеденить туда 16 кнобок)
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var nextDigit: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    
    
    lazy var game = Game(countItems: buttons.count, time: 30) { [weak self] (status, time) in
        guard let self = self else {return}
        self.timerLabel.text = time.secondToString()
        self.updateInfoGame(with: status)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    setupScreen()

    
    }

    @IBAction func pressButton(_ sender: UIButton) {
        
        guard let buttonIndex = buttons.firstIndex(of: sender) else {return}
        game.check(index: buttonIndex)
        
        updateUI()
    }
    
    private func setupScreen() {
        for index in game.items.indices {
            buttons[index].setTitle(game.items[index].title , for: .normal)
            buttons[index].isHidden = false
        }
        nextDigit.text = game.nextItem?.title
    }
    
    private func updateUI() {
        for index in game.items.indices {
            buttons[index].isHidden = game.items[index].isFound
        
            if game.items[index].isError { // добавляем анимацию кнопки при неправильном нажатии
                UIView.animate(withDuration: 0.3) { [weak self] in // weak self чтобы небыло утечки памяти
                    self?.buttons[index].backgroundColor = .red // self с ? т.к. weak и  self становиться опциональным
                } completion: { [weak self] (_) in // weak self чтобы небыло утечки памяти
                    self?.buttons[index].backgroundColor = .systemYellow // self с ? т.к. weak и  self становиться опциональным
                    self?.game.items[index].isError = false // self с ? т.к. weak и  self становиться опциональным
                }
            }
        
        }
        nextDigit.text = game.nextItem?.title
        
        updateInfoGame(with: game.status)
    }
    
    private func updateInfoGame(with status: StatusGame) {//для проверки статуса игры
    
        switch status {
        case .start:
            statusLabel.text = "Игра началась"
            statusLabel.textColor = .blue
        case .win:
            statusLabel.text = "Вы выиграли"
            statusLabel.textColor = .green
        case .lose:
            statusLabel.text = "Вы проиграли"
            statusLabel.textColor = .red
    }
    }
}
