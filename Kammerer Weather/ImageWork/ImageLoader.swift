//
//  ImageLoader.swift
//  Kammerer Weather
//
//  Created by Lichtenstein, Edan on 4/17/24.
//

import SwiftUI
import Combine

class ImageLoader: ObservableObject {
    @Published var image: Image? = nil
    
    func load(url: URL) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error downloading image: \(error?.localizedDescription ?? "unknown error")")
                return
            }
            DispatchQueue.main.async {
                guard let uiImage = UIImage(data: data) else {
                    print("Error creating image from data")
                    return
                }
                self.image = Image(uiImage: uiImage)
            }
        }
        task.resume()
    }
}
