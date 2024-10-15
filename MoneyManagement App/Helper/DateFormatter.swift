//
//  DateFormatter.swift
//  MoneyManagement App
//
//  Created by Caio Marques on 15/10/24.
//

import Foundation

let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()
