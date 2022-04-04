//
//  File.swift
//  
//
//  Created by Chris Davis on 04/04/2022.
//

import Foundation

extension FileManager {

  public func loadFeatureFile(at url: URL) -> String {
    let dataStr = try? String(contentsOf: url)
    return dataStr ?? ""
  }

}

extension FileManager {

  public func findFiles(at url: URL) -> [URL] {
    var files = [URL]()
    if let enumerator = FileManager.default.enumerator(at: url, includingPropertiesForKeys: [.isRegularFileKey], options: [.skipsHiddenFiles, .skipsPackageDescendants]) {
        for case let fileURL as URL in enumerator {
            do {
                let fileAttributes = try fileURL.resourceValues(forKeys:[.isRegularFileKey])
                if fileAttributes.isRegularFile! {
                    files.append(fileURL)
                }
            } catch { print(error, fileURL) }
        }
        print(files)
    }
    return files
  }

  /**
   Find all feature files in project
   Puts them in a random order
   */
  public func findAllFeatureFiles(named: String? = nil, bundle: Bundle) -> [URL] {
    guard let baseURL = bundle.resourceURL else {
      return []
    }

    do {
      let root = findFiles(at: baseURL)
      let files = root.filter({ $0.pathExtension == "feature" })

      if let n = named {
        return files.filter({ $0.lastPathComponent == n })
      } else {
        return files
      }
    } catch {
      print("\(error)")
    }

    return []
  }

}
