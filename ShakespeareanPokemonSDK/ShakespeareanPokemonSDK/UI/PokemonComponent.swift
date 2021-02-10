//
//  PokemonView.swift
//  ShakespeareanPokemonSDK
//
//  Created by daniele salvioni on 07/02/21.
//

import UIKit

extension NetworkService: ImageDownloaderProtocol {}

public struct PokemonComponent {
    let imageDownloader: ImageDownloaderProtocol
    public let view = View()
    
    public init(imageDownloader: ImageDownloaderProtocol = NetworkService()) {
        self.imageDownloader = imageDownloader
    }
}

extension PokemonComponent {
    public struct Model {
        public let text: String
        public let sprite: URL

        public init(text: String, sprite: URL) {
            self.text = text
            self.sprite = sprite
        }
    }

    public class View: UIView {
        let containerStackView = UIStackView()
        let textLabel = UILabel()
        let spriteView = UIImageView()

        @available(iOS, unavailable, message: "init(coder:) is unavailable, use init() instead")
        public required init?(coder _: NSCoder) { fatalError() }

        @available(iOS, unavailable, message: "init(frame:) is unavailable, use init() instead")
        override init(frame _: CGRect) { fatalError() }

        public init() {
            super.init(frame: .zero)
            self.setupUI()
        }

        private func setupUI() {
            [self.containerStackView, self.spriteView, self.textLabel].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
            
            self.containerStackView.axis = .vertical
            self.containerStackView.spacing = 20

            self.spriteView.contentMode = .scaleAspectFit
            self.spriteView.clipsToBounds = true

            self.textLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
            self.textLabel.numberOfLines = 0

            [self.spriteView, self.textLabel].forEach(self.containerStackView.addArrangedSubview)

            self.addSubview(self.containerStackView)

            self.topAnchor.constraint(equalTo: self.containerStackView.topAnchor).isActive = true
            self.bottomAnchor.constraint(equalTo: self.containerStackView.bottomAnchor).isActive = true
            self.leadingAnchor.constraint(equalTo: self.containerStackView.leadingAnchor).isActive = true
            self.trailingAnchor.constraint(equalTo: self.containerStackView.trailingAnchor).isActive = true
        }
    }
    
    public func update(model: Model) {
        self.view.textLabel.text = model.text
        self.imageDownloader.dataTask(url: model.sprite) { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.view.spriteView.image = UIImage(data: data)
                }
            case .failure(_):
                break
            }
        }
    }
}
