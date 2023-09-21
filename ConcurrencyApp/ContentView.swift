//
//  ContentView.swift
//  ConcurrencyApp
//
//  Created by Atikur Rahman on 9/22/23.
//

import SwiftUI

struct ContentView: View {
    @State private var sourceCode = ""
    
    var body: some View {
        ScrollView {
            Text(sourceCode)
        }
        .task {
            await fetchSource()
        }
    }
    
    func fetchSource() async {
        do {
            let url = URL(string: "https://apple.com")!
            let (data, _) = try await URLSession.shared.data(from: url)
            sourceCode = String(decoding: data, as: UTF8.self).trimmingCharacters(in: .whitespacesAndNewlines)
        } catch {
            sourceCode = "Failed to fetch apple.com"
        }
    }
}

#Preview {
    ContentView()
}
