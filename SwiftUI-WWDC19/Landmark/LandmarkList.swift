//
//  LandmarkList.swift
//  Essentials
//
//  Created by Tony Chan on 2019/12/11.
//  Copyright © 2019 Tony Chan. All rights reserved.
//

import SwiftUI

struct LandmarkList: View {
//    @State var showFavoritesOnly = false
    @EnvironmentObject var userData: UserData
    
    
    var body: some View {
        NavigationView{
            List {
                // 这里Toggle是用了binding
                Toggle(isOn: $userData.showFavoritesOnly){
                    Text("Favorites only")
                }
                
                ForEach(userData.landmarks){landmark in
                    if !self.userData.showFavoritesOnly || landmark.isFavorite{
                        NavigationLink(destination: LandmarkDetail(landmark:landmark).environmentObject(self.userData)){
                            LandmarkRow(landmark: landmark)
                        }
                    }
                }
            }.navigationBarTitle("Landmarks")
        }
    }
}

struct LandmarkList_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone SE", "iPhone XS Max"], id: \.self) { deviceName in
            LandmarkList()
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
        }.environmentObject(UserData())
    }
}
