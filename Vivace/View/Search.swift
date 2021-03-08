//
//  Search.swift
//  Vivace
//
//  Created by Devin Rogers on 2/11/21.
//

import SwiftUI

struct Search: View {
    @State private var searchResults = [Song]()
    @State var search = ""
    var columns = Array(repeating: GridItem(.flexible(), spacing:20), count: 2)
    
    var body: some View {
        ScrollView {
            VStack(spacing: 18) {
                HStack() {
                    Text("Search")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .foregroundColor(.primary)
                    Spacer(minLength: 0)
                    
                }
                HStack(spacing: 15) {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.primary)
                    TextField("Search", text:$search)
                }
                .padding(.vertical, 10)
                .padding(.horizontal)
                .background(Color.primary.opacity(0.06))
                .cornerRadius(15)
                
                LazyVGrid(columns: columns, spacing:20) {
                    ForEach(1...10, id: \.self) {index in
                        Image("p\(index)")
                            .resizable()
                            .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                            .frame(width: (UIScreen.main.bounds.width - 50) / 2,
                                   height: 180,
                                   alignment: .center)
                            .cornerRadius(15)
                            
                            
                     
                    }
                }
                .padding(.top, 10)
            }
            .padding()
            .padding(.bottom, 80)
        }
        
    }
}

struct Search_Previews: PreviewProvider {
    static var previews: some View {
        Search()
    }
}
