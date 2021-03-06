//
// This file is part of Canvas.
// Copyright (C) 2019-present  Instructure, Inc.
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Affero General Public License as
// published by the Free Software Foundation, either version 3 of the
// License, or (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Affero General Public License for more details.
//
// You should have received a copy of the GNU Affero General Public License
// along with this program.  If not, see <https://www.gnu.org/licenses/>.
//

import XCTest
@testable import Core

class APIPostPolicyInfoTests: XCTestCase {
    func testSubmissionNodeIsPosted() {
        let node = APIPostPolicyInfo.SubmissionNode(score: 0.5, excused: false, state: "graded", postedAt: Date())
        XCTAssertTrue(node.isPosted)
    }

    func testSubmissionNodeIsNotPosted() {
        let node = APIPostPolicyInfo.SubmissionNode(score: 0.5, excused: false, state: "graded", postedAt: nil)
        XCTAssertFalse(node.isPosted)
    }

    func testSubmissionNodeIsHidden() {
        let node = APIPostPolicyInfo.SubmissionNode(score: 0.5, excused: false, state: "graded", postedAt: nil)
        XCTAssertTrue(node.isHidden)
    }

    func testSubmissionNodeIsHiddenWhenExcused() {
        let node = APIPostPolicyInfo.SubmissionNode(score: nil, excused: true, state: "not graded", postedAt: nil)
        XCTAssertTrue(node.isHidden)
    }

    func testSubmissionNodeIsNotHidden() {
        let node = APIPostPolicyInfo.SubmissionNode(score: 0.5, excused: false, state: "graded", postedAt: Date())
        XCTAssertFalse(node.isHidden)
    }

    func testDecode() {
        let str = """
        {
            "data": {
                "course": {
                    "sections": {
                        "nodes": [{
                            "id": "1",
                            "name": "Quiz Questions"
                        }]
                    }
                },
                "assignment": {
                    "submissions": {
                        "nodes": [{
                            "score": 0.5,
                            "excused": false,
                            "state": "graded",
                            "postedAt": "2019-08-22T07:28:44-06:00"
                        }]
                    }
                }
            }
        }
        """
        let data = str.data(using: .utf8)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let model = try? decoder.decode(APIPostPolicyInfo.self, from: data!)

        XCTAssertNotNil(model)
        XCTAssertEqual(model?.sections.count, 1)
        XCTAssertEqual(model?.submissions.count, 1)

        let section = model?.sections.first
        XCTAssertEqual(section?.name, "Quiz Questions")
        XCTAssertEqual(section?.id, "1")

        let submission = model?.submissions.first
        XCTAssertEqual(submission?.score, 0.5)
        XCTAssertEqual(submission?.state, "graded")
        XCTAssertEqual(submission?.excused, false)
        XCTAssertEqual(submission?.postedAt, Date(fromISOString: "2019-08-22T07:28:44-06:00"))
    }
}
