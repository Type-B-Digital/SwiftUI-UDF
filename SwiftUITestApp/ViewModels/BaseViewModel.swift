//
//  BaseViewModel.swift
//  SwiftUITestApp
//
//  Created by Kavindu Dissanayake on 2025-08-27.
//

import Foundation
import ReSwift
import Combine

class BaseViewModel: ObservableObject, StoreSubscriber {
    @Published var isLoading: Bool = false
    var actionIds: [String] = []

    init() {
        store.subscribe(self)
    }

    deinit {
        store.unsubscribe(self)
    }

    func newState(state: AppState) {
        var loading = false
        for id in actionIds {
            guard let action = state.systemStateUpdateTracker[id] else { continue }
            switch action.getState() {
            case .COMPLETED:
                if onStateUpdate(state: state, action: action) {
                    cleanup(id: id)
                }
            case .ERROR:
                onError(error: action.getError(), action: action)
                cleanup(id: id)
            default:
                loading = true
            }
        }
        isLoading = loading
    }

    func dispatchAction(_ action: BaseAction) {
        let id = UUID().uuidString
        actionIds.append(id)
        isLoading = true
        store.dispatch(TrackedAction(actionId: id, innerAction: action))
    }

    private func cleanup(id: String) {
        actionIds.removeAll { $0 == id }
        store.dispatch(RemoveStateStatus.perform(actionId: id))
    }

    // MARK: - Override in subclasses

    /// Called when an action is completed successfully. Return true if you handled the update.
    func onStateUpdate(state: AppState, action: BaseAction?) -> Bool {
        return false
    }

    /// Called when an action fails.
    func onError(error: APIError?, action: BaseAction?) {}
}
