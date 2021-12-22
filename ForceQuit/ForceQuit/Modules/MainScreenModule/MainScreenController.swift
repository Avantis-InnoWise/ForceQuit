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

    private var apps = [AppsListItem]()
    private var filteredApps = [AppsListItem]()
    private var filter = "" {
        didSet {
            self.filteredApps = filter.isEmpty ? self.apps : self.apps.filter { $0.app.name.lowercased().contains(self.filter) }
            self.tableVeiw.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.searchField.appearance = NSAppearance(named: .aqua)
        self.searchField.delegate = self


        DispatchQueue.main.async { [weak self] in
            let openApps = NSWorkspace.shared.runningApplications
            for app in openApps where app.activationPolicy == .regular {
                self?.apps.append(AppsListItem(app: App(name: app.className, icon: app.icon ?? NSImage())))
            }
            self?.filteredApps = self?.apps ?? []
            self?.tableVeiw.reloadData()
        }
    }

    private func terminateAllApps() {
        let openApps = NSWorkspace.shared.runningApplications
        for app in openApps where app.activationPolicy == .regular {
            app.forceTerminate()
        }
    }

    // can get icons from NSRunningAplication, title - the same
    @objc private func ternimateApp() {
        NSApplication.shared.terminate(AnyObject.self)
    }

    @IBAction func selectAllTapped(_ sender: Any) {
    }

    @IBAction func terminateTapped(_ sender: Any) {
    }
}

extension MainScreenController: NSTableViewDataSource, NSTableViewDelegate {
    func numberOfRows(in tableView: NSTableView) -> Int { self.filteredApps.count }
    func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any? { self.filteredApps[row] }
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat { Constants.rowHeight }

    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cellId = NSUserInterfaceItemIdentifier(Constants.tableCellId)
        if let cellView = tableView.makeView(withIdentifier: cellId, owner: self) as? AppViewCell {
            cellView.configure(with: filteredApps[row]) { [weak self] in
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
