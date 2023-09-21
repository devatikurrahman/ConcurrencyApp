//
//  ContentView.swift
//  ConcurrencyApp
//
//  Created by Atikur Rahman on 9/22/23.
//

import SwiftUI

struct ContentView: View {
    @State private var site = "https://"
    @State private var sourceCode = ""
    
    var body: some View {
        VStack {
            HStack {
                TextField("Website address", text: $site)
                    .textFieldStyle(.roundedBorder)
                Button("Go") {
                    print("Button clicked: Synchronous code start")
                    Task {
                        print("Tab button")
                        await fetchSource()
                        print("End data processing")
                    }
                    print("Button clicked: Synchronous code end")
                }
            }
            .padding()
        }
        ScrollView {
            Text(sourceCode)
        }
        .foregroundColor(.black)
        
    }
    
    func fetchSource() async {
        do {
            let url = URL(string: site)!
            let (data, _) = try await URLSession.shared.data(from: url)
            sourceCode = String(decoding: data, as: UTF8.self).trimmingCharacters(in: .whitespacesAndNewlines)
            print("sourceCode: \(sourceCode)")
        } catch {
            sourceCode = "Failed to fetch \(site)"
        }
    }
}

#Preview {
    ContentView()
}
