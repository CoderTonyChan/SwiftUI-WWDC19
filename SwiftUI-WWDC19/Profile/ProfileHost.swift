//
//  ProfileHost.swift
//  SwiftUI-WWDC19
//
//  Created by Tony Chan on 2019/12/12.
//  Copyright © 2019 Tony Chan. All rights reserved.
//

import SwiftUI

struct ProfileHost: View {
    // 用处？
    @Environment(\.editMode) var mode
    @State var draftProfile = Profile.default
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        VStack(alignment: HorizontalAlignment.leading, spacing: 20) {
            HStack {
                if self.mode?.wrappedValue == .active {
                    Button("Cancel") {
                        self.draftProfile = self.userData.profile // 还原
                        self.mode?.animation().wrappedValue = .inactive
                    }
                }
                Spacer()
                // 右边
                EditButton()
            }
            
            if self.mode?.wrappedValue == .inactive {
                ProfileSummary(profile: userData.profile)
            } else {
                ProfileEditor(profile: $draftProfile)
                .onAppear {
                    self.draftProfile = self.userData.profile
                }
                .onDisappear {
                    self.userData.profile = self.draftProfile
                }
            }
        }.padding()
    }
}

struct ProfileHost_Previews: PreviewProvider {
    static var previews: some View {
        ProfileHost().environmentObject(UserData())
    }
}
