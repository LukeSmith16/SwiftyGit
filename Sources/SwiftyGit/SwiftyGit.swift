import Foundation

enum Object: Hashable {
    case blob(Data)
    case commit
    case tree
}

struct Repository {
    let url: URL
    init(_ url: URL) {
        self.url = url
    }

    var gitURL: URL {
        url.appendingPathComponent(".git")
    }

    func readObject(_ hash: String) throws -> Object {
        // Verify is actual hash.

        // Because git takes first 2 values of hash and using '/' to separate them
        let objectPath = "\(hash.prefix(2))/\(hash.dropFirst(2))"
        let data = try Data(contentsOf: gitURL.appendingPathComponent("objects/\(objectPath)")).decompressed

        // blob 25\0Hello, world! From Luke.\n
        var stream = data

        // Type string is either 'blob', 'commit' or 'tree'
        let typeStr = String(decoding: stream.remove(upTo: 0x20), as: UTF8.self) // While data doesn't contain " "

        stream.remove(upTo: 0)

        switch typeStr {
        case "blob": return .blob(stream)
        default: fatalError()
        }

        fatalError()
    }
}

// MARK: - Extension: Data

extension Data {

    @discardableResult
    mutating func remove(upTo separator: Element) -> Data {
        let part = prefix(while: { $0 != separator })
        removeFirst(part.count)
        _ = popFirst()
        return part
    }

}
