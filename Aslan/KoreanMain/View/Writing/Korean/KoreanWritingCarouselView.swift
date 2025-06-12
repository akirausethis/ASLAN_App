// ASLAN_App/AslanApp/View/Writing/Korean/KoreanWritingCarouselView.swift
import SwiftUI

struct KoreanWritingCarouselView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var progressViewModel: ProgressViewModel

    let course: KoreanCourse

    @State private var charactersToPractice: [any KoreanCharacterCard] = []
    @State private var currentIndex: Int = 0 {
        didSet {
            clearDrawing()
            isShowingCompletionNotification = false
            completionNotificationMessage = ""
            completionNotificationIsSuccess = false
        }
    }
    @State private var currentDrawing: [CGPoint] = []
    @State private var drawings: [[CGPoint]] = []
    @State private var isShowingCompletionNotification: Bool = false
    @State private var completionNotificationMessage: String = ""
    @State private var completionNotificationIsSuccess: Bool = false

    private let minPointsForCompletion: Int = 50

    private var isDrawingSufficient: Bool {
        let totalPointsInDrawings = drawings.reduce(0) { $0 + $1.count }
        return totalPointsInDrawings >= minPointsForCompletion
    }

    var body: some View {
        GeometryReader { geometry in
            // ZStack adalah kunci untuk menempatkan notifikasi di atas konten lain
            ZStack(alignment: .top) {
                // Konten utama didalam ScrollView
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        // ... Konten lainnya (Canvas, Tombol, etc.) ...
                        // (Tidak ada perubahan di sini)
                        VStack(alignment: .center) {
                            Text("Please follow the stroke!")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal)
                        .padding(.top, 20)

                        if !charactersToPractice.isEmpty {
                            KoreanDrawingCanvasView(
                                character: charactersToPractice[currentIndex].character,
                                romaji: charactersToPractice[currentIndex].romaji,
                                currentDrawing: $currentDrawing,
                                drawings: $drawings
                            )
                            .id(charactersToPractice[currentIndex].id)
                        } else {
                            Text("No characters to practice!")
                                .font(.title2)
                                .foregroundColor(.gray)
                                .frame(maxWidth: .infinity, maxHeight: 500)
                                .padding(.horizontal)
                        }

                        HStack {
                            Button("Previous") { goToPreviousCharacter() }
                                .font(.headline).padding().frame(maxWidth: .infinity)
                                .background(Color.gray.opacity(0.3)).foregroundColor(.black)
                                .cornerRadius(10).disabled(currentIndex == 0)

                            Button("Next") { handleNextButton() }
                                .font(.headline).padding().frame(maxWidth: .infinity)
                                .background(Color.blue).foregroundColor(.white)
                                .cornerRadius(10).disabled(charactersToPractice.isEmpty)
                        }
                        .padding(.horizontal).padding(.top, 10)

                        Button("Clear Drawing") { clearDrawing(); isShowingCompletionNotification = false }
                            .font(.headline).padding().frame(maxWidth: .infinity)
                            .background(Color.red.opacity(0.8)).foregroundColor(.white)
                            .cornerRadius(10).padding(.horizontal)
                    }
                    .padding(.vertical)
                    .padding(.bottom, geometry.safeAreaInsets.bottom + 90)
                }
                .navigationTitle(course.title)
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarBackButtonHidden(true)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: { presentationMode.wrappedValue.dismiss() }) {
                            Image(systemName: "chevron.left")
                            Text("Back")
                        }
                    }
                }
                .onAppear {
                    charactersToPractice = KoreanCharacterData.getFlashcardsForCourse(course.title)
                    if !charactersToPractice.isEmpty { currentIndex = 0 }
                }

                // --- Tampilan Notifikasi ---
                // Ditempatkan di dalam ZStack dan akan muncul di atas ScrollView
                if isShowingCompletionNotification {
                    VStack {
                        NotificationView(
                            message: completionNotificationMessage,
                            isSuccess: completionNotificationIsSuccess,
                            isShowing: $isShowingCompletionNotification
                        )
                        .padding(.top, geometry.safeAreaInsets.top > 0 ? geometry.safeAreaInsets.top : 10)
                        Spacer()
                    }
                    .transition(.move(edge: .top).combined(with: .opacity))
                    .zIndex(1) // Memastikan notifikasi selalu di lapisan paling atas
                }
            }
            .background(Color(UIColor.systemGroupedBackground).ignoresSafeArea())
        }
    }

    // Fungsi handleNextButton, clearDrawing, dll. tetap sama
    private func handleNextButton() {
        if !isDrawingSufficient {
            completionNotificationMessage = "You haven't finished the stroke!"
            completionNotificationIsSuccess = false
            isShowingCompletionNotification = true
            return
        }

        if currentIndex == charactersToPractice.count - 1 {
            completionNotificationMessage = "You've completed this course!"
            completionNotificationIsSuccess = true
            isShowingCompletionNotification = true

            progressViewModel.userCompletedCourse(
                courseTitle: course.id,
                topicTitle: "",
                category: course.category
            )

            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                presentationMode.wrappedValue.dismiss()
            }
        } else {
            goToNextCharacter()
            completionNotificationMessage = "Good Job!"
            completionNotificationIsSuccess = true
            isShowingCompletionNotification = true
        }
    }
    
    private func clearDrawing() { DispatchQueue.main.async { currentDrawing = []; drawings = [] } }
    private func goToNextCharacter() { if currentIndex < charactersToPractice.count - 1 { withAnimation(.easeInOut) { currentIndex += 1 } } }
    private func goToPreviousCharacter() { if currentIndex > 0 { withAnimation(.easeInOut) { currentIndex -= 1 } } }
}
