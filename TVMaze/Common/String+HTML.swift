//
//  String+HTML.swift
//  TVMaze
//
//  Created by Isaac Olmedo on 22/08/21.
//

import Foundation


extension String {
    var htmlToAttributedString: NSMutableAttributedString {
        guard let data = data(using: .utf8) else { return NSMutableAttributedString() }
        do {
            return try NSMutableAttributedString(data: data,
                                          options: [.documentType: NSMutableAttributedString.DocumentType.html,
                                                    .characterEncoding: String.Encoding.utf8.rawValue],
                                          documentAttributes: nil)
        } catch let error as NSError {
            print(error.localizedDescription)
            return  NSMutableAttributedString()
        }
     }
}
