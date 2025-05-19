//
//  IPInfoViewModel.swift
//  SwiftUIVPN
//
//  Created by Angelos Staboulis on 19/5/25.
//

import Foundation
import ipinfoKit
import SwiftyJSON
@MainActor
class IPInfoViewModel:ObservableObject{
    var ipInfo:[String:JSON] = [:]
    func fetchIPInfo(ipAddress:String,completion:@escaping((IPInfo)->())) {
        IPINFO.shared.getDetails(ip: ipAddress) { status, data, msg in
                switch status {
                    case .success:
                    do{
                        let ipInfo = try JSON(data:data)
                        
                        guard let city = ipInfo["city"].string else{
                            return
                        }
                        
                        guard let country = ipInfo["country"].string else{
                            return
                        }
                        
                        guard let org = ipInfo["org"].string else{
                            return
                        }
                        
                        guard let loc = ipInfo["loc"].string else{
                            return
                        }
                        
                        completion(IPInfo(city: city, country: country, org: org, loc: loc))
                        
                        
                       
                        
                    }catch{
                        print("something went wrong!!!!")
                    }
                    case .failure:
                        print(msg)
                }
            }

    }
}
