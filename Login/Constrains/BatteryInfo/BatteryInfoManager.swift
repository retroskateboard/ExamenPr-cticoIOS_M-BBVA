//
//  BatteryInfoManager.swift
//  Constrains
//
//  Created by Eric Rojas Pech on 27/11/23.
//

import Foundation
import Firebase
import FirebaseDatabase


class BatteryInfoManager {
    
    static let shared = BatteryInfoManager()
    
    private let databaseRef = Database.database().reference()
    private let batteryInfoKey = "BatteryInfo"
    
    private init() {}
    
    // Obtener la información actual de la batería
    func getCurrentBatteryInfo() -> BatteryInfo {
        let device = UIDevice.current
        return BatteryInfo(level: device.batteryLevel,
                           state: device.batteryState,
                           timestamp: Date())
    }
    
    // Guardar la información de la batería en UserDefaults
    func saveBatteryInfoLocally(_ batteryInfo: BatteryInfo) {
        let encodedData = try? JSONEncoder().encode(batteryInfo)
        UserDefaults.standard.set(encodedData, forKey: batteryInfoKey)
    }
    
    // Guardar la información de la batería en Firebase
    func saveBatteryInfoToFirebase(_ batteryInfo: BatteryInfo) {
        let batteryInfoRef = databaseRef.child("battery_info").childByAutoId()
        batteryInfoRef.setValue([
            "level": batteryInfo.level,
            "state": batteryInfo.state.rawValue,
            "timestamp": batteryInfo.timestamp.timeIntervalSince1970
        ])
    }
    
    // Obtener la información de la batería almacenada localmente
    func getLocalBatteryInfo() -> BatteryInfo? {
        guard let encodedData = UserDefaults.standard.data(forKey: batteryInfoKey),
              let batteryInfo = try? JSONDecoder().decode(BatteryInfo.self, from: encodedData)
        else {
            return nil
        }
        return batteryInfo
    }
    
    // Limpiar la información local de la batería
    func clearLocalBatteryInfo() {
        UserDefaults.standard.removeObject(forKey: batteryInfoKey)
    }
}

