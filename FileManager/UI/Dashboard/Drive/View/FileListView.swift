//
//  FileListView.swift
//  FileManager
//
//  Created by Naveen Chauhan on 08/10/21.
//

import UIKit
import SDWebImage
class FileListView: UIViewController,ViewProtocol {
    var tag: Int?
    
    
    
    var tableContentSize:CGSize?
    
    static let fileCellIdentifire:String = "fileCell"
    let selectedFile: File?
    var order: Int?
    static let TAG_TABLE_CONTAINER:Int = 3333
    static let TAG_PARENT_SCROLL:Int = 1111
    static let TAG_PARENT_SCROLL_CONTAINER:Int = 2222
    static let TAG_FOLDER_SCROLL:Int = 4444
    
    
    /////////////////TEMPLATE ELEMENTS////////////////////
    
     var headerTitle:PaddedLabel?
    var headerSubTitle:PaddedLabel?
    var progressLbl:PaddedLabel?
    /////////////////END///////////////////////////////////
    func getView() -> UIView {
        return self.view
    }
    lazy var scrollContentView: UIView = {
            let view = UIView()
        view.tag = FileListView.TAG_PARENT_SCROLL_CONTAINER
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
    
    lazy var scrollView: UIScrollView = {
            let view = UIScrollView()
            view.tag = FileListView.TAG_PARENT_SCROLL
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
    
    var filesTableView: UITableView!
    
    var tableContainerView: UIView!
    var presenter: FileListViewToPresenterProtocol?
    var fileList = [File]()
    var folderList = [File]()
    var templateView: UIView!
    
    lazy var fileTemplate:FilesTemplate = {
        var template = FilesTemplate(name: "drive",order: 1)
        if  selectedFile == nil {
            template.driveHeader = FileListTemplate.getSubTemplateHeader()
            template.driveStorage = FileListTemplate.getSubTemplateStorage()
            template.driveSearch = FileListTemplate.getSubTemplateSearch(frame:self.view.frame)
        }
        
        template.driveFoldersContainer = FileListTemplate.getSubTemplateFolders()
        template.driveFilesContainer = FileListTemplate.getSubTemplateFiles()
        template.properties = [
        
        ]
        return template
    }()
    
    init(file:File?)
    {
        self.selectedFile = file
       
        super.init(nibName: nil, bundle: nil)

        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        for family in UIFont.familyNames {
            print("**\(family)\n")
            for name in UIFont.fontNames(forFamilyName: family){
                print("*****\(name)\n")
            }
        }
       
        scrollView = UIScrollView()
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        self.setupView()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    func addTemplateView(template:FilesTemplate,templateView:UIView){
        
       
        templateView.translatesAutoresizingMaskIntoConstraints = false
        scrollContentView.addSubview(templateView)
        scrollView.addSubview(scrollContentView)
        self.view.addSubview(scrollView)
        
        
        templateView.translatesAutoresizingMaskIntoConstraints = false
        scrollContentView.addSubview(templateView)
        scrollView.addSubview(scrollContentView)
        self.view.addSubview(scrollView)
       
        if let attributes = template.properties {
            setRelativeStackProperties(view: templateView, relativeView: scrollContentView, properties: attributes)
        }
    }
    
    func updateTemplateHeaderSection(template:FilesTemplate){
        
        if let tag = template.driveHeader?.title?.tag, let titleLbl = self.view.viewWithTag(tag) as? UILabel{
           // titleLbl.text = "Header"
        }
        
        if let tag = template.driveHeader?.subtitle?.tag, let titleLbl = self.view.viewWithTag(tag) as? UILabel{
           // titleLbl.text = "Sub Header"
        }
        
        if let tag = template.driveHeader?.image?.tag, let imageView = self.view.viewWithTag(tag) as? UIImageView{
            if let resource = template.driveHeader?.image?.resource {
                imageView.image = UIImage(named: resource)
            }
        }
    }
    
    func updateTemplateStorageSection(template:FilesTemplate){
        if let tag = template.driveStorage?.title?.tag, let titleLbl = self.view.viewWithTag(tag) as? UILabel{
            titleLbl.text = "21MB"
            titleLbl.sizeToFit()
        }
        
        if let tag = template.driveStorage?.subtitle?.tag, let subLbl = self.view.viewWithTag(tag) as? UILabel{
            subLbl.text = "Free of 2GB"
        }
        
        if let tag = template.driveStorage?.progress?.tag, let progressStack = self.view.viewWithTag(tag) as? UIStackView{
            let subtitleLbl = getLabel()
            subtitleLbl.backgroundColor = UIColor.red
            progressStack.addArrangedSubview(subtitleLbl)
        }
        
    }
    
    func updateTemplateSearchSection(template:FilesTemplate){
        if let tag = template.driveSearch?.tag, let searchStack = self.view.viewWithTag(tag) as? UIStackView{
            let searchBar = UISearchBar()
           // let image = getImageWithColor(color: UIColor.clear, size: CGSize(width: 1, height: searchHeight!))
            //  searchBar.setSearchFieldBackgroundImage(image, for: .normal)
            if let height = template.driveSearch?.searchHeight {
                searchBar.layer.cornerRadius = height/2
                searchBar.heightAnchor.constraint(equalToConstant: height).isActive = true
                searchBar.translatesAutoresizingMaskIntoConstraints = false
            }
            
            searchBar.layer.masksToBounds = true
            searchBar.searchBarStyle = UISearchBar.Style.default
            if let title = template.driveSearch?.title {
                searchBar.placeholder = title.text
            }
            
                searchBar.sizeToFit()
                searchBar.isTranslucent = false
            searchBar.layer.borderWidth = 0.5
            searchBar.layer.borderColor = UIColor.lightGray.cgColor
            
            
            
            if #available(iOS 13.0, *) {
                searchBar.searchTextField.backgroundColor = .white
            } else {
                // Fallback on earlier versions
            }
            
            searchStack.addArrangedSubview(searchBar)
        }
    }
    
    func updateTemplateFolderSection(template:FilesTemplate){
        if let tag = template.driveFoldersContainer?.horizontalBar?.tag, let folderStack = self.view.viewWithTag(tag) as? UIStackView{
            for view in folderStack.arrangedSubviews {
                folderStack.removeArrangedSubview(view)
            }
            let s = UIScrollView()
            
            s.showsHorizontalScrollIndicator = false
            s.translatesAutoresizingMaskIntoConstraints = false
           
            folderStack.addArrangedSubview(s)
            
            let hScroll = getHStack(spacing: 10,alignment: .fill, distribution: .fillEqually)
            hScroll.translatesAutoresizingMaskIntoConstraints = false
            var contentSize:CGFloat = 0.0
            
            for (index,file) in folderList.enumerated() {
                var folderElement = FolderElement(order: index)
                folderElement.title = template.driveFoldersContainer?.horizontalBar?.title
                folderElement.title?.text = file.name
                
                folderElement.image = template.driveFoldersContainer?.horizontalBar?.image
                folderElement.image?.resource = "folder"
                folderElement.properties = template.driveFoldersContainer?.horizontalBar?.properties
                if let stack = folderElement.getView() as? UIStackView {
                    stack.isUserInteractionEnabled = true
                    let folderTapGuesture:FolderTapGuesture = FolderTapGuesture(target: self, action:  #selector(folderTapped))
                    folderTapGuesture.file = file
                    stack.addGestureRecognizer(folderTapGuesture)
                    hScroll.addArrangedSubview(stack)
                    contentSize+=112.0
                }
           
            }
           
            s.addSubview(hScroll)
            s.contentSize = CGSize(width:contentSize,height: hScroll.frame.height)
            
            
            
            NSLayoutConstraint.activate([
                hScroll.heightAnchor.constraint(equalTo: s.heightAnchor),
                hScroll.leadingAnchor.constraint(equalTo: s.leadingAnchor),
                hScroll.centerYAnchor.constraint(equalTo: s.centerYAnchor),
                s.leftAnchor.constraint(equalTo: folderStack.leftAnchor),
                s.rightAnchor.constraint(equalTo: folderStack.rightAnchor),
                s.topAnchor.constraint(equalTo: folderStack.topAnchor),
                s.bottomAnchor.constraint(equalTo: folderStack.bottomAnchor),
                
            ])
        }
    }
    
    func updateTemplateFilesSection(template:FilesTemplate){
        if let tableContainer = self.view.viewWithTag((template.driveFilesContainer?.table?.tag)!) as? UIStackView {
            tableContainerView = tableContainer
            self.filesTableView = UITableView(frame: CGRect.zero)
            
            self.filesTableView.separatorColor = UIColor.clear
            self.filesTableView.register(FileTableViewCell.self, forCellReuseIdentifier: FileListView.fileCellIdentifire)
            self.filesTableView.translatesAutoresizingMaskIntoConstraints = false
            self.filesTableView.register(UITableViewCell.self, forCellReuseIdentifier: "FileCell")
            self.filesTableView.delegate = self
            self.filesTableView.dataSource = self
            tableContainer.addSubview(self.filesTableView)
            
            
            //*** lookhere
            let tableHeighContstraint = self.filesTableView.heightAnchor.constraint(greaterThanOrEqualToConstant: 0)
            tableHeighContstraint.priority = UILayoutPriority(120)
            
            
            NSLayoutConstraint.activate([
                self.filesTableView.leadingAnchor.constraint(equalTo: tableContainer.leadingAnchor),
                self.filesTableView.topAnchor.constraint(equalTo: tableContainer.topAnchor),
                self.filesTableView.trailingAnchor.constraint(equalTo: tableContainer.trailingAnchor),
                tableHeighContstraint,
                tableContainerView.heightAnchor.constraint(equalTo: self.filesTableView.heightAnchor)

            ])

        }
    }
    func setupView(){
        let template = self.fileTemplate
        let templateView = template.getView()
        addTemplateView(template: template, templateView: templateView)
        updateTemplateHeaderSection(template: template)
        updateTemplateStorageSection(template: template)
        updateTemplateSearchSection(template: template)
        updateTemplateFolderSection(template: template)
        updateTemplateFilesSection(template: template)
        self.setScrollingConstraints(templateView: templateView)
        
        FileListRouter.createFileListModule(fileListRef: self)
        presenter?.fetchFileList(path:"/")
        
        /**
         ********************************
         *THIS IS TO PRINT THE DESIGN JSONN
         ********************************
         
         
         **/
        do{
            let data = try  JSONEncoder().encode(template)
            let jsonString = String(data:data, encoding: .utf8)
            print(jsonString)

        }catch{
            print("error")
        }

    }
    
    
    @objc func folderTapped(sender:FolderTapGuesture){
        if let file = sender.file {
            presenter?.showFileDetail(file: file, fromView: self)
        }
        
        
    }
    
    @objc func menuButtonClicked(sender:UIButton){
        let alert = UIAlertController(title: "Actions", message: "Please Select an Option", preferredStyle: .actionSheet)
            
            alert.addAction(UIAlertAction(title: "View", style: .default , handler:{ (UIAlertAction)in
                print("User click View button")
            }))
            
            alert.addAction(UIAlertAction(title: "Download", style: .default , handler:{ (UIAlertAction)in
                print("User click Download button")
            }))

            alert.addAction(UIAlertAction(title: "Rename", style: .default , handler:{ (UIAlertAction)in
                print("User click Rename button")
            }))
                alert.addAction(UIAlertAction(title: "Delete", style: .default , handler:{ (UIAlertAction)in
                    print("User click Delete button")
                }))
            
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler:{ (UIAlertAction)in
                print("User click Dismiss button")
            }))

            
            //uncomment for iPad Support
            //alert.popoverPresentationController?.sourceView = self.view

            self.present(alert, animated: true, completion: {
                print("completion block")
            })
    }
    func setScrollingConstraints(templateView:UIView){
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            
            scrollView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint  (equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            
            
            scrollContentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            scrollContentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            
            scrollContentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            scrollContentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            
            scrollContentView.widthAnchor.constraint(equalTo: self.view.widthAnchor),

            scrollContentView.bottomAnchor.constraint(equalTo: templateView.bottomAnchor),
            templateView.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor),
            templateView.topAnchor.constraint(equalTo: scrollContentView.topAnchor),
            
            templateView.trailingAnchor.constraint(equalTo: scrollContentView.trailingAnchor),

            
            templateView.widthAnchor.constraint(equalTo: scrollContentView.widthAnchor),
            
        ])
        
