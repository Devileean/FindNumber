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
        var isFound: Bool = false
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
    
    private var timeForGame: Int { //и его добавим в init (3)
        didSet{                               //добавим проверку времени на изменения
            if timeForGame == 0 {
                status = .lose
            }
            updateTimer(status, timeForGame)
        }
    }
    
    private var timer: Timer? //также нужна для запуска таймера (её запустим в функции setupGame)
    private var updateTimer:((StatusGame, Int) -> Void) // (6)
    
    init(countItems: Int, time: Int, updateTimer:@escaping (_ status: StatusGame, _ seeconds: Int) -> Void) { // (3)
        self.countItems = countItems
        self.timeForGame = time // (3)
        self.updateTimer = updateTimer //(6)
        setupGame()
    }
    
    //создадим функцию для создания items
    private func setupGame() {
        var digits = data.shuffled() //чтобы перемешивать массив(c помощью shuffled)
        
        while items.count < countItems {
            let item = Item(title: String(digits.removeFirst()))
            items.append(item)
        }
        
        nextItem = items.shuffled().first //(1) для рандомного создания цифр
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [weak self] (_) in // делаем weak self чтобы небыло утечек памяти
            self?.timeForGame -= 1
        })
    }
    
    func check(index: Int) {
        
        if items[index].title == nextItem?.title {
            items[index].isFound = true
            nextItem = items.shuffled().first(where: {(item) -> Bool in
                item.isFound == false})
        }
        if nextItem == nil{
            status = .win
        }
    }
    private func stopGame() { // а инитить будем в stausGame
        timer?.invalidate()
    }
}
