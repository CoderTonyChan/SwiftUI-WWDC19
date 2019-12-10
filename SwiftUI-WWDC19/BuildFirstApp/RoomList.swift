//
//  RoomList.swift
//  te
//
//  Created by Tony Chan on 2019/12/9.
//  Copyright © 2019 Tony Chan. All rights reserved.
//

import SwiftUI
import Combine

struct RoomList: View {
    
    @ObservedObject var store = RoomStore()
    var body: some View {
        NavigationView{
            List{
                Section{
                    Button(action: addRoom){ Text("add") }
                }
                Section{
                    ForEach(store.rooms){ room in
                        RoomCell(room: room)
                    }
                    .onDelete(perform: delete)
                    .onMove(perform: move)
                }
            }.listStyle(GroupedListStyle())
            .foregroundColor(Color.blue)
            .navigationBarTitle(Text("Rooms"))
            .navigationBarItems(trailing: EditButton())
        }
    }
    
    func addRoom() {
        store.rooms.append(Room(name: "meeting", capacity: 2000))
    }
    func delete(at offsets: IndexSet) {
        store.rooms.remove(atOffsets: offsets)
    }
    func move(from source: IndexSet, to destination: Int) {
        store.rooms.move(fromOffsets: source, toOffset: destination)
    }
}

struct RoomList_Previews: PreviewProvider {
    static var previews: some View {
        RoomList(store: RoomStore(testData))
    }
}

struct RoomCell: View {
    let room: Room
    var body: some View {
        return NavigationLink(destination:RoomDetail(room: room)){
            Image(room.name)
                .frame(width: 40.0, height: 40.0)
                .cornerRadius(10)
            VStack(alignment: .leading, spacing: 0.0) {
                Text(room.name)
                Text("\(room.capacity) people")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
    }
}
