//
//  RoomDetail.swift
//  te
//
//  Created by Tony Chan on 2019/12/10.
//  Copyright © 2019 Tony Chan. All rights reserved.
//

import SwiftUI

struct RoomDetail: View {
    let room: Room
    
    @State private var zoomed = false
    
    var body: some View {
        ZStack(alignment: .topLeading, content: {
            Image(room.imageName)
                .resizable()
                .aspectRatio(contentMode: zoomed ? .fill:.fit)
                .navigationBarTitle(Text(room.name),displayMode: .inline)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                .onTapGesture {
                    withAnimation(){
                        self.zoomed.toggle();
                    }
                }
                
            if room.hasVideo && !zoomed {
                Image(systemName: "video.fill")
                    .font(.title)
                .padding()
                    .transition(.move(edge: .leading))
            }
        })
    }
}

struct RoomDetail_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView{
                    RoomDetail(room: testData[0])
            }
            NavigationView{
                    RoomDetail(room: testData[1])
            }
        }
    }
}
