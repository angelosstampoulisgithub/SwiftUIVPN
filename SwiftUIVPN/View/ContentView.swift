//
//  ContentView.swift
//  SwiftUIVPN
//
//  Created by Angelos Staboulis on 19/5/25.
//

import SwiftUI
import NetworkExtension
import Security.SecIdentity
import MapKit
import ipinfoKit
import SwiftyJSON
struct ContentView: View {
    @State var choice:Bool = false
    @State var ipAddress:String
    @StateObject var viewModel:IPInfoViewModel
    @State var model:IPInfo
    @State var lat:Double
    @State var lon:Double
    var body: some View {
        NavigationStack{
            VStack {
                HStack{
                    Text("IP Address").frame(width:250,alignment: .leading)
                    Text(ipAddress).frame(width:125,alignment: .trailing)
                }.padding(10)
                HStack{
                    Text("City").frame(width:250,alignment: .leading)
                    Text(model.city).frame(width:125,alignment: .trailing)
                }.padding(10)
                HStack{
                    Text("Country").frame(width:250,alignment: .leading)
                    Text(model.country).frame(width:125,alignment: .trailing)
                }.padding(10)
                HStack{
                    Text("Organization").frame(width:250,alignment: .leading)
                    Text(model.org).frame(width:125,alignment: .trailing)
                }.padding(10)
                HStack{
                    Toggle("VPN", isOn: $choice)
                }.frame(width:380,alignment: .center)
                Map{
                    Marker(coordinate: CLLocationCoordinate2D(latitude: lat, longitude: lon)) {
                        Text(model.city)
                    }
                }
            }.task{
                if VPNManager.isVpnActive(){
                    ipAddress = VPNManager.getIPAddress()
                    viewModel.fetchIPInfo(ipAddress: ipAddress) { info in
                        model = info
                        let coordinates = model.loc.components(separatedBy: ",")
                        if let getLat = Double(coordinates[0]){
                            lat = getLat
                        }
                        if let getLon = Double(coordinates[1]){
                            lon = getLon
                        }
                    }
                    choice.toggle()

                }
            }
            .navigationTitle("VPN Manager")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

