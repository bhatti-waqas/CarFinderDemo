//
//  CarRowViewModel.swift
//  SIXTCoddingChallenge
//
//  Created by Waqas Naseem on 10/19/21.
//

import Foundation

struct CarRowViewModel: Equatable {
    let id: String
    let name: String
    let licensePlate: String
    let carImageUrl: String
}

extension CarRowViewModel: Hashable {
//    static func == (lhs: CarRowViewModel, rhs: CarRowViewModel) -> Bool {
//        lhs.id == rhs.id
//    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
