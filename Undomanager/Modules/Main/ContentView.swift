//Copyright © 2022 and Confidential to ___ORGANIZATIONNAME___ All rights reserved.
   

import SwiftUI

struct ContentView: View {
    
    @State var datasource: [Student] = []
    @State var showListing = false
    @State var mode: Way = .appleWay

    var body: some View {
        VStack {
            ButtonView
        }
    }
    
    
    private var ButtonView: some View {
        VStack {
            
            Group {
                NavigationLink(destination: UndoRedoView(viewModel: UndoRedoViewModel(type: $mode.wrappedValue)), isActive: $showListing) { EmptyView() }
            }
            
            Button {
                mode = .appleWay
                showListing.toggle()
            } label: {
                Text(Constants.appleWay)
            }
            
            Spacer()
                .frame(height: 20)
            
            Button {
                mode = .customWay
                showListing.toggle()
            } label: {
                Text(Constants.customWay)
            }
            
        }
        .padding(20)
    }
}

extension ContentView {
    struct Constants {
        static let appleWay = "APPLE WAY"
        static let customWay = "CUSTOM WAY"
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
