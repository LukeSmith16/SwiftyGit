import XCTest
@testable import SwiftyGit

let fileUrl = URL(fileURLWithPath: #file)
let repoUrl = fileUrl
    .deletingLastPathComponent()
    .deletingLastPathComponent()
    .deletingLastPathComponent()
    .appendingPathComponent("Repositories/sample-repo")
let repo = Repository(repoUrl)

final class SwiftyGitTests: XCTestCase {

    func testReadBlob() throws {
        let obj = try repo.readObject("802992c4220de19a90767f3000a79a31b98d0df7")
        let expected = Object.blob("Hello world\n".data(using: .utf8)!)
        XCTAssertEqual(obj, expected)
    }

    func testReadTree() throws {
        let obj = try repo.readObject("89f378ddad087fee151df26ea596397785d6adeb")
        let expected = Object.tree([
            TreeItem(mode: "100644", name: ".DS_Store", hash: "ae085537f91ec91fb6cb6ef67315761fe9870ae8"),
            TreeItem(mode: "100644", name: "another-file.txt", hash: "802992c4220de19a90767f3000a79a31b98d0df7"),
            TreeItem(mode: "40000", name: "nested", hash: "ecbead9e7d627320cc09a8ad4d7408a0d900c5c1")
        ])

        XCTAssertEqual(obj, expected)
    }

}