        if let st = templateView as? UIStackView {
            NSLayoutConstraint.activate([
                st.topAnchor.constraint(equalToSystemSpacingBelow: scrollContentView.topAnchor, multiplier: 11.61   ),
            
            ])

        }
    }
    
    
    
}


extension FileListView: FileListPresenterToViewProtocol {
    
    
    
    
    func onFetchResponseSuccess(files: [File]?) {
        // look here
        // ****
        
        
        if let list = files {
            fileList = list.filter { ($0.ext == FileType.PDF.rawValue || $0.ext == FileType.Image.rawValue)}
            folderList = list.filter { $0.isDirectory}
            
            let height = 72 * fileList.count
            let tableHeight = CGFloat(height)
            
            filesTableView.reloadData()
            filesTableView.layoutIfNeeded()
            updateTemplateFolderSection(template:fileTemplate)
           /**
            filesTableView.heightAnchor.constraint(equalToConstant: filesTableView.contentSize.height).isActive = true
            **/
            filesTableView.heightAnchor.constraint(equalToConstant: tableHeight).isActive = true
            filesTableView.isScrollEnabled = false
            
            
    //        if let scrollView = self.view.viewWithTag(FileListView.TAG_FOLDER_SCROLL) as? UIScrollView {
    //            let hScroll = getHStack(spacing: 10,alignment: .fill, distribution: .fillEqually)
    //            hScroll.translatesAutoresizingMaskIntoConstraints = false
    //            var contentSize:CGFloat = 0.0
    //            for (index,folder) in tFolders.enumerated() {
    //                var folderElement = FolderElement(order: index)
    //                folderElement.title = fileTemplate.driveFoldersContainer?.horizontalBar?.title
    //                folderElement.image = fileTemplate.driveFoldersContainer?.horizontalBar?.image
    //                folderElement.image?.resource = "folder"
    //                folderElement.title?.text = folder.title?.text
    //
    //                hScroll.addArrangedSubview(folderElement.getView())
    //
    //                contentSize+=112.0
    //            }
    //            scrollView.addSubview(hScroll)
    //            scrollView.contentSize = CGSize(width:contentSize,height: hScroll.frame.height)
    //
    //            NSLayoutConstraint.activate([
    //                hScroll.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
    //                hScroll.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
    //                hScroll.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
    //            ])
    //
    //        }
        }
        
        
        
        
        
    }
    
