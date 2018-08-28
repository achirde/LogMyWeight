//
//  WeightLog.swift
//  LogMyWeight
//
//  Created by Arkadipra De on 8/26/18.
//  Copyright © 2018 Achirangshu. All rights reserved.
//

import Foundation
import RealmSwift

class WeightLog : Object {
    @objc dynamic var weight : Double = 0.0
    @objc dynamic var dateAdded : Date = Date()
}
