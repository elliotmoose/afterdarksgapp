//
//  Event.swift
//  AfterDarkSG
//
//  Created by Koh Yi Zhi Elliot - Ezekiel on 20/4/18.
//  Copyright © 2018 Kohbroco. All rights reserved.
//

import Foundation

//public class Event<T> {
public class Event {
    typealias EventHandler = () -> ()
    
    private var eventHandlers = [EventHandler]()
    
    func addHandler(handler: @escaping EventHandler) {
        eventHandlers.append(handler)
    }
    
    func raise() {
        for handler in eventHandlers {
            handler()
        }
    }
    
//    func raise(_ data: T) {
//        for handler in eventHandlers {
//            handler(data)
//        }
//    }
}


public class EventWithType<T> {
//public class Event {
    typealias EventHandler = (T) -> ()
    
    private var eventHandlers = [EventHandler]()
    
    func addHandler(handler: @escaping EventHandler) {
        eventHandlers.append(handler)
    }
    
//    func raise() {
//        for handler in eventHandlers {
//            handler()
//        }
//    }
    
        func raise(_ data: T) {
            for handler in eventHandlers {
                handler(data)
            }
        }
}
