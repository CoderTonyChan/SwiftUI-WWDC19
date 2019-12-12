//
//  PageViewController.swift
//  SwiftUI-WWDC19
//
//  Created by Tony Chan on 2019/12/12.
//  Copyright © 2019 Tony Chan. All rights reserved.
//

import SwiftUI

struct PageViewController: UIViewControllerRepresentable {
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    @Binding var currentPage: Int
    
    var controllers: [UIViewController]
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<PageViewController>) -> UIPageViewController {
        let pageViewController = UIPageViewController(
            transitionStyle: .scroll,
            navigationOrientation: .horizontal)
        pageViewController.dataSource = context.coordinator
        pageViewController.delegate = context.coordinator
        return pageViewController
    }
    
    func updateUIViewController(_ uiViewController: UIPageViewController, context: UIViewControllerRepresentableContext<PageViewController>) {
        uiViewController.setViewControllers(
        [controllers[currentPage]], direction: .forward, animated: true)
    }
    
    class Coordinator: NSObject, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
           var parent: PageViewController

           init(_ pageViewController: PageViewController) {
               self.parent = pageViewController
           }

           func pageViewController(
               _ pageViewController: UIPageViewController,
               viewControllerBefore viewController: UIViewController) -> UIViewController?
           {
               guard let index = parent.controllers.firstIndex(of: viewController) else {
                   return nil
               }
               if index == 0 {
                   return parent.controllers.last
               }
               return parent.controllers[index - 1]
           }

           func pageViewController(
               _ pageViewController: UIPageViewController,
               viewControllerAfter viewController: UIViewController) -> UIViewController?
           {
               guard let index = parent.controllers.firstIndex(of: viewController) else {
                   return nil
               }
               if index + 1 == parent.controllers.count {
                   return parent.controllers.first
               }
               return parent.controllers[index + 1]
           }
        
        
            func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
                if completed,
                    let visibleViewController = pageViewController.viewControllers?.first,
                    let index = parent.controllers.firstIndex(of: visibleViewController) {
                    parent.currentPage = index
                }
            }
       }
}
