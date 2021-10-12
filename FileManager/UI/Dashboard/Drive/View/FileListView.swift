//
//  FileListView.swift
//  FileManager
//
//  Created by Naveen Chauhan on 08/10/21.
//

import UIKit

class FileListView: UIViewController, FileListPresenterToViewProtocol,ViewProtocol {
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
    var templateView: UIView!
    
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
        scrollView = UIScrollView()
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        self.setupView()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    
    func setupView(){
        let template = getTemplate()
        
        
        // Added View
        
        templateView = template.getView()
        templateView.translatesAutoresizingMaskIntoConstraints = false
        scrollContentView.addSubview(templateView)
        scrollView.addSubview(scrollContentView)
        self.view.addSubview(scrollView)
       
        if let attributes = template.properties {
            setRelativeStackProperties(view: templateView, relativeView: scrollContentView, properties: attributes)
        }
            
        //End
       
       ///// INSERT VALUES IN HEADER /////
        
        
        if let tag = template.driveHeader?.title?.tag, let titleLbl = self.view.viewWithTag(tag) as? UILabel{
            titleLbl.text = "FileManger"
        }
        
        if let tag = template.driveHeader?.subtitle?.tag, let titleLbl = self.view.viewWithTag(tag) as? UILabel{
            titleLbl.text = "Static Template and Dynamic Styling from Backend"
        }
        
        if let tag = template.driveHeader?.image?.tag, let imageView = self.view.viewWithTag(tag) as? UIImageView{
            if let resource = template.driveHeader?.image?.resource {
                imageView.image = UIImage(named: resource)
            }
        }
        
        ///////////////////// END /////////////////////
        
        ///// INSERT VALUES IN STORAGE /////
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
        
        ///////////////////// END /////////////////////
        
        ///// INSERT VALUES IN STORAGE /////
        
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
        ///////////////////////END///////////////////
        
        ///// INSERT FOLDERS IN SCROLL /////
        
        if let tag = template.driveFoldersContainer?.horizontalBar?.tag, let folderStack = self.view.viewWithTag(tag) as? UIStackView{
            let s = UIScrollView()
            
            s.showsHorizontalScrollIndicator = false
            s.translatesAutoresizingMaskIntoConstraints = false
           
            folderStack.addArrangedSubview(s)
            
            let hScroll = getHStack(spacing: 10,alignment: .fill, distribution: .fillEqually)
            hScroll.translatesAutoresizingMaskIntoConstraints = false
            var contentSize:CGFloat = 0.0
            
            for n in 1...10 {
                var folderElement = FolderElement(order: n)
                folderElement.title = template.driveFoldersContainer?.horizontalBar?.title
                folderElement.title?.text = "Folder \(n)"
                
                folderElement.image = template.driveFoldersContainer?.horizontalBar?.image
                folderElement.image?.resource = "folder"
                folderElement.properties = template.driveFoldersContainer?.horizontalBar?.properties
                if let stack = folderElement.getView() as? UIStackView {
                    stack.isUserInteractionEnabled = true
                    let folderTapGuesture:FolderTapGuesture = FolderTapGuesture(target: self, action:  #selector(folderTapped))
                    folderTapGuesture.file = File(isFolder: true, order: 1)
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
        
        
        
        ///////////////////////END///////////////////
        
        ///// INSERT FOLDERS IN SCROLL /////
        
        if let tableContainer = self.view.viewWithTag(FileListView.TAG_TABLE_CONTAINER) {
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
        
        //////////////////////END///////////////////////////
        
        
        self.setScrollingConstraints(templateView: templateView)
        
        FileListRouter.createFileListModule(fileListRef: self)
        presenter?.loadFileList(file:selectedFile)

        
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
    
    
    func showFiles(files: [File]) {
        // look here
        // ****
        
        var tFiles:[File] = []
        var tFolders:[File] = []
        tFiles = files.filter{ $0.isFolder == false }
        tFolders = files.filter{ $0.isFolder == true }
        
        let height = 72 * files.count
        let myCGFloat = CGFloat(height)
        fileList = files
        filesTableView.reloadData()
        filesTableView.layoutIfNeeded()
        
       /**
        filesTableView.heightAnchor.constraint(equalToConstant: filesTableView.contentSize.height).isActive = true
        **/
        filesTableView.heightAnchor.constraint(equalToConstant: myCGFloat).isActive = true
        filesTableView.isScrollEnabled = false
        
        
        if let scrollView = self.view.viewWithTag(FileListView.TAG_FOLDER_SCROLL) as? UIScrollView {
            let hScroll = getHStack(spacing: 10,alignment: .fill, distribution: .fillEqually)
            hScroll.translatesAutoresizingMaskIntoConstraints = false
            var contentSize:CGFloat = 0.0
            for (index,folder) in tFolders.enumerated() {
                var folderElement = FolderElement(order: index)
                folderElement.title = TextProperties()
                folderElement.image = ImagePropterties()
                folderElement.image?.resource = "folder"
                folderElement.title?.text = folder.title?.text
                folderElement.image?.properties = [
                    Properties(attr: Attributes.backgroundColor.rawValue, value: "#OOOOOOFF"),
                    Properties(attr: Attributes.width.rawValue, value: "40.0"),
                    
                ]
                folderElement.title?.properties = [
                    Properties(attr: Attributes.height.rawValue, value: "20"),
                    Properties(attr: Attributes.fontSize.rawValue, value: "12"),
                    Properties(attr: Attributes.fontFamily.rawValue, value: "OpenSans-SemiBold"),
                    Properties(attr: Attributes.textAlignment.rawValue, value: "center"),
                    Properties(attr: Attributes.topPadding.rawValue, value:"8")
                ]
                
                folderElement.properties = [
                    Properties(attr: Attributes.width.rawValue, value: "104"),
                    Properties(attr: Attributes.height.rawValue, value: "104")
                ]
                hScroll.addArrangedSubview(folderElement.getView())
                
                contentSize+=112.0
            }
            scrollView.addSubview(hScroll)
            scrollView.contentSize = CGSize(width:contentSize,height: hScroll.frame.height)
            
            NSLayoutConstraint.activate([
                hScroll.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
                hScroll.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
                hScroll.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
            ])
            
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
        cell.titleLabel.text = file.title?.text
        cell.storageLabel.text = file.size?.text
        cell.fileImage.image = UIImage(named: "folder")
        
        if let titleAttributes = file.title?.properties {
            setTextProperties(label: cell.titleLabel, properties: titleAttributes)
        }
        
        if let imgProperties = file.image?.properties {
            setImageProperties(image: cell.fileImage, properties: imgProperties)
        }
        
        if let storageAttributes = file.size?.properties {
            setTextProperties(label: cell.storageLabel, properties: storageAttributes)
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.showFileDetail(file: fileList[indexPath.row], fromView: self)
    }
}


extension FileListView {
    func getTemplate()->FilesTemplate {
        var template = FilesTemplate(name: "drive",order: 1)
        if  selectedFile == nil {
            template.driveHeader = getFilesHeader()
            template.driveStorage = getFilesStorage()
            template.driveSearch = getFilesSearch()
        }
        
        template.driveFoldersContainer = getNewDriveFolders()
        template.driveFilesContainer = getDriveFiles()
        template.properties = [
        
        ]
        return template
        
    }
    func getFilesHeader()->FilesHeader{
        var driveHeader = FilesHeader(order:1)
        driveHeader.title = TextProperties()
        driveHeader.title?.tag = 10
        driveHeader.title?.text = "FileManager Drive"
        driveHeader.title?.properties = [
            Properties(attr: Attributes.textColor.rawValue, value: "#FFFFFFFF"),
            Properties(attr: Attributes.fontWeight.rawValue, value: "700.0"),
            Properties(attr: Attributes.fontSize.rawValue, value: "24.0"),
           
            
            Properties(attr: Attributes.fontFamily.rawValue, value: "Metropolis-Regular")
        ]
        
        driveHeader.subtitle = TextProperties()
        driveHeader.subtitle?.tag = 11
        driveHeader.subtitle?.text = "Documents in the FileManager Drive are Not treated as authentic"
        driveHeader.subtitle?.properties = [
            Properties(attr: Attributes.textColor.rawValue, value: "#FFFFFFFF"),
            Properties(attr: Attributes.fontSize.rawValue, value: "14.0"),
            Properties(attr: Attributes.fontFamily.rawValue, value: "OpenSans-Regular"),
                
            ]
        
        driveHeader.image = ImagePropterties()
        driveHeader.image?.resource = "file-header"
        driveHeader.image?.tag = 12
        driveHeader.image?.properties = [
        Properties(attr: Attributes.contentMode.rawValue, value: "aspectFit"),
           
        ]
        driveHeader.properties = [
            Properties(attr: Attributes.margin.rawValue, value: "24,44,0,0")
        ]
        

        return driveHeader
    }
    
    func getFilesStorage()->FilesStorage{
        var driveStorage = FilesStorage(order:2)
        driveStorage.title = TextProperties()
        driveStorage.subtitle = TextProperties()
        driveStorage.progress = BarProperties()
        
        driveStorage.progress?.text = "40"
        driveStorage.progress?.tag = 22
        
        driveStorage.title?.text = "982 MB"
        driveStorage.title?.tag = 20
        driveStorage.subtitle?.text = "Free of 1GB"
        driveStorage.subtitle?.tag = 21
        driveStorage.title?.properties = [
            Properties(attr: Attributes.textColor.rawValue, value: "#FFfFFFFF"),
            
            Properties(attr: Attributes.fontSize.rawValue, value: "16.0"),
            
            Properties(attr: Attributes.topPadding.rawValue, value: "15.0"),
            Properties(attr: Attributes.fontFamily.rawValue, value: "OpenSans-Bold"),
        ]
        
        driveStorage.subtitle?.properties = [
            Properties(attr: Attributes.textColor.rawValue, value: "#FFFFFFCC"),
            Properties(attr: Attributes.fontSize.rawValue, value: "15.0"),
            
            Properties(attr: Attributes.topPadding.rawValue, value: "15.0"),
            Properties(attr: Attributes.fontFamily.rawValue, value: "OpenSans-SemiBold"),
           
        ]
        
        driveStorage.progress?.properties = [
            Properties(attr: Attributes.backgroundColor.rawValue, value: "#000000FF"),
            //Properties(attr: Attributes.width.rawValue, value: "295"),
            Properties(attr: Attributes.height.rawValue, value: "4")
            
            
        ]
        
        driveStorage.properties = [
            Properties(attr: Attributes.margin.rawValue, value: "24,0,0,10")
        ]
        
        
        
        return driveStorage
    }

    func getFilesSearch()->FilesSearch{
        var driveSearch = FilesSearch(order:3, searchHeight:60.0,containerWidth:self.view.frame.width+12)
        driveSearch.icon = ImagePropterties()
        driveSearch.title = TextProperties()
        driveSearch.tag = 30
        driveSearch.title?.text = "search for documents"
        
        driveSearch.title?.properties = [
            Properties(attr: Attributes.textColor.rawValue, value: "#FFFFFFCC"),
            Properties(attr: Attributes.fontSize.rawValue, value: "16.0"),
            Properties(attr: Attributes.fontFamily.rawValue, value: "OpenSans-Bold"),
           
        ]
        driveSearch.icon?.resource = "user"
        
        driveSearch.properties = [
           Properties(attr: Attributes.leftRightMargin.rawValue, value: "24"),
            Properties(attr: Attributes.backgroundColor.rawValue, value: "#FFFFFFFF"),
        ]
        return driveSearch
    }
    
    
    func getNewDriveFolders()->FoldersContainer{
        var driveFoldersContainer = FoldersContainer(order: 4)
        driveFoldersContainer.title = TextProperties()
        driveFoldersContainer.title?.tag = 40
        driveFoldersContainer.horizontalBar = ScrollBarProperties(tag:41)
        driveFoldersContainer.title?.text = "Folders"
        driveFoldersContainer.title?.properties = [
            Properties(attr: Attributes.textColor.rawValue, value: "#000000FF"),
            
            Properties(attr: Attributes.fontSize.rawValue, value: "16.0"),
            Properties(attr: Attributes.fontFamily.rawValue, value: "OpenSans-Bold"),
            Properties(attr: Attributes.topPadding.rawValue, value: "15.0"),
            Properties(attr: Attributes.bottomPadding.rawValue, value: "5.0")
        ]
       
        driveFoldersContainer.horizontalBar?.itemProperties = [
            Properties(attr: Attributes.width.rawValue, value: "104"),
            Properties(attr: Attributes.height.rawValue, value: "104")
        ]
        
        driveFoldersContainer.horizontalBar?.image = ImagePropterties()
        driveFoldersContainer.horizontalBar?.image?.properties = [
            Properties(attr: Attributes.backgroundColor.rawValue, value: "#OOOOOOFF"),
            Properties(attr: Attributes.width.rawValue, value: "40.0"),
            
        ]
        
        driveFoldersContainer.horizontalBar?.title = TextProperties()
        driveFoldersContainer.horizontalBar?.title?.properties = [
            Properties(attr: Attributes.height.rawValue, value: "20"),
            Properties(attr: Attributes.fontSize.rawValue, value: "12"),
            Properties(attr: Attributes.fontFamily.rawValue, value: "OpenSans-SemiBold"),
            Properties(attr: Attributes.textAlignment.rawValue, value: "center"),
            Properties(attr: Attributes.topPadding.rawValue, value:"8")
        ]
        
        driveFoldersContainer.horizontalBar?.properties  = [
            Properties(attr: Attributes.width.rawValue, value: "104"),
            Properties(attr: Attributes.height.rawValue, value: "104")
        ]
        
        
        
        driveFoldersContainer.properties = [
           
            Properties(attr: Attributes.backgroundColor.rawValue, value: "#FFFFFFFF"),
            Properties(attr: Attributes.leftMargin.rawValue, value: "24"),
           
        ]
        return driveFoldersContainer
    }
    
    
    func getDriveFiles()->FilesContainer{
        var filesContainer = FilesContainer(order: 4)
        filesContainer.tag = 50
        filesContainer.title = TextProperties()
        filesContainer.title?.tag = 51
        filesContainer.fileTitle = TextProperties()
        filesContainer.fileTitle?.tag = 52
        filesContainer.fileSubtitle = TextProperties()
        filesContainer.fileSubtitle?.tag = 53
        filesContainer.fileImage = ImagePropterties()
        filesContainer.fileImage?.tag = 54
        
        filesContainer.title?.text = "Files"
        filesContainer.title?.properties = [
            Properties(attr: Attributes.textColor.rawValue, value: "#000000FF"),
            
            Properties(attr: Attributes.fontSize.rawValue, value: "16.0"),
            Properties(attr: Attributes.fontFamily.rawValue, value: "OpenSans-Bold"),
            Properties(attr: Attributes.topPadding.rawValue, value: "15.0"),
            Properties(attr: Attributes.bottomPadding.rawValue, value: "5.0")
         
        ]
       
        
        filesContainer.properties = [
            Properties(attr: Attributes.backgroundColor.rawValue, value: "#FFFFFFFF"),
            Properties(attr: Attributes.leftMargin.rawValue, value:"24")
        ]
        return filesContainer
    }
}


