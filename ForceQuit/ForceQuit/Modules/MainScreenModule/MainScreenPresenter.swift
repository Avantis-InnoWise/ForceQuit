//
//  MainScreenPresenter.swift
//  ForceQuit
//
//  Created by mac on 25.12.21.
//

import Cocoa

final class MainScreenPresenter: MainScreenPresenterProtocol {
    var apps: [AppsListItem] = []
    var filteredApps: [AppsListItem] = []
    weak var delegate: MainScreenViewProtocol?

    init() {
        self.setUpAppsData()
    }

    func setUpAppsData() {
        self.apps = []
        let openApps = NSWorkspace.shared.runningApplications
        let cpus = CPU.getCpu()
        for app in openApps where app.activationPolicy == .regular {
            let cpuCount = (Double(cpus[Int(app.processIdentifier)] ?? String.zero) ?? 0) / Double(ProcessInfo.processInfo.processorCount)
            self.apps.append(AppsListItem(app: App(name: app.localizedName ?? L10n.nameError.localize(),
                                                   icon: app.icon ?? NSImage(),
                                                   cpu: cpuCount.rounded(toPlaces: 1).description.appending(" % CPU"))))
        }

        if !self.filteredApps.contains(where: { $0.isSelected == true }) {
            self.filteredApps = self.apps
            delegate?.updateTableView()
        }
    }

    func filterApps(text: String) {
        self.filteredApps = text.isEmpty ? self.apps : self.apps.filter { $0.app.name.lowercased().contains(text) }
        delegate?.updateTableView()
    }

    func selectAllApps() {
        if self.filteredApps.first(where: { $0.isSelected == false }) != nil {
            self.filteredApps = self.filteredApps.map({
                var app = $0
                app.setSelected(true)
                return app
            })
        } else {
            self.filteredApps = self.filteredApps.map({
                var app = $0
                app.setSelected(false)
                return app
            })
        }
        delegate?.updateTableView()
    }

    func forceQuitApp() {
        let appsToTerminate = self.filteredApps.filter({ $0.isSelected == true })
        let openApps = NSWorkspace.shared.runningApplications
        for app in openApps where app.activationPolicy == .regular {
            if appsToTerminate.contains(where: { $0.app.name == app.localizedName }) {
                app.forceTerminate()
            }
        }

        self.filteredApps = self.filteredApps.map({
            var app = $0
            app.setSelected(false)
            return app
        })

        delegate?.updateTableView()
    }
}
