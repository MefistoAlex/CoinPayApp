//
//  LocationManager.swift
//  CoinPay
//
//  Created by Alexandr Mefisto on 07.05.2025.
//

import SwiftUI
import MapKit


public final class LocationManager: NSObject, ObservableObject {
    @MainActor public static let shared = LocationManager()
    private let manager = CLLocationManager()
    private let geoCoder = CLGeocoder()
    
   public override init() {
        super.init()
        startMonitoring()
    }
    
    public func requestLocation() {
        manager.requestWhenInUseAuthorization()
    }
    
    private func startMonitoring() {
        manager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        manager.startUpdatingLocation()
    }
   
    func getCountryCode() async -> String? {
        guard let location = manager.location else { return nil }
        
        return await withUnsafeContinuation { result in
            geoCoder.reverseGeocodeLocation(location) { placemarks, error in
                if let places = placemarks {
                    places.forEach({ place in
                        result.resume(returning: place.isoCountryCode)
                    })
                }
            }
        }
    }
}
