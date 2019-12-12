//
//  PageView.swift
//  SwiftUI-WWDC19
//
//  Created by Tony Chan on 2019/12/12.
//  Copyright © 2019 Tony Chan. All rights reserved.
//

import SwiftUI

struct PageView<Page: View>: View {
    var viewControllers: [UIHostingController<Page>]
    @State var currentPage = 0
    
    init(_ views: [Page]) {
        self.viewControllers = views.map { UIHostingController(rootView: $0) }
    }

    
    var body: some View {
//        VStack {
//            PageViewController(currentPage: $currentPage, controllers: viewControllers)
//            Text("Current Page: \(currentPage)")
//        }
        ZStack(alignment: .bottomTrailing) {
            PageViewController(currentPage: $currentPage, controllers: viewControllers)
            PageControl(numberOfPages: viewControllers.count, currentPage: $currentPage)
                .padding(.trailing)
        }
    }
}

struct PageView_Previews: PreviewProvider {
    static var previews: some View {
        PageView(features.map { FeatureCard(landmark: $0) })
    }
}
