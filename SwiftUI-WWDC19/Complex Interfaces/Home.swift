//
//  Home.swift
//  SwiftUI-WWDC19
//
//  Created by Tony Chan on 2019/12/12.
//  Copyright © 2019 Tony Chan. All rights reserved.
//

import SwiftUI

struct Home: View {
    
    @State var showingProfile = false
    @EnvironmentObject var userData: UserData
    
    var categories: [String: [Landmark]] {
        // Dict有方法直接数组转字典
        Dictionary(
            grouping: landmarkData,
            by: { $0.category.rawValue }
        )
    }
    
    var featured: [Landmark] {
        landmarkData.filter { $0.isFeatured }
    }
    
    var body: some View {
        NavigationView {
            List {
                PageView(features.map { FeatureCard(landmark: $0) }).frame(height: 200).scaledToFill().listRowInsets(EdgeInsets())
//                FeaturedLandmarks(landmarks: featured)
//                .scaledToFill()
//                .frame(height: 200)
//                .clipped().listRowInsets(EdgeInsets())
                
                ForEach(categories.keys.sorted(), id: \.self) { key in
                    CategoryRow(categoryName: key, items: self.categories[key]!)
                }.listRowInsets(EdgeInsets())
                
                //NavigationLink里面不能嵌套NavigationView
                NavigationLink(destination: LandmarkList { LandmarkDetail(landmark: $0) }) {
                    Text("See All")
                }
            }
            .navigationBarTitle(Text("Featured"))
            .navigationBarItems(trailing: profileButton)
            .sheet(isPresented: $showingProfile) {
                ProfileHost().environmentObject(self.userData)
            }
        }
    }
    
    var profileButton: some View {
        Button(action: { self.showingProfile.toggle() }) {
            Image(systemName: "person.crop.circle")
                .imageScale(.large)
                .accessibility(label: Text("User Profile"))
                .padding()
        }
    }
}

struct FeaturedLandmarks: View {
    var landmarks: [Landmark]
    var body: some View {
        landmarks[0].image.resizable()
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        // 最初这里要存一份就可以全局拿到 SwiftUI全局一份
        Home().environmentObject(UserData())
    }
}
