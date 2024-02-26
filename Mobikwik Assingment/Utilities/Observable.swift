//
//  Observable.swift
//  Mobikwik Assingment
//
//  Created by Arpit Dwivedi on 25/02/24.
//

import Foundation

final class Observable<T> {
    typealias Observer = (T) -> Void
    
  private var observer: Observer?
    
    var value: T {
        didSet {
            observer?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(observer: Observer?) {
        self.observer = observer
        observer?(value)
    }
}
