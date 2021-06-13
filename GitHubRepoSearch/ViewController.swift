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
    private var repositories = [Repository]()
    private var tapGesture: UITapGestureRecognizer!
    private var activityIndicator : UIActivityIndicatorView!

    private let jsonDecoder = JSONDecoder()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupConstraints()
    }

    // MARK: - Setting Up Views And Constraints
    private func setupViews() {
        searchTextField = Utilities.sharedInstance.createTextField(placeHolder: "Search", txtAlignment: .left, font: .systemFont(ofSize: 14, weight: .regular), textColor: .black, backgroundColor: .systemGroupedBackground, corner: 8, returnKeyType: .search)
        searchTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: searchTextField.frame.size.height))
        searchTextField.leftViewMode = .always
        searchTextField.clearButtonMode = .whileEditing
        searchTextField.delegate = self

        tableView = UITableView()
        tableView.rowHeight = 55
        tableView.register(RepositoryTableViewCell.self, forCellReuseIdentifier: "repoCell")
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self

        tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureAction))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)

        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .lightGray

        view.addSubview(searchTextField)
        view.addSubview(tableView)
        view.addSubview(activityIndicator)
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

        activityIndicator.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.height.equalTo(30)
        }
    }

    private func parseReposResponse(repos: [[String:Any]]) {
        guard let json = Utilities.sharedInstance.jsonToData(json: repos) else { return }
        do {
            let reposArray = try jsonDecoder.decode([Repository].self, from: json)
            repositories = reposArray
            tableView.reloadData()
        } catch {
            print (error.localizedDescription)
        }
    }

    @objc private func tapGestureAction() {
        view.endEditing(true)
    }

    private func handleTextToBeSearched(text: String?) {
        guard let queryText = text else { return }

        // If the query text is not an empty string then we are executing the request
        if queryText.trimmingCharacters(in: .whitespaces) != "" {
            getRepos(with: queryText)
        }
    }
}

// MARK: - UITextField Delegate Methods
extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        handleTextToBeSearched(text: textField.text)
        return true
    }

    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        repositories.removeAll()
        tableView.reloadData()
        return true
    }
}

// MARK: - UITableView Delegate And DataSource Methods
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "repoCell", for: indexPath) as! RepositoryTableViewCell
        cell.setupCell(with: repositories[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let htmlRepoString = repositories[indexPath.row].html_url, let url = URL(string: htmlRepoString) else { return }
        UIApplication.shared.open(url)
    }
}

// MARK: - API Communication
extension ViewController {

    // Getting Repos With Specific Query
    func getRepos(with query: String) {
        activityIndicator.startAnimating()
        ApiManager.sharedInstance.getRepos(with: query) { [weak self] success, responseData, statusCode in
            if success {
                guard let repos = responseData?["items"] as? [[String:Any]] else {
                    return
                }
                self?.parseReposResponse(repos: repos)
            } else {

            }
            self?.activityIndicator.stopAnimating()
        }
    }
}
