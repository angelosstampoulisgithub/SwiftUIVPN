//
//  IPInfo.swift
//  SwiftUIVPN
//
//  Created by Angelos Staboulis on 19/5/25.
//

import Foundation
struct IPInfo:Identifiable{
    let id = UUID()
    let city:String
    let country:String
    let org:String
    let loc:String
}
