//
// Copyright (C) 2017-present Instructure, Inc.
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, version 3 of the License.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.
//

// @flow

export type AccountNotificationIcon = 'information' | 'error' | 'warning' | 'question' | 'calendar'

export type AccountNotification = {
  id: string,
  subject: string,
  message: string,
  start_at: string,
  end_at: string,
  icon: AccountNotificationIcon,
  role_ids: string[],
}

export type Account = {
  id: string,
  name: string,
  uuid: string,
  parent_account_id: string,
  root_account_id: string,
}
