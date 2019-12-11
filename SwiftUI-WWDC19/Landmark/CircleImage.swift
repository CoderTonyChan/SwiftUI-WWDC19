//
//  CircleImage.swift
//  Essentials
//
//  Created by Tony Chan on 2019/12/11.
//  Copyright © 2019 Tony Chan. All rights reserved.
//

import SwiftUI

struct CircleImage: View {
    
    var image: Image
    
    var body: some View {
        image
            .clipShape(Circle())
            .overlay(Circle()
            .stroke(Color.white,lineWidth: 2))
            .shadow(radius: 10)
    }
}

struct CircleImage_Previews: PreviewProvider {
    static var previews: some View {
        CircleImage(image: Image("turtlerock"))
    }
}
