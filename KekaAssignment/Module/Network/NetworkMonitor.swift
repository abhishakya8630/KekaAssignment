//
//  NetworkMonitor.swift
//  KekaAssignment
//
//  Created by Abhishek Shakya on 23/04/24.
//

import SystemConfiguration

final class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    func isConnectedToNetwork() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        return flags.contains(.reachable) && !flags.contains(.connectionRequired)
    }
}
