import PackagePlugin

/**
 https://github.com/apple/swift-evolution/blob/main/proposals/0303-swiftpm-extensible-build-tools.md
 */
@main
struct BuildPlugin: BuildToolPlugin {
  /// This plugin's implementation returns a single `prebuild` command to run `swiftgen`.
  func createBuildCommands(context: PluginContext, target: Target) throws -> [Command] {
    // This example configures `swiftgen` to take inputs from a `swiftgen.yml` file
    //let swiftGenConfigFile = context.package.directory.appending("swiftgen.yml")

    // This example configures the command to write to a "GeneratedSources" directory.
    let genSourcesDir = context.pluginWorkDirectory//.appending("GeneratedSources")

    Diagnostics.warning("test in build")
    print("in build")
    print("genSourcesDir: \(genSourcesDir)")
    // try context.tool(named: "swiftgen").path,
    ///usr/bin/curl
    ///Path("echo")

    print(context.pluginWorkDirectory)
    print(target.name)

    return [.prebuildCommand(
      displayName: "Running echo",
      executable: Path("/usr/bin/curl"),
      arguments: [
        "-I", "https://www.google.com",
        "-o", "googleOutput.txt"
      ],
      environment: [
        "PROJECT_DIR": "\(context.pluginWorkDirectory)",
        "TARGET_NAME": "\(target.name)",
        "DERIVED_SOURCES_DIR": "\(genSourcesDir)",
      ],
      outputFilesDirectory: genSourcesDir)]

    //return []
  }
}
