//
//  LandmarkList.swift
//  Essentials
//
//  Created by Tony Chan on 2019/12/11.
//  Copyright © 2019 Tony Chan. All rights reserved.
//

import SwiftUI

struct LandmarkList<DetailView: View>: View {
//    @State var showFavoritesOnly = false
    @EnvironmentObject var userData: UserData
    
    // 方法来的 传方法相当于闭包(会回调出去Landmark)
    let detailViewProducer: (Landmark) -> DetailView
    
    var body: some View {
            List {
                // 这里Toggle是用了binding
                Toggle(isOn: $userData.showFavoritesOnly){
                    Text("Favorites only")
                }
                
                ForEach(userData.landmarks){landmark in
                    if !self.userData.showFavoritesOnly || landmark.isFavorite{
                        NavigationLink(destination:
                        self.detailViewProducer(landmark).environmentObject(self.userData)){
                            LandmarkRow(landmark: landmark)
                        }
                    }
                }
            }.navigationBarTitle("Landmarks")
        }
}



#if os(watchOS)
typealias PreviewDetailView = WatchLandmarkDetail
#else
typealias PreviewDetailView = LandmarkDetail
#endif

struct LandmarkList_Previews: PreviewProvider {
    static var previews: some View {
//        ForEach(["iPhone SE", "iPhone XS Max"], id: \.self) { deviceName in
//            NavigationView{
//                LandmarkList { LandmarkDetail(landmark: $0) }
//                    .previewDevice(PreviewDevice(rawValue: deviceName))
//                    .previewDisplayName(deviceName)
//            }
//        }.environmentObject(UserData())
        LandmarkList { PreviewDetailView(landmark: $0) }
        .environmentObject(UserData())
    }
}
