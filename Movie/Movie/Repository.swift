// Repository.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

// дженерик протокол без ассоциативных типов
// Паттерн репозиторий позволяет абстрогоритьваться от БД и в дальнейшем ее подменять
// 1)
protocol DatabaseProtocol {
    // 2)создаем ассоциативный тип
//    associatedtype Entity
    func get() -> Results
    func add(object: Results)
    func remove(id: Int)
}

// делаем 2 сущности для работы с рилмом и кор датой
// 3)
// class Book {
//    var id: Int
//
//    init(id: Int) {
//        self.id = id
//    }
// }
// реализуем класс который рабоатет с CoreData
// 4)
final class CoreDataMovies: DatabaseProtocol {
    // В данном случае тип Entity соответствует реализации которую мы выберем ( по типу дженерика )
    // 4.1)
//    typealias Entity = Movies
    func get() -> Results {
        Results(id: 2, title: "", overview: "", voteAverage: 2, posterPath: "", releaseDate: "")
    }

    func add(object _: Results) {}
    func remove(id _: Int) {}
}

// реализуем класс который рабоатет с CoreData
// 4)
final class RealmMovies: DatabaseProtocol {
    // В данном случае тип Entity соответствует реализации которую мы выберем ( по типу дженерика )
    // 4.1)
    typealias Entity = Results
    func get() -> Results {
        Results(id: 2, title: "", overview: "", voteAverage: 2, posterPath: "", releaseDate: "")
    }

    func add(object _: Results) {}
    func remove(id _: Int) {}
}

// Нужно добавить Presenter
// Мы должны добавить вложенный дженерик\. иначе компилятор будет ругаться
// 5) и 5.1)
final class Repository {
    var dataBase: DatabaseProtocol
    init(dataBase: DatabaseProtocol) {
        self.dataBase = dataBase
    }

    func getMovie() -> Results {
        dataBase.get()
    }

    func save(obj: Results) {
        dataBase.add(object: obj)
    }

    func deleteAll(obj: Results) {
        dataBase.remove(id: obj.id ?? 0)
    }
}

// final class Repository {
//    // 6)
//    // реализуем сущность презентера и указываем тип CoreData
//    let presenterCoreData = DataPresenter<CoreDataMovies>(dataBase: CoreDataMovies())
//    let presenterRealm = DataPresenter<RealmMovies>(dataBase: RealmMovies())
//    func realmPresentor() {}
// }
