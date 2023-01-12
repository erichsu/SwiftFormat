//
//  File.swift
//  
//
//  Created by Eric Hsu on 2023/1/12.
//

import PackagePlugin

struct SwiftFormatPluginBuildTool: BuildToolPlugin {
  func createBuildCommands(context: PackagePlugin.PluginContext, target: PackagePlugin.Target) async throws -> [PackagePlugin.Command] {
    guard let target = target as? SourceModuleTarget else {
      return []
    }
    return try target.sourceFiles(withSuffix: "swift").map { file in
      let base = file.path.stem
      return .buildCommand(
        displayName: "Formatting file for \(base)",
        executable: try context.tool(named: "swiftformat").path,
        arguments: [file.path]
      )
    }
  }
}
