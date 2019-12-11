//
//  ContentView.swift
//  Essentials
//
//  Created by Tony Chan on 2019/12/11.
//  Copyright © 2019 Tony Chan. All rights reserved.
//

import SwiftUI

struct LandmarkDetail: View {
    // 这个相当于数据源
    var landmark: Landmark
    
    @EnvironmentObject var userData: UserData
    
    
    var landmarkIndex: Int {
        userData.landmarks.firstIndex(where: { $0.id == landmark.id })!
    }
    
    var body: some View {
        VStack {
            MapView(coordinate: landmark.locationCoordinate).frame(height: 300).edgesIgnoringSafeArea(.top)
            CircleImage(image: landmark.image)
                .offset(y:-130).padding(.bottom,-130)
            VStack(alignment: .leading) {
                HStack {
                    Text(landmark.name).font(.title)
                    Button(action: {
                        // 只能对应一个状态 或者用@State 是一个双向绑定
                        // 所以是只读
                        // landmark.isFavorite.toggle()
                        
                        // 正确的写法
                        self.userData.landmarks[self.landmarkIndex]
                            .isFavorite.toggle()
                    }){
                        // 这里也要用EnvironmentObject的值 不然有bug 其他值如果可以修改的话 也需要换
                        if self.userData.landmarks[self.landmarkIndex].isFavorite {
                            Image(systemName: "star.fill")
                                .foregroundColor(Color.yellow)
                        } else {
                            Image(systemName: "star")
                                .foregroundColor(Color.gray)
                        }
                    }
                }
                
                HStack(alignment: .top) {
                    Text(landmark.park).font(.subheadline)
                    Spacer()
                    Text(landmark.state).font(.subheadline)
                }
            }.padding()
            Spacer()
        }.navigationBarTitle(Text(verbatim: landmark.name), displayMode: .inline)
    }
}

struct LandmarkDetail_Previews: PreviewProvider {
    static var previews: some View {
        LandmarkDetail(landmark:landmarkData[0]).environmentObject(UserData())
    }
}
