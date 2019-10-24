//
// This file is part of Canvas.
// Copyright (C) 2018-present  Instructure, Inc.
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

import UIKit
import Core

class AssignmentListViewController: UIViewController {

    var presenter: AssignmentListPresenter?
    var color: UIColor?
    var titleSubtitleView: TitleSubtitleView = TitleSubtitleView.create()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!

    static func create(env: AppEnvironment = .shared, courseID: String, sort: GetAssignments.Sort = .position) -> AssignmentListViewController {
        let vc = loadFromStoryboard()
        vc.presenter = AssignmentListPresenter(view: vc, courseID: courseID, sort: sort)
        return vc
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTitleViewInNavbar(title: NSLocalizedString("Assignments", comment: ""))
        tableView.registerCell(ListCell.self)
        tableView.registerHeaderFooterView(SectionHeaderView.self)
        presenter?.viewIsReady()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.useContextColor(color)
    }
}

extension AssignmentListViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter?.assignments.numberOfSections ?? 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sectionInfo = presenter?.assignments.sectionInfo(inSection: section) else { return 0 }
        return sectionInfo.numberOfObjects
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ListCell = tableView.dequeue(for: indexPath)
        cell.textLabel?.text = presenter?.assignments[indexPath]?.name
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode = .byWordWrapping
        cell.detailTextLabel?.text = presenter?.assignments[indexPath]?.formattedDueDate()
        cell.imageView?.image = presenter?.assignments[indexPath]?.icon
        cell.imageView?.tintColor = color
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let assignment = presenter?.assignments[indexPath.row] else { return }
        presenter?.select(assignment, from: self)
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueHeaderFooter(SectionHeaderView.self)
        view.titleLabel?.text = presenter?.assignmentGroups?[section]?.name
        return view
    }

    class ListCell: UITableViewCell {
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
            textLabel?.font = UIFont.scaledNamedFont(.semibold16)
            detailTextLabel?.font = UIFont.scaledNamedFont(.medium14)
            detailTextLabel?.textColor = UIColor.named(.textDark)
            accessoryType = .disclosureIndicator
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
}

extension AssignmentListViewController: AssignmentListViewProtocol {
    func update(loading: Bool) {
        tableView.isHidden = loading
        spinner.isHidden = !loading
        if !loading {
            tableView.reloadData()
        }
        view.layoutIfNeeded()
    }
}
