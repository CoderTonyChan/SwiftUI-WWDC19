//
//  PageControl.swift
//  SwiftUI-WWDC19
//
//  Created by Tony Chan on 2019/12/12.
//  Copyright © 2019 Tony Chan. All rights reserved.
//

import SwiftUI

struct PageControl: UIViewRepresentable {
    var numberOfPages: Int
    @Binding var currentPage: Int
    
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }


    func makeUIView(context: Context) -> UIPageControl {
        let control = UIPageControl()
        control.numberOfPages = numberOfPages
        control.addTarget(
        context.coordinator,
        action: #selector(Coordinator.updateCurrentPage(sender:)),
        for: .valueChanged)
        return control
    }

    func updateUIView(_ uiView: UIPageControl, context: Context) {
        uiView.currentPage = currentPage
    }
    
    
    class Coordinator: NSObject {
        var control: PageControl

        init(_ control: PageControl) {
            self.control = control
        }

        @objc func updateCurrentPage(sender: UIPageControl) {
            control.currentPage = sender.currentPage
        }
    }
}

struct PageControl_Previews: PreviewProvider {
    static var previews: some View {
//        PageControl()
        EditButton()
    }
}
