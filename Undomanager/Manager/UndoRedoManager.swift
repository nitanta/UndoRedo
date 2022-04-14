//Copyright © 2022 and Confidential to ___ORGANIZATIONNAME___ All rights reserved.
   

import Foundation

final class UndoRedoManager<T> {
    
    fileprivate var undoStack = Stack<T>()
    fileprivate var redoStack = Stack<T>()
    
    init() {}
    
    var canUndo: Bool {
        return !undoStack.isEmpty
    }
    
    var canRedo: Bool {
        return !redoStack.isEmpty
    }
    
    func addEntry(_ entry: T) {
        undoStack.push(entry)
    }
    
    func removeEnty(_ entry: T) {
        redoStack.push(entry)
    }
    
    func undo() -> T? {
        let data = undoStack.pop()
        if let data = data {
            redoStack.push(data)
        }
        return data
    }
    
    func redo() -> T? {
        let data = redoStack.pop()
        if let data = data {
            undoStack.push(data)
        }
        return data
    }
    
}
