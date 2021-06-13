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

    // MARK: - Cell Initialization
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

        repoNameLabel = Utilities.sharedInstance.createLabel(text: "", txtAlignment: .left, font: .systemFont(ofSize: 14, weight: .bold), textColor: .black, backgroundColor: .clear)

        contentView.addSubview(repoNameLabel)
    }

    private func setupConstraints() {
        repoNameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
        }
    }

    func setupCell(with repository: Repository) {
        repoNameLabel.text = repository.description ?? repository.full_name ?? ""
    }
}
