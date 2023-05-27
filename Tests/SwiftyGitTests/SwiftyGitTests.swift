import XCTest
@testable import SwiftyGit

final class SwiftyGitTests: XCTestCase {

    func testReadBlob() throws {
        let fileUrl = URL(fileURLWithPath: #file)
        let repoUrl = fileUrl
            .deletingLastPathComponent()
            .deletingLastPathComponent()
            .deletingLastPathComponent()
            .appendingPathComponent("Repositories/sample-repo")
        let repo = Repository(repoUrl)
        let obj = try repo.readObject("6cead22c1ad3698421d1e04941fe31433912e41e")

        let expected = Object.blob("Hello, world! From Luke.\n".data(using: .utf8)!)
        XCTAssertEqual(obj, expected)
    }

}
