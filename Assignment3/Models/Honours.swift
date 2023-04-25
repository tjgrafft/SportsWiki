//
//  Honours.swift
//  Assignment3
//
//  Created by Taylor Grafft on 4/20/23.
//

import Foundation

struct Honour: Codable, Identifiable {
    let id: String
    let idPlayer, idTeam: String
    let strSport, strPlayer, strTeam: String
    let strHonour, strSeason, intChecked: String
}
