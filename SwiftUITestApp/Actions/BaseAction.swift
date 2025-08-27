//
//  BaseAction.swift
//  SwiftUITestApp
//
//  Created by Kavindu Dissanayake on 2025-08-27.
//

import ReSwift

protocol BaseAction: Action {
    func getState() -> ActionStatus
    func getError() -> APIError?
}

enum RemoveStateStatus: BaseAction {
    case perform(actionId: String)
    func getState() -> ActionStatus { .COMPLETED }
    func getError() -> APIError? { nil }
}

struct TrackedAction: Action {
    let actionId: String
    let innerAction: BaseAction
}

enum ActionStatus {
    case INIT        // The action has been dispatched but not started
    case IN_PROGRESS // The action is currently executing (optional)
    case COMPLETED   // The action finished successfully
    case ERROR       // The action failed
}
