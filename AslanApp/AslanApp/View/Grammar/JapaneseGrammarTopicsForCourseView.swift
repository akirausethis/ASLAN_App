// AslanApp/View/Grammar/GrammarTopicsForCourseView.swift
import SwiftUI

struct GrammarTopicsForCourseView: View {
    @EnvironmentObject var progressViewModel: ProgressViewModel // 1. Akses ProgressViewModel
    let course: JapaneseCourse //
    
    // 2. State untuk menyimpan courseID yang sesuai untuk progres
    @State private var courseIDForProgress: String? = nil

    // State untuk mengontrol visibilitas tombol Complete Course
    @State private var showCompleteCourseButton: Bool = false // TAMBAHKAN INI

    // State untuk notifikasi penyelesaian
    @State private var showingCompletionNotification: Bool = false
    @State private var completionNotificationMessage: String = ""
    @State private var isButtonPressing: Bool = false // Untuk efek hover

    private var materialsForCourse: [GrammarMaterial] { //
        GrammarContentData.materials(forCourseTitle: course.title) //
    }

    var body: some View {
        GeometryReader { geometry in // Tambahkan GeometryReader
            ZStack { // ZStack untuk notifikasi overlay
                ScrollView {
                    VStack(alignment: .center, spacing: 20) {
                        Text(course.title)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.blue)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 20)
                            .padding(.top, geometry.safeAreaInsets.top + 20) // Sesuaikan padding top
                            .padding(.bottom, 10)

                        if materialsForCourse.isEmpty {
                            Text("No specific topics found for \(course.title) yet.")
                                .foregroundColor(.gray)
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .center)
                        } else {
                            VStack(spacing: 18) {
                                ForEach(materialsForCourse) { material_topic in
                                    NavigationLink(destination: JapaneseGrammarDetailView(material: material_topic)) { //
                                        HStack(spacing: 15) {
                                            Image(systemName: "text.book.closed.fill")
                                                .font(.title)
                                                .foregroundColor(.blue)
                                                .frame(width: 40, alignment: .center)

                                            VStack(alignment: .leading, spacing: 4) {
                                                Text(material_topic.topicTitle)
                                                    .font(.headline)
                                                    .fontWeight(.bold)
                                                    .foregroundColor(Color.primary)
                                                Text(material_topic.explanation.prefix(80) + (material_topic.explanation.count > 80 ? "..." : ""))
                                                    .font(.subheadline)
                                                    .foregroundColor(Color.secondary)
                                                    .lineLimit(2)
                                            }
                                            Spacer()
                                            Image(systemName: "chevron.right")
                                                .foregroundColor(.gray.opacity(0.7))
                                        }
                                        .padding(.vertical, 15)
                                        .padding(.horizontal, 20)
                                        .background(Color(UIColor.systemBackground))
                                        .cornerRadius(12)
                                        .shadow(color: Color.black.opacity(0.08), radius: 5, x: 0, y: 2)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }
                            }
                            .padding(.horizontal, 20)

                            // Tombol "Complete Course" - DIPINDAHKAN KE TENGAH
                            if showCompleteCourseButton {
                                Button(action: {
                                    markCourseAsCompleted()
                                    completionNotificationMessage = "You've completed the Grammar course!"
                                    showingCompletionNotification = true
                                }) {
                                    Text("Complete Course")
                                        .fontWeight(.semibold)
                                        .frame(maxWidth: .infinity)
                                        .padding()
                                        .background(Color.green) // Warna hijau untuk complete
                                        .foregroundColor(.white)
                                        .cornerRadius(10)
                                }
                                .scaleEffect(isButtonPressing ? 0.95 : 1.0) // Efek hover
                                .opacity(isButtonPressing ? 0.8 : 1.0)
                                .onLongPressGesture(minimumDuration: 0, pressing: { isPressing in
                                    self.isButtonPressing = isPressing
                                }, perform: {})
                                .padding(.horizontal, 20)
                                .padding(.top, 30)
                                .padding(.bottom, geometry.safeAreaInsets.bottom + 10) // Sesuaikan padding bawah
                            }
                        }
                    }
                    .padding(.bottom, showCompleteCourseButton ? 0 : geometry.safeAreaInsets.bottom + 10) // Jika tombol complete muncul, padding sudah di tombol
                }
                .background(Color(UIColor.systemGroupedBackground).ignoresSafeArea())
                .navigationTitle("") // Judul sudah ditampilkan di dalam VStack
                .navigationBarTitleDisplayMode(.inline)
                .onAppear {
                    // 3. Dapatkan courseID saat view muncul
                    if let appCourse = CourseDataProvider.shared.allAppCourses.first(where: { $0.title == self.course.title }) { //
                        self.courseIDForProgress = appCourse.id
                    } else {
                        print("Error: Tidak dapat menemukan AppCourse ID untuk Grammar course: \(self.course.title)")
                    }
                    // Tampilkan tombol complete jika ada materi
                    if !materialsForCourse.isEmpty {
                        showCompleteCourseButton = true
                    }
                }
                .animation(.easeInOut, value: showCompleteCourseButton) // Animasi untuk tombol

                // Notifikasi overlay
                if showingCompletionNotification {
                    NotificationView(message: completionNotificationMessage, isSuccess: true, isShowing: $showingCompletionNotification)
                        .padding(.top, geometry.safeAreaInsets.top) // Gunakan safeAreaInsets.top
                        .transition(.move(edge: .top).combined(with: .opacity))
                        .zIndex(1) // Pastikan notifikasi di atas konten lain
                }
            }
        }
    }

    // 4. Fungsi untuk menandai kursus selesai
    private func markCourseAsCompleted() {
        if let courseID = courseIDForProgress {
            progressViewModel.userCompletedCourse(courseID: courseID, userID: "dummyUser") // Ganti "dummyUser" nanti
            print("Grammar course '\(course.title)' (ID: \(courseID)) marked as completed.")
        } else {
            print("Tidak dapat menandai Grammar course '\(course.title)' selesai karena ID tidak ditemukan.")
        }
    }
}

#Preview {
    NavigationView {
        let sampleCourse = JapaneseGrammarListView().beginnerGrammarCourses.first ?? JapaneseCourse(title: "Sample Particles", subtitle: "Learn basic particles", iconName: "puzzlepiece.extension.fill") //
        GrammarTopicsForCourseView(course: sampleCourse)
    }
    .environmentObject(ProgressViewModel()) //
}
