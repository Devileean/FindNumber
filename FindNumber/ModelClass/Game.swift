//
//  Game.swift
//  FindNumber
//
//  Created by Алексей Логинов on 31.01.2022.
//

import Foundation

enum StatusGame{
    case start
    case win
    case lose
}


class Game {
    
    struct Item{
        var title: String
        var isFound = false
        var isError = false
    }
    
    private let data = Array(1...99) //отображать числа на кнопках с помощью этого массива
    var items:[Item] = [] // массив кнопок
    
    private var countItems: Int
    
    var nextItem: Item? // (1)
    
    var status:StatusGame = .start {
        didSet {
            if status != .start {
                stopGame()
                
            }
        }
    }
    
    private var timeForGame: Int //(10)
    
    private var secondsGame: Int { //и его добавим в init (3)
        didSet{                               //добавим проверку времени на изменения
            if secondsGame == 0 {
                status = .lose
            }
            updateTimer(status, secondsGame) //копируем в setupGame чтобы небыло секндной задержки (7)
        }
    }
    
    private var timer: Timer? //также нужна для запуска таймера (её запустим в функции setupGame)
    private var updateTimer:((StatusGame, Int) -> Void) // (6)
    
    init(countItems: Int, time: Int, updateTimer:@escaping (_ status: StatusGame, _ seeconds: Int) -> Void) { // (3)
        self.countItems = countItems
        self.secondsGame = time // (3)
        self.updateTimer = updateTimer //(6)
        self.timeForGame = time // (10)
        setupGame()
    }
    
    //создадим функцию для создания items
    private func setupGame() {
        var digits = data.shuffled() //чтобы перемешивать массив(c помощью shuffled)
        items.removeAll()
        while items.count < countItems {
            let item = Item(title: String(digits.removeFirst()))
            items.append(item)
        }
 
        nextItem = items.shuffled().first // (1) для рандомного создания цифр
        
        updateTimer(status, secondsGame) // (7)
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [weak self] (_) in // делаем weak self чтобы небыло утечек памяти
            self?.secondsGame -= 1
        })
    }
    
    func newGame(){
        status = .start
        self.secondsGame = timeForGame // чтобы воставить таймер с секундами
        setupGame()
    }
    
    func check(index: Int) {
        guard status == .start else {return} //проверка статуса на прекращение игры
        if items[index].title == nextItem?.title {
            items[index].isFound = true
            nextItem = items.shuffled().first(where: {(item) -> Bool in
                item.isFound == false})
        } else {
            items[index].isError = true
        }
        if nextItem == nil{
            status = .win
        }
    }
    private func stopGame() { // а инитить будем в stausGame
        timer?.invalidate()
    }
}

extension Int {  //создаём для более лучшего восприятия таймера

    func secondToString() -> String {
        let minutes = self / 60
        let seconds = self % 60
        
        return String(format: "%d:%02d", minutes, seconds)
        
    }

}
