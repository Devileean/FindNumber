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
    @IBOutlet weak var newGameButton: UIButton!
    
    
    lazy var game = Game(countItems: buttons.count) { [weak self] (status, time) in
        guard let self = self else {return}
        self.timerLabel.text = time.secondToString()
        self.updateInfoGame(with: status)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        game.stopGame()
        
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
    
    @IBAction func newGame(_ sender: UIButton) { //здесь будем обновлять все кнопки и статус игры
        game.newGame()
        sender.isHidden = true //жтобы во время ишры е] не было видно
        setupScreen()
    }
    
    
    private func setupScreen() {
        for index in game.items.indices {
            buttons[index].setTitle(game.items[index].title , for: .normal)
            buttons[index].alpha = 1 //все кнопки видны
            buttons[index].isEnabled = true // все кнопки не нажаты
        }
        nextDigit.text = game.nextItem?.title
    }
    
    private func updateUI() {
        for index in game.items.indices {
            buttons[index].alpha = game.items[index].isFound ? 0 : 1// чтобы наши констрейты не пересчитывались делаем кнопку прозрачной
            buttons[index].isEnabled = !game.items[index].isFound //чтобы кнопка не нажималась, когда становиться прозрачной
            
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
            newGameButton.isHidden = true//чтобы показать кнопку "новая игра"
        case .win:
            statusLabel.text = "Вы выиграли"
            statusLabel.textColor = .green
            newGameButton.isHidden = false
        case .lose:
            statusLabel.text = "Вы проиграли"
            statusLabel.textColor = .red
            newGameButton.isHidden = false
        }
    }
}
