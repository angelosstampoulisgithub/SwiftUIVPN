//
//  VPNManager.swift
//  SwiftUIVPN
//
//  Created by Angelos Staboulis on 19/5/25.
//

import Foundation
import ExtensionKit
import Security
import NetworkExtension
import SystemConfiguration.CaptiveNetwork
import ipinfoKit
struct VPNManager{
      private static let vpnProtocolsKeysIdentifiers = [
          "tap", "tun", "ppp", "ipsec", "utun"
      ]

      static func isVpnActive() -> Bool {
          guard let cfDict = CFNetworkCopySystemProxySettings() else { return false }
          let nsDict = cfDict.takeRetainedValue() as NSDictionary
          guard let keys = nsDict["__SCOPED__"] as? NSDictionary,
              let allKeys = keys.allKeys as? [String] else { return false }

          for key in allKeys {
              for protocolId in vpnProtocolsKeysIdentifiers
                  where key.starts(with: protocolId) {
                  return true
              }
          }
          return false
      }
      static func getIPAddress() -> String{
          let host = CFHostCreateWithName(nil,"p-us21.urban-vpn.com" as CFString).takeRetainedValue()
          CFHostStartInfoResolution(host, .addresses, nil)
          var success: DarwinBoolean = false
          var getIPAddress:String = "0.0.0"
          if let addresses = CFHostGetAddressing(host, &success)?.takeUnretainedValue() as NSArray? {
              for case let theAddress as NSData in addresses {
                  var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                  if getnameinfo(theAddress.bytes.assumingMemoryBound(to: sockaddr.self), socklen_t(theAddress.length),
                                 &hostname, socklen_t(hostname.count), nil, 0, NI_NUMERICHOST) == 0 {
                      let numAddress = String(cString: hostname)
                      getIPAddress = numAddress
                  }
              }
          }
          return getIPAddress

    }
    func fetchIPInfo(){
        
    }
    
}
