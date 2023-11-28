//
//  BatteryModel.swift
//  Constrains
//
//  Created by Eric Rojas Pech on 27/11/23.
//

import Foundation
import UIKit
import Firebase


struct BatteryInfo: Codable {
    let level: Float
    let state: UIDevice.BatteryState
    let timestamp: Date

    enum CodingKeys: String, CodingKey {
        case level
        case state
        case timestamp
    }

    init(level: Float, state: UIDevice.BatteryState, timestamp: Date) {
        self.level = level
        self.state = state
        self.timestamp = timestamp
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        level = try container.decode(Float.self, forKey: .level)

        let stateRawValue = try container.decode(Int.self, forKey: .state)
        guard let batteryState = UIDevice.BatteryState(rawValue: stateRawValue) else {
            throw DecodingError.dataCorruptedError(
                forKey: .state,
                in: container,
                debugDescription: "Invalid raw value for UIDevice.BatteryState"
            )
        }
        state = batteryState

        timestamp = try container.decode(Date.self, forKey: .timestamp)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(level, forKey: .level)
        try container.encode(state.rawValue, forKey: .state)
        try container.encode(timestamp, forKey: .timestamp)
    }
}

