//Copyright © 2022 and Confidential to ___ORGANIZATIONNAME___ All rights reserved.
   

import Foundation

struct Student: Hashable {
    var id: String
    var name: String
    var studyInClass: String
  
  static let allStudents : [Student] = [
    Student(id: "1", name: "Ram", studyInClass: "1"),
    Student(id: "2", name: "Shyam", studyInClass: "2")
  ]
}
