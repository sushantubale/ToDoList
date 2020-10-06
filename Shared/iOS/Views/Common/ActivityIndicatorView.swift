//
//  ActivityIndicatorView.swift
//  ToDoList
//
//  Created by Sushant-Old on 8/16/20.
//

import SwiftUI


struct ActivityIndicatorView: View {

  @State private var isAnimating: Bool = false
    var text = "Loading..."
     init(text:String ) {
         self.text = text
     }
    var body: some View {
        VStack {
            ProgressView(self.text)
        }
        
    }

}

struct ActivityIndicatorView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityIndicatorView(text: "Loading")
    }
}
