//
//  Participant.swift
//  Ignite Teams
//
//  Created by Yuri Correa on 24/06/24.
//

import Foundation

enum Team {
    case A
    case B
}

struct Participant {
    let id: Int
    let name: String
    let team: Team
}
