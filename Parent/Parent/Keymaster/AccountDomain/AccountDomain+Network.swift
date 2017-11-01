//
// Copyright (C) 2016-present Instructure, Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
    
    

import ReactiveSwift

import Marshal
import CanvasCore

extension AccountDomain {
    static func getAccountDomains() throws -> SignalProducer<[JSONObject], NSError> {
        guard let url = URL(string: "https://canvas.instructure.com/api/v1/accounts/search?per_page=50") else {
            ❨╯°□°❩╯⌢"URL parsing from normal url string didn't work"
        }
        let request = URLRequest(url: url)
        return Session.unauthenticated.paginatedJSONSignalProducer(request)
    }
}