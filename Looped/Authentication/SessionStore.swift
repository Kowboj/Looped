//
//  SessionStore.swift
//  Looped
//
//  Created by Piotr Torczyński on 30/11/2018.
//  Copyright © 2018 kowboj. All rights reserved.
//

import Foundation

protocol SessionStoring {

    func getSession() -> Session?
    func saveSession(session: Session)
    func deleteSession(session: Session)
}

final class SessionStore: SessionStoring {

    func getSession() -> Session? {
        return keychain[token]
    }

    func saveSession(session: Session) {

    }

    func deleteSession(session: Session) {

    }
}

