//
//  MainScreenProtocols.swift
//  ForceQuit
//
//  Created by mac on 25.12.21.
//

import Foundation

public protocol MainScreenPresenterProtocol {
    var apps: [AppsListItem] { get set }
    var filteredApps: [AppsListItem] { get set }
    var delegate: MainScreenDelegate? { get set }

    func setUpAppsData()
    func forceQuitApp()
    func filterApps(text: String)
    func selectAllApps()
}
