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
            if game.isNewRecord{
                showAlert()
            } else {
                showAlertActionsSheet()
            }
        case .lose:
            statusLabel.text = "Вы проиграли"
            statusLabel.textColor = .red
            newGameButton.isHidden = false
            showAlertActionsSheet()
        }
    }
    private func showAlert() { // alert когда новый рекорд
        let alert = UIAlertController(title: "Поздравляем!", message: "Вы установили новый рекорд!", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    private func showAlertActionsSheet() { // alert если проиграли или не побили рекорд
        let alert = UIAlertController(title: "Что вы хотите сделать далее?", message: nil, preferredStyle: .actionSheet)
        
        let newGameAction = UIAlertAction(title: "Начать новую игру", style: .default) { [weak self] (_) in
            self?.game.newGame()
            self?.setupScreen()
        }
        
        let showRecord = UIAlertAction(title: "Посмотреть рекорд.", style: .default) { [weak self] (_) in
   
            self?.performSegue(withIdentifier: "recordVC", sender: nil)
        }
        
        let menuAction = UIAlertAction(title: "Перейти в меню", style: .destructive) { [weak self] (_) in
            self?.navigationController?.popViewController(animated: true)
        }
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        
        alert.addAction(newGameAction)
        alert.addAction(showRecord)
        alert.addAction(menuAction)
        alert.addAction(cancelAction)
        
        if let popover = alert.popoverPresentationController{
            popover.sourceView = statusLabel //self.view (88) привязали к лэйблу(на айпаде)
        // popover.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0) //(88)
        // popover.permittedArrowDirections = UIPopoverArrowDirection.init(rawValue: 0) //(88)
        }
        
        present(alert, animated: true, completion: nil)
    }
}
