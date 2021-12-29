//
//  MainScreenController.swift
//  ForceQuit
//
//  Created by mac on 9.12.21.
//

import Cocoa

final class MainScreenController: NSViewController {
    private enum Constants {
        static let rowHeight: CGFloat = 50
        static let tableCellId = "AppViewCell"
    }

    @IBOutlet weak var searchField: NSTextField!
    @IBOutlet weak var selectAllButton: GradientButton!
    @IBOutlet weak var terminateButton: BorderedRoundedButton!
    @IBOutlet weak var tableVeiw: NSTableView!

    private var presenter: MainScreenPresenterProtocol?

    init(presenter: MainScreenPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableVeiw.delegate = self
        self.tableVeiw.dataSource = self
        self.searchField.appearance = NSAppearance(named: .aqua)
        self.searchField.delegate = self
        self.presenter?.delegate = self
        self.updateValues()
    }

    private func updateValues() {
        Timer.scheduledTimer(withTimeInterval: 2.5, repeats: true) { _ in
            DispatchQueue.main.async { [weak self] in
                self?.presenter?.setUpAppsData()
            }
        }
    }

    @IBAction func selectAllTapped(_ sender: Any) {
        guard let presenter = self.presenter else { return }
        presenter.selectAllApps()
        self.terminateButton.isColored = presenter.filteredApps.contains { $0.isSelected }
    }

    @IBAction func terminateTapped(_ sender: Any) {
        guard let presenter = self.presenter else { return }
        presenter.forceQuitApp()
    }
}

extension MainScreenController: NSTableViewDataSource, NSTableViewDelegate {
    func numberOfRows(in tableView: NSTableView) -> Int { self.presenter?.filteredApps.count ?? 0 }
    func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any? { self.presenter?.filteredApps[row] }
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat { Constants.rowHeight }

    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        guard var presenter = self.presenter else { return NSView() }
        let cellId = NSUserInterfaceItemIdentifier(Constants.tableCellId)
        if let cellView = tableView.makeView(withIdentifier: cellId, owner: self) as? AppViewCell {
            cellView.configure(with: presenter.filteredApps[row]) { [weak self] in
                presenter.filteredApps[row].toggleSelection()
                self?.terminateButton.isColored = presenter.filteredApps.contains { $0.isSelected } 
                guard let indexInUnfilteredApps = presenter.apps.firstIndex(where: { $0.app == presenter.filteredApps[row].app }) else { return }
                presenter.apps[indexInUnfilteredApps].toggleSelection()
            }
            return cellView
        } else {
            return NSView()
        }
    }
}

extension MainScreenController: NSSearchFieldDelegate {
    func controlTextDidChange(_ obj: Notification) {
        guard
            let object = obj.object as? NSTextField,
            let presenter = self.presenter
        else { return }
        presenter.filterApps(text: object.stringValue.trimmingCharacters(in: .whitespaces).lowercased())
    }
}

extension MainScreenController: MainScreenViewProtocol {
    func updateTableView() {
        self.tableVeiw.reloadData()
    }
}