    func onFetchResponseFailure(error: String?) {
        DispatchQueue.main.async{
            let alert = UIAlertController(title: "Actions", message: error, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default , handler:{ (UIAlertAction)in
                print("OK Clicked")
            }))
            self.present(alert, animated: true)
        }
        
    }
    
    
}
extension FileListView: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72.0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return fileList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = filesTableView.dequeueReusableCell(withIdentifier: FileListView.fileCellIdentifire, for: indexPath) as! FileTableViewCell
        let file = fileList[indexPath.row]
        cell.titleLabel.text = file.name
        
        cell.storageLabel.text = file.size
        if let imgData = file.thumbnailImage {
            cell.fileImage.image = UIImage(data:imgData)
        }else{
            cell.fileImage.image = UIImage(named: "file")
        }
        
        if let titleAttributes = fileTemplate.driveFilesContainer?.table?.title?.properties{
            setTextProperties(label: cell.titleLabel, properties: titleAttributes)
        }
        
        if let imgProperties = fileTemplate.driveFilesContainer?.table?.image?.properties{
            setImageProperties(image: cell.fileImage, properties: imgProperties)
        }
        
        if let storageAttributes = fileTemplate.driveFilesContainer?.table?.subtitle?.properties{
            setTextProperties(label: cell.storageLabel, properties: storageAttributes)
        }
        cell.menu.addTarget(self, action: #selector(menuButtonClicked), for:.touchUpInside)
        cell.menu.tag = indexPath.row
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.showFileDetail(file: fileList[indexPath.row], fromView: self)
    }
}




