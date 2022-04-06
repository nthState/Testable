import PackagePlugin
import Foundation

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
    let file = genSourcesDir.appending("googleOutput.txt")

    //let url = URL(string: "https://blog.nthstate.com")!
//
//    FileManager.default.createFile(atPath: file.string, contents: nil)
//
//    let d = try? Data(contentsOf: url)
//    print("remote: \(d)")
//    let semaphore = DispatchSemaphore(value: 0)
//
//    let task = URLSession.shared.dataTask(with: url) { data, response, error in
//      semaphore.signal()
//      guard let data = data else {
//        print(url)
//        fatalError(error?.localizedDescription ?? "Unknown Error")
//      }
//
//      print("readl: \(data)")
//
//    }
//
//    task.resume()

//    _ = semaphore.wait(timeout: .distantFuture)
//
//    sleep(3)

    //Diagnostics.warning("test in build")
    //print("in build")
    print("genSourcesDir: \(genSourcesDir)")
    // try context.tool(named: "swiftgen").path,
    ///usr/bin/curl
    ///Path("echo")

    return [.prebuildCommand(
      displayName: "Running echo",
      executable: Path("/usr/bin/curl"),
      arguments: [
        "-XGET", "https://blog.nthstate.com",
        "-o", file
      ],
      //      environment: [
      //        "PROJECT_DIR": "\(context.pluginWorkDirectory)",
      //        "TARGET_NAME": "\(target.name)",
      //        "DERIVED_SOURCES_DIR": "\(genSourcesDir)",
      //      ],
      environment: [:],
      outputFilesDirectory: genSourcesDir)]

    //    return [.buildCommand(
    //      displayName: "Running echo",
    //      executable: Path("/usr/bin/curl"),
    //      arguments: [
    //        "-I", "https://www.google.com",
    //        "-o", file
    //      ],
    //      environment: [:])]
  }
}
