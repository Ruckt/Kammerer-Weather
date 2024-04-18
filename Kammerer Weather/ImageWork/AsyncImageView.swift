//
//  AsyncImageView.swift
//  Kammerer Weather
//
//  Created by Lichtenstein, Edan on 4/17/24.
//

import SwiftUI

struct AsyncImageView: View {
    @ObservedObject var imageLoader: ImageLoader
    
    init(url: URL) {
        imageLoader = ImageLoader()
        imageLoader.load(url: url)
    }
    
    var body: some View {
        imageLoader.image?.resizable()
    }
}
