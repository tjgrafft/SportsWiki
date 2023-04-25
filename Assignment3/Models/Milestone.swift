//
//  Milestone.swift
//  Assignment3
//
//  Created by Taylor Grafft on 3/27/23.
//

import Foundation

struct Milestone: Codable, Identifiable {
    let idMilestone: String
    let idPlayer: String
    let strPlayer: String
    let idTeam: String
    let strTeam: String
    let strSport: String
    let strMilestone: String
    let strMilestoneLogo: String
    let dateMilestone: String
    
    var id: String {
        idMilestone
    }
}
