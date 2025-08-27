//
//  Store.swift
//  SwiftUITestApp
//
//  Created by Kavindu Dissanayake on 2025-08-27.
//

import ReSwift

let store = Store<AppState>(
    reducer: appReducer,
    state: nil,
    middleware: [followersMiddleware]
)
