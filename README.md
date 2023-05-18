# MiniSteamingApp
extension View {
    func halfModal<ModalContent: View>(isShown: Binding<Bool>, modalContent: @escaping () -> ModalContent) -> some View {
        self.modifier(HalfModalViewModifier(isShown: isShown, modalContent: modalContent()))
    }
}
