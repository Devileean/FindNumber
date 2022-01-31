//
//  Game.swift
//  FindNumber
//
//  Created by Алексей Логинов on 31.01.2022.
//

import Foundation
    
class Game {

    struct Item{
        var title: String
        var isFound: Bool = false
    }
    
    private let data = Array(1...99) //отображать числа на кнопках с помощью этого массива
    private var items:[Item] = [] // массив кнопок
    private var countItems: Int
    
    init(countItems: Int) {
        self.countItems = countItems
    }
    
    //создадим функцию для создания items
    private func setupGame() {
        var digits = data.shuffled() //чтобы перемешивать массив(c помощью shuffled)
        
        while items.count < countItems {
            let item = Item(title: String(digits.removeFirst()))
            items.append(item)
        }
    }
}
