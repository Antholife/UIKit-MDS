//
//  DocumentTableViewController.swift
//  File Explorer
//
//  Created by Anthony Chahat on 06.12.2023.
//

import UIKit
import QuickLook

struct DocumentFile {
    var title: String
    var size: Int
    var imageName: String? = nil
    var url: URL
    var type: String
}

extension Int {
    func formattedSize() -> String {
        return ByteCountFormatter().string(fromByteCount: Int64(self))
    }
}

extension DocumentTableViewController: UIDocumentPickerDelegate {

    @IBAction func pickDocument(_ sender: UIBarButtonItem) {
        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [UTType.item])
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = false
        present(documentPicker, animated: true, completion: nil)
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let selectedFileURL = urls.first else { return }
        
        guard selectedFileURL.startAccessingSecurityScopedResource() else {
            return
        }

        defer {
            selectedFileURL.stopAccessingSecurityScopedResource()
        }
        copyFileToDocumentsDirectory(fromUrl: selectedFileURL)
            
    }
    
    func copyFileToDocumentsDirectory(fromUrl url: URL) {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        let destinationUrl = documentsDirectory.appendingPathComponent(url.lastPathComponent)
        
        do {
            try FileManager.default.copyItem(at: url, to: destinationUrl)
        } catch {
            print(error)
        }
        do {
            let fileURLs = try FileManager.default.contentsOfDirectory(at: documentsDirectory, includingPropertiesForKeys: nil)
            if let lastFileURL = fileURLs.last {
                let resource = try lastFileURL.resourceValues(forKeys: [.typeIdentifierKey, .nameKey, .fileSizeKey])
                guard let name = resource.name, let size = resource.fileSize else {
                    return
                }
                importedFiles.append(DocumentFile(title: name,
                                                 size: size,
                                                 imageName: name,
                                                 url: destinationUrl,
                                                 type: "text/plain"))
                tableView.reloadData()
            } else {
                print("No files in directory")
            }
        } catch {
            print("Error recovering files : \(error)")
        }
    }
}

extension DocumentTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            if searchText.isEmpty {
                isSearching = false
            } else {
                isSearching = true
                filteredBundleFiles = bundleFiles.filter { $0.title.lowercased().contains(searchText.lowercased()) }
                filteredImportedFiles = importedFiles.filter { $0.title.lowercased().contains(searchText.lowercased()) }
            }
            tableView.reloadData()
        }
}

class DocumentTableViewController: UITableViewController, QLPreviewControllerDataSource {
    
    var importedFiles: [DocumentFile] = []
    var bundleFiles: [DocumentFile] = []
    let searchBar = UISearchBar()
    var filteredBundleFiles: [DocumentFile] = []
    var filteredImportedFiles: [DocumentFile] = []
    var isSearching = false
    
    var selectedPreviewURL: URL?
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        do {
            let items = try fm.contentsOfDirectory(atPath: path)
            for item in items {
                if item.hasPrefix("img") {
                    let url = URL(fileURLWithPath: "\(path)/\(item)")
                    let resource = try url.resourceValues(forKeys: [.typeIdentifierKey, .nameKey, .fileSizeKey])
                    guard let name = resource.name, let size = resource.fileSize else {
                        return
                    }
                    let imageName = (item as NSString).deletingPathExtension
                    bundleFiles.append(
                        DocumentFile(title: name, size: size, imageName: imageName, url: url, type: "text/plain"))
                }
            }
        }
        catch {
            print("Error while reading of file ")
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(!isSearching){
            if section == 0 {
                if(importedFiles.count == 0){
                    return 1
                }
                return importedFiles.count
            } else {
                if(bundleFiles.count == 0) {
                    return 1
                }
                return bundleFiles.count
            }
        }
        else {
            if section == 0 {
                if(filteredImportedFiles.count == 0){
                    return 1
                }
                return filteredImportedFiles.count
            } else {
                if(filteredImportedFiles.count == 0){
                    return 1
                }
                return filteredBundleFiles.count
            }
        }
    }
    
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "FileCell", for: indexPath)
         if(!isSearching){
             if indexPath.section == 0 {
                 if(importedFiles.count == 0){
                     cell.textLabel?.text = "No files imported"
                     cell.detailTextLabel?.text = ""
                     cell.accessoryType = .none
                 }
                 else {
                     let importedFile = importedFiles[indexPath.row]
                     cell.textLabel?.text = importedFile.title
                     cell.detailTextLabel?.text = importedFile.size.formattedSize()
                 }
             } else {
                 if(bundleFiles.count == 0){
                     cell.textLabel?.text = "No bundles available"
                     cell.detailTextLabel?.text = ""
                     cell.accessoryType = .none
                 }
                 else {
                     let bundleFile = bundleFiles[indexPath.row]
                     cell.textLabel?.text = bundleFile.title
                     cell.detailTextLabel?.text = bundleFile.size.formattedSize()
                 }
             }
         }
         else {
             if indexPath.section == 0 {
                 if(filteredImportedFiles.count == 0){
                     cell.textLabel?.text = "No imports found"
                     cell.detailTextLabel?.text = ""
                     cell.accessoryType = .none
                 }
                 else {
                     let importedFile = filteredImportedFiles[indexPath.row]
                     cell.textLabel?.text = importedFile.title
                     cell.detailTextLabel?.text = importedFile.size.formattedSize()
                 }
             } else {
                 if(filteredBundleFiles.count == 0){
                     cell.textLabel?.text = "No bundles found"
                     cell.detailTextLabel?.text = ""
                     cell.accessoryType = .none
                 }
                 else {
                     let bundleFile = filteredBundleFiles[indexPath.row]
                     cell.textLabel?.text = bundleFile.title
                     cell.detailTextLabel?.text = bundleFile.size.formattedSize()
                 }
             }
         }
         return cell
     }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Importations"
        } else {
            return "Bundles"
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        var selectedFile: URL
        if (!isSearching){
            if indexPath.section == 0 {
                if(importedFiles.count == 0){
                    return
                }
                selectedFile = importedFiles[indexPath.row].url
            } else {
                if(bundleFiles.count == 0){
                    return
                }
                selectedFile = bundleFiles[indexPath.row].url
            }
        }
        else {
            if indexPath.section == 0 {
                if(filteredImportedFiles.count == 0){
                    return
                }
                selectedFile = filteredImportedFiles[indexPath.row].url
            } else {
                if(filteredBundleFiles.count == 0){
                    return
                }
                selectedFile = filteredBundleFiles[indexPath.row].url
            }
        }
            self.instantiateQLPreviewController(withUrl: selectedFile)
    }
    
    func instantiateQLPreviewController(withUrl url: URL) {
            let previewController = QLPreviewController()
            previewController.dataSource = self
            self.selectedPreviewURL = url
            navigationController?.pushViewController(previewController, animated: true)
    }
    
    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        return 1
    }
    
    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        guard let url = selectedPreviewURL else {
                    fatalError("No URL selected")
                }
        return url as QLPreviewItem
    }
}
