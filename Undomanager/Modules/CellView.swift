//Copyright © 2022 and Confidential to ___ORGANIZATIONNAME___ All rights reserved.
   
import SwiftUI

struct CellView: View {
    var student: Student
    var body: some View {
        VStack {
            HStack {
                Text(student.name)
                Spacer()
                Text(student.studyInClass)
            }
            .padding(20)
            
            Rectangle()
                .frame(height: 0.5)
        }
    }
}

struct CellView_Previews: PreviewProvider {
    static var previews: some View {
        CellView(student: Student.allStudents.first!)
    }
}
