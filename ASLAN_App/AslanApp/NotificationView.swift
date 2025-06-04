import SwiftUI

// MARK: - NotificationView (Meniru UI Card Anda)
struct NotificationView: View {
    let message: String
    let isSuccess: Bool
    @Binding var isShowing: Bool // Binding untuk mengontrol visibilitas dari parent

    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: isSuccess ? "checkmark.circle.fill" : "xmark.circle.fill")
                .font(.title2)
                .foregroundColor(.white)
                .frame(width: 40, height: 40)
                .background(isSuccess ? Color.green : Color.red) // Hijau untuk sukses, merah untuk error
                .clipShape(Circle()) // Icon background menjadi lingkaran

            VStack(alignment: .leading) {
                Text(message)
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
            }
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(isSuccess ? Color.green.opacity(0.8) : Color.red.opacity(0.8)) // Background card
        .cornerRadius(15) // Corner radius untuk card notifikasi
        .shadow(color: Color.black.opacity(0.15), radius: 5, x: 0, y: 5)
        .padding(.horizontal) // Padding dari pinggir layar
        // UBAH DI SINI: dari .bottom menjadi .top
        .transition(.move(edge: .top).combined(with: .opacity)) // Animasi slide in dari atas
        .animation(.easeOut(duration: 0.4), value: isShowing) // Animasi muncul/hilang
        .zIndex(100) // Pastikan notifikasi muncul di atas elemen lain
        .onAppear {
            // Sembunyikan notifikasi setelah beberapa detik (misal 2 detik)
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation {
                    isShowing = false
                }
            }
        }
    }
}

// MARK: - Preview untuk NotificationView
struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Spacer()
            NotificationView(message: "Good Job!", isSuccess: true, isShowing: .constant(true))
            NotificationView(message: "You haven't finished the stroke!", isSuccess: false, isShowing: .constant(true))
            Spacer()
        }
        .background(Color.gray.opacity(0.2)) // Hanya untuk latar belakang preview
    }
}
