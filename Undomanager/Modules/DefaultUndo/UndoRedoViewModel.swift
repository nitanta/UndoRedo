//Copyright © 2022 and Confidential to ___ORGANIZATIONNAME___ All rights reserved.
   

import Foundation
import Combine

final class UndoRedoViewModel: ObservableObject {
    
    @Published var datasource: [Student] = []
    @Published var enableUndo: Bool = false
    @Published var enableRedo: Bool = false

    let type: Way
    
    lazy var defaultUndoManager: UndoManager = {
        UndoManager()
    }()
    
    lazy var customUndoManager: UndoRedoManager = {
        UndoRedoManager<Student>()
    }()
    
    let namePool = ["Apple", "Ball", "Cat", "Dog", "Elephant"]
    let classPool = ["1", "2", "3", "4", "5"]
    
    init(type: Way) {
        self.type = type
    }
}

extension UndoRedoViewModel {
    func addNewEntry() {
        let entry = Student(id: UUID().uuidString, name: namePool.randomElement()!, studyInClass: classPool.randomElement()!)
        
        addNewStudentEntry(student: entry)
        switch type {
        case .appleWay:
            undoRegister(student: entry)
        case .customWay:
            customUndoManager.addEntry(entry)
        }
        undoRedoButtonState()
    }
    
    func redoEntry() {
        switch type {
        case .appleWay:
            defaultUndoManager.redo()
        case .customWay:
            if let redoEntry = customUndoManager.redo() {
                addNewStudentEntry(student: redoEntry)
            }
        }
        undoRedoButtonState()
    }
    
    func undoEntry() {
        switch type {
        case .appleWay:
            defaultUndoManager.undo()
        case .customWay:
            if let undoEntry = customUndoManager.undo() {
                removeStudentEntry(student: undoEntry)
            }
        }
        undoRedoButtonState()
    }
    
    private func undoRedoButtonState() {
        switch type {
        case .appleWay:
            enableUndo = defaultUndoManager.canUndo
            enableRedo = defaultUndoManager.canRedo
        case .customWay:
            enableUndo = customUndoManager.canUndo
            enableRedo = customUndoManager.canRedo
        }
    }
}

//Common
extension UndoRedoViewModel {
    private func addNewStudentEntry(student: Student) {
        datasource.append(student)
    }
    
    private func removeStudentEntry(student: Student) {
        guard let removeIndex = datasource.firstIndex(of: student) else { return }
        datasource.remove(at: removeIndex)
    }
}

//Apple way
extension UndoRedoViewModel {

    private func undoRegister(student: Student) {
        self.defaultUndoManager.registerUndo(withTarget: self, handler: { selfTarget in
            selfTarget.removeStudentEntry(student: student)
            selfTarget.redoRegister(student: student)
        })
    }
    
    private func redoRegister(student: Student) {
        self.defaultUndoManager.registerUndo(withTarget: self, handler: { selfTarget in
            selfTarget.addNewStudentEntry(student: student)
            selfTarget.undoRegister(student: student)
        })
    }
}
