//
//  UserData.swift
//  Essentials
//
//  Created by Tony Chan on 2019/12/11.
//  Copyright © 2019 Tony Chan. All rights reserved.
//

import SwiftUI
import Combine

final class UserData: ObservableObject{
    @Published var showFavoritesOnly = false
    @Published var landmarks = landmarkData
}



