//
//  RepositoryTableViewCell.swift
//  GitHubRepoSearch
//
//  Created by Ненад Љубиќ on 13.6.21.
//

import UIKit

final class RepositoryTableViewCell: UITableViewCell {

    // Properties
    private var repoNameLabel: UILabel!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setting Up Views And Constraints
    private func setupViews() {
        selectionStyle = .none
    }

    private func setupConstraints() {

    }

}
