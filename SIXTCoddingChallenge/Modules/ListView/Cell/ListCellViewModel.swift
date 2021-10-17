//
//  ListCellViewModel.swift
//  SIXTCoddingChallenge
//
//  Created by Waqas Naseem on 10/18/21.
//

import Foundation

struct ListCellViewModel {
    let id: String
    let name: String
    let licensePlate: String
    let carImageUrl: String
}

extension ListCellViewModel: Hashable {
    static func == (lhs: ListCellViewModel, rhs: ListCellViewModel) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
