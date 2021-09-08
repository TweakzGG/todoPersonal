//
//  TodoNoteManager.swift
//  Todo
//
//  Created by Jackson Barnes on 9/8/21.
//

import Foundation

class TodoNoteManager{
    var todoNotes: [TodoNote] = []

    var fileURL: URL {
          var url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
          url.appendPathComponent("notes")
          url.appendPathExtension("json")
          return url
      }

        
    init() {
        loadNotes()
    }
    //create a new note
    func createTodo(title: String, subtitle: String){
    let note = TodoNote(title: title, subtitle: subtitle)
        
        //add it to array
        
        todoNotes.append(note)
        
        //save the array
        
        
    }
    func deleteTodo (note: TodoNote){
        //get the index
        guard let index = todoNotes.firstIndex(of: note) else { return }
        
        //remove note from array
        todoNotes.remove(at: index)
        
        //save the array
        saveNotes()
        
    }
    
    func saveNotes(){
        let url = fileURL
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(todoNotes)
            try data.write(to: url)
        } catch {
            print(error)
        }
        
    }
    func loadNotes(){
        do {
            let decoder = JSONDecoder()
            let data = try Data(contentsOf: fileURL)
            let todoNotes = try decoder.decode([TodoNote].self, from: data)
            self.todoNotes = todoNotes
        } catch {
            print(error)
            
        }
    }
}
