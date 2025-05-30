// AslanApp/ContentView.swift
import SwiftUI

struct ContentView: View {
    var body: some View {
        AnimatedNavbar() //
    }
}

#Preview {
    ContentView()
        .environmentObject(ProgressViewModel()) // Tambahkan ini
}
