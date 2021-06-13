//
//  ViewController.swift
//  GitHubRepoSearch
//
//  Created by Ненад Љубиќ on 13.6.21.
//

import UIKit
import SnapKit

final class ViewController: UIViewController {

    // Properties
    private var tableView: UITableView!
    private var searchTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupConstraints()
    }

    // MARK: - Setting Up Views And Constraints
    private func setupViews() {
        searchTextField = UITextField()
        searchTextField.placeholder = "Search"
        searchTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: searchTextField.frame.size.height))
        searchTextField.leftViewMode = .always
        searchTextField.backgroundColor = .systemGroupedBackground
        searchTextField.layer.cornerRadius = 8
        searchTextField.delegate = self

        tableView = UITableView()
        tableView.rowHeight = 55
        tableView.register(RepositoryTableViewCell.self, forCellReuseIdentifier: "repoCell")
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self

        view.addSubview(searchTextField)
        view.addSubview(tableView)
    }

    private func setupConstraints() {
        searchTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.height.equalTo(40)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }

        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchTextField.snp.bottom).offset(10)
            make.left.right.bottom.equalToSuperview()
        }
    }

}

// MARK: - UITextField Delegate Methods
extension ViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

// MARK: - UITableView Delegate And DataSource Methods
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "repoCell", for: indexPath) as! RepositoryTableViewCell

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}

