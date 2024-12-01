//
//  StringClassExtention.swift
//  Instagram_Clone
//
//  Created by Ziyad Qassem on 15/10/2024.
//

import Foundation
extension String {
    func createSafeDatabasekey() -> String{
        var st = self.replacingOccurrences(of: ".", with: "_")
        st = st.replacingOccurrences(of: "@", with: "_")
        return st
    }
}
