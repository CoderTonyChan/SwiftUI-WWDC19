//
//  RoomStore.swift
//  te
//
//  Created by Tony Chan on 2019/12/10.
//  Copyright © 2019 Tony Chan. All rights reserved.
//

import UIKit
import Combine

class RoomStore: ObservableObject {
    
    @Published var rooms:[Room] = []
    
    init(_ rooms:[Room] = []) {
        self.rooms = rooms
    }

}
