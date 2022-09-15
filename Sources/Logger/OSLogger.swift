import OSLog

@available(iOS 14.0, *)
@available(macOS 11.0, *)
public extension Logger {
    static let print = os.Logger(subsystem: .main, category: .print)
}

/// - Note: These  are **NOT** related to the `String`, but we put theme  here for the ease of use and more readability of the main code.
///         Do **NOT** change the access level!
private extension String {
    // MARK: - Subsystems

    /// - Note: Main bundle **MUST** have an `bundleIdentifier`.
    static let main: String! = Bundle.main.bundleIdentifier // swiftlint:disable:this implicitly_unwrapped_optional

    // MARK: - Categories

    static let print = "PRINT"
}
