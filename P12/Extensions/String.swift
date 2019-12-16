

import Foundation

extension String{
    /// Transform string url to data
    var data: Data? {
        guard let url = URL(string: self) else{return nil}
        guard let data = try? Data(contentsOf: url) else {return nil}
        return data
    }
}
