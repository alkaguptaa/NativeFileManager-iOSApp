//
//  FileObject.swift
//  FileManager
//
//  Created by Naveen Chauhan on 14/10/21.
//

import UIKit
import RealmSwift

class FileObject: Object {
    @Persisted var name:String
    @Persisted var id:String = UUID().uuidString
    @Persisted var Key_name : String
    @Persisted var human_size : String
    @Persisted var lastModified : String
    @Persisted var size : String
    @Persisted var ext : String
    @Persisted var isDirectory : Bool = false
    @Persisted var thumbnailImage : Data
}
