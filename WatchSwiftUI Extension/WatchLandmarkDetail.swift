//
//  WatchLandmarkDetail.swift
//  WatchSwiftUI Extension
//
//  Created by Tony Chan on 2019/12/12.
//  Copyright © 2019 Tony Chan. All rights reserved.
//

import SwiftUI

struct WatchLandmarkDetail: View {
    @EnvironmentObject var userData: UserData
    var landmark: Landmark
    
    var landmarkIndex: Int {
        userData.landmarks.firstIndex(where: { $0.id == landmark.id })!
    }
    
    
    var body: some View {
        ScrollView {
            VStack {
                CircleImage(image: self.landmark.image.resizable())
                    .scaledToFit()
                
                Text(self.landmark.name)
                    .font(.headline)
                    .lineLimit(0)
                
                Toggle(isOn:
                $userData.landmarks[self.landmarkIndex].isFavorite) {
                    Text("Favorite")
                }
                
                Divider()
                
                Text(self.landmark.park)
                    .font(.caption)
                    .bold()
                    .lineLimit(0)
                
                Text(self.landmark.state)
                    .font(.caption)
                
                
                Divider()
                
                WatchMapView(landmark: self.landmark)
                    .scaledToFit()
                    .padding()
            }.padding(16)
        }
    }
}

struct WatchLandmarkDetail_Previews: PreviewProvider {
    static var previews: some View {
        let userData = UserData()
        return Group {
            WatchLandmarkDetail(landmark: userData.landmarks[0]).environmentObject(userData)
                .previewDevice("Apple Watch Series 4 - 44mm")
            
            WatchLandmarkDetail(landmark: userData.landmarks[1]).environmentObject(userData)
                .previewDevice("Apple Watch Series 2 - 38mm")
        }
    }
}
