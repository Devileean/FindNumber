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
    
    var status:StatusGame = .start
    
    init(countItems: Int) {
        self.countItems = countItems
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
}
