//
//  LaunchRequest.swift
//  Ebay_t
//
//  Created by Pavle Mijatovic on 12.5.21..
//

import Foundation

struct LaunchRequest {
    let limit: Int = 10
}

extension LaunchRequest {
    func body() -> NetworkService.JSON {
        let params: [String: Any] = [
            "limit": self.limit,
        ]
        return params
    }
}
