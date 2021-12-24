//
//  MainScreenController.swift
//  ForceQuit
//
//  Created by mac on 9.12.21.
//

import Cocoa

final class MainScreenController: NSViewController {
    enum Constants {
        static let rowHeight: CGFloat = 50
        static let tableCellId = "AppViewCell"
    }

    @IBOutlet weak var searchField: NSTextField!
    @IBOutlet weak var selectAllButton: GradientButton!
    @IBOutlet weak var terminateButton: BorderedRoundedButton!
    @IBOutlet weak var tableVeiw: NSTableView!

    private var apps: [AppsListItem] = []
    private var filteredApps: [AppsListItem] = []
    private var filter = "" {
        didSet {
            self.filteredApps = filter.isEmpty ? self.apps : self.apps.filter { $0.app.name.lowercased().contains(self.filter) }
            self.tableVeiw.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableVeiw.delegate = self
        self.tableVeiw.dataSource = self
        self.searchField.appearance = NSAppearance(named: .aqua)
        self.searchField.delegate = self

        DispatchQueue.main.async { [weak self] in
            let openApps = NSWorkspace.shared.runningApplications
            for app in openApps where app.activationPolicy == .regular {
                self?.apps.append(AppsListItem(app: App(name: app.localizedName ?? L10n.nameError.localize(),
                                                        icon: app.icon ?? NSImage(),
                                                        cpu: "0.3 % CPU")))
            }
            self?.filteredApps = self?.apps ?? []
            self?.tableVeiw.reloadData()
        }
    }

    // can get icons from NSRunningAplication, title - the same
    @objc private func ternimateApp() {
        NSApplication.shared.terminate(AnyObject.self)
    }

    @IBAction func selectAllTapped(_ sender: Any) {
//        self.filteredApps = self.filteredApps.map({
//            var app = $0
//            app.setSelected(true)
//            return app
//        })
//
//        for index in 0..<self.filteredApps.count {
//            if let cell = self.tableVeiw.tableColumns.first?.dataCell(forRow: index) as? AppViewCell {
//                cell.updateCheckbox()
//            }
//        }
//
//        self.tableVeiw.reloadData()

    }

    @IBAction func terminateTapped(_ sender: Any) {
        let appsToTerminate = self.filteredApps.filter({ $0.isSelected == true })
        let openApps = NSWorkspace.shared.runningApplications
        for app in openApps where app.activationPolicy == .regular {
            if appsToTerminate.contains(where: { $0.app.name == app.localizedName }) {
                app.forceTerminate()
            }
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.apps = []
            let openApps = NSWorkspace.shared.runningApplications
            for app in openApps where app.activationPolicy == .regular {
                self.apps.append(AppsListItem(app: App(name: app.localizedName ?? L10n.nameError.localize(),
                                                       icon: app.icon ?? NSImage(),
                                                       cpu: "0.3 % CPU")))
            }
            self.filteredApps = self.apps
            self.tableVeiw.reloadData()
        }
    }
}

extension MainScreenController: NSTableViewDataSource, NSTableViewDelegate {
    func numberOfRows(in tableView: NSTableView) -> Int { self.filteredApps.count }
    func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any? { self.filteredApps[row] }
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat { Constants.rowHeight }

    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cellId = NSUserInterfaceItemIdentifier(Constants.tableCellId)
        if let cellView = tableView.makeView(withIdentifier: cellId, owner: self) as? AppViewCell {
            cellView.configure(with: self.filteredApps[row]) { [weak self] in
                self?.filteredApps[row].toggleSelection()
                self?.terminateButton.isColored = self?.filteredApps.contains { $0.isSelected } ?? false
                guard let indexInUnfilteredApps = self?.apps.firstIndex(where: { $0.app == self?.filteredApps[row].app }) else { return }
                self?.apps[indexInUnfilteredApps].toggleSelection()
            }

            return cellView
        } else {
            return NSView()
        }
    }
}

// MARK: NSSearchFieldDelegate
extension MainScreenController: NSSearchFieldDelegate {
    func controlTextDidChange(_ obj: Notification) {
        guard let object = obj.object as? NSTextField else { return }
        self.filter = object.stringValue.trimmingCharacters(in: .whitespaces).lowercased()
    }
}
