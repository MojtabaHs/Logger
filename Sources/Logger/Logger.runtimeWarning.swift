import os

public extension Logger {
    private static let rw = (
        dso: { () -> UnsafeMutableRawPointer in
            #if DEBUG
            let count = _dyld_image_count()
            for i in 0..<count {
                if let name = _dyld_get_image_name(i) {
                    let swiftString = String(cString: name)
                    if swiftString.hasSuffix("/SwiftUI") {
                        if let header = _dyld_get_image_header(i) {
                            return UnsafeMutableRawPointer(mutating: UnsafeRawPointer(header))
                        }
                    }
                }
            }
            #endif
            return UnsafeMutableRawPointer(mutating: #dsohandle)
        }(),
        log: OSLog(subsystem: "com.apple.runtime-issues", category: "RunTimeIssue")
    )
    
    @inline(__always)
    static func runtimeWarning(
        _ message: StaticString,
        _ args: @autoclosure () -> [CVarArg] = []
    ) {
        #if DEBUG
        unsafeBitCast(
            os_log as (OSLogType, UnsafeRawPointer, OSLog, StaticString, CVarArg...) -> Void,
            to: ((OSLogType, UnsafeRawPointer, OSLog, StaticString, [CVarArg]) -> Void).self
        )(.fault, rw.dso, rw.log, message, args())
        #endif
    }
    
    static func runtimeWarning(title: String = "[Logger Runtime Issue]", _ error: Error) {
        runtimeWarning("%@\n%@", [title, String(describing: error)])
    }
}
