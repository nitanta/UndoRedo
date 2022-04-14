//Copyright © 2022 and Confidential to ___ORGANIZATIONNAME___ All rights reserved.
   

import SwiftUI
import Combine

enum Way {
    case appleWay
    case customWay
}

struct UndoRedoView: View {
    
    @StateObject var viewModel = UndoRedoViewModel(type: .customWay)
    
    var body: some View {
        VStack {
            ListView
            
            Spacer()
            
            ButtonView
        }
    }
    
    private var ListView: some View {
        VStack {
            ForEach($viewModel.datasource.wrappedValue, id: \.self) { data in
                CellView(student: data)
            }
        }
    }
    
    private var ButtonView: some View {
        HStack {
            Button {
                viewModel.undoEntry()
            } label: {
                Text(Constants.undo)
            }
            .disabled(!$viewModel.enableUndo.wrappedValue)
            
            Spacer()
            
            Button {
                viewModel.redoEntry()
            } label: {
                Text(Constants.redo)
            }
            .disabled(!$viewModel.enableRedo.wrappedValue)
            
            Spacer()
            
            Button {
                viewModel.addNewEntry()
            } label: {
                Text(Constants.add)
            }
            
        }
        .padding(20)
    }
}


extension UndoRedoView {
    struct Constants {
        static let undo = "UNDO"
        static let redo = "REDO"
        static let add = "ADD"
    }
}

struct UndoRedoView_Previews: PreviewProvider {
    static var previews: some View {
        UndoRedoView(viewModel: UndoRedoViewModel(type: .appleWay))
    }
}
