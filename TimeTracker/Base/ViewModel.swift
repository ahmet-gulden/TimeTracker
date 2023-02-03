//
//  ViewModel.swift
//  TimeTracker
//
//  Created by Ahmet Gülden on 2.02.2023.
//

import Foundation

/// State change protocol to handle changes of state of view model.
protocol StateChange {

}

/// View model with state. Can notify state changes to the listener.
class ViewModel<SC: StateChange> {

    private var handler: ((SC) -> ())?

    /// Sets the state change handler.
    ///
    /// - Parameter handler: Handler to be executed when state of view model changes.
    func setStateChangeHandler(_ handler: @escaping ((SC) -> ())) {
        self.handler = handler
    }

    /// Fires changes that occur in view model.
    ///
    /// - Parameter stateChange: Related state change.
    func emit(_ stateChange: SC) {
        handler?(stateChange)
    }
}
