//
//  MainScreenEntity.swift
//  ForceQuit
//
//  Created by mac on 22.12.21.
//

import Cocoa

public struct App: Equatable {
    var name: String
    var icon: NSImage
    var cpu: String
}

public struct AppsListItem {
    let app: App
    var isSelected: Bool = false

    mutating func setSelected(_ isSelected: Bool) {
        self.isSelected = isSelected
    }

    mutating func toggleSelection() {
        self.isSelected.toggle()
    }
}

final class CPU {
    func getCpu() -> [Int: String] {
        do {
            self.writeToFile(name: "pid.txt", text: try executeCommand("ps aux | awk '{print $2}'"))
            self.writeToFile(name: "cpu.txt", text: try executeCommand("ps aux | awk '{print $3}'"))
            let appsCpu = self.readFiles()
            if !appsCpu.isEmpty {
                return appsCpu
            }
        } catch {
            debugPrint(error)
        }

        return [:]
    }

    private func readFiles() -> [Int: String] {
        var draftDict: [Int: String] = [:]
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let pidFileURL = dir.appendingPathComponent("pid.txt")
            let cpuFileURL = dir.appendingPathComponent("cpu.txt")

            do {
                let pidOutput = try String(contentsOf: pidFileURL, encoding: .utf8)
                let cpuOutput = try String(contentsOf: cpuFileURL, encoding: .utf8)
                if !pidOutput.isEmpty && !cpuOutput.isEmpty {
                    var pidArray = pidOutput.split(separator: "\n")
                    var cpuArray = cpuOutput.split(separator: "\n")
                    pidArray.removeFirst(); cpuArray.removeFirst()
                    for (pid, cpu) in zip(pidArray, cpuArray) {
                        draftDict.updateValue(String(cpu), forKey: Int(pid) ?? 0)
                    }
                }
                return draftDict
            } catch {
                debugPrint(error)
            }
        }
        return [:]
    }

    private func writeToFile(name: String, text: String) {
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let pidFileURL = dir.appendingPathComponent(name)
            do {
                try text.write(to: pidFileURL, atomically: false, encoding: .utf8)
            } catch {
                debugPrint(error)
            }
        }
    }

    private func executeCommand(_ command: String) throws -> String {
        let task = Process()
        let pipe = Pipe()
        task.standardOutput = pipe
        task.standardError = pipe
        task.arguments = ["-c", command]
        task.executableURL = URL(fileURLWithPath: "/bin/zsh")

        do {
            try task.run()
        } catch { throw error }
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        if let output = String(data: data, encoding: .utf8) {
            return output
        } else {
            return "command execution failed"
        }
    }
}
