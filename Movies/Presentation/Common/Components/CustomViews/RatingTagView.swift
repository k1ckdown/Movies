//
//  RatingTagView.swift
//  Movies
//
//  Created by Ivan Semenov on 28.10.2023.
//

import SwiftUI

struct RatingTagView: View {

    enum Size {
        case small
        case medium
    }

    enum Style: Equatable {
        case titleOnly(Size)
        case titleAndIcon

        var fontWeight: Font.Weight {
            switch self {
            case .titleOnly:
                return .semibold
            case .titleAndIcon:
                return .medium
            }
        }

        var cornerRadius: CGFloat {
            switch self {
            case .titleOnly: Constants.TitleOnly.cornerRadius
            case .titleAndIcon: Constants.TitleAndIcon.cornerRadius
            }
        }

        var textColor: Color {
            switch self {
            case .titleOnly(.small):
                return .black
            case .titleAndIcon, .titleOnly(.medium):
                return .white
            }
        }

        var width: CGFloat {
            switch self {
            case .titleAndIcon:
                return Constants.TitleAndIcon.width
            case .titleOnly(let size):
                return size == .small
                ? Constants.TitleOnly.Width.small
                : Constants.TitleOnly.Width.medium
            }
        }

        var height: CGFloat {
            switch self {
            case .titleAndIcon:
                return Constants.TitleAndIcon.height
            case .titleOnly(let size):
                return size == .small
                ? Constants.TitleOnly.Height.small
                : Constants.TitleOnly.Height.medium
            }
        }
    }

    let style: Style
    let value: Double

    var body: some View {
        HStack(spacing: Constants.contentSpacing) {
            if case .titleAndIcon = style {
                Image(systemName: Constants.imageName)
                    .imageScale(.small)
            }
            Text(style == .titleAndIcon ? "\(Int(value))" : "\(String(format:"%.1f", value))")
        }
        .fontWeight(style.fontWeight)
        .foregroundStyle(style.textColor)
        .frame(width: style.width, height: style.height)
        .background(backgroundColor)
        .clipShape(.rect(cornerRadius: style.cornerRadius))
    }

    private var backgroundColor: Color {
        switch value {
        case 0...2: .appRed
        case 3: .appOrangeFire
        case 4...5: .appOrange
        case 6...7: .appYellow
        case 8: .appGreenLight
        case 9...10: .appGreen
        default: .secondary
        }
    }

    private enum Constants {
        static let imageName = "star.fill"
        static let contentSpacing: CGFloat = 3

        enum TitleAndIcon {
            static let width: CGFloat = 44
            static let height: CGFloat = 32
            static let cornerRadius: CGFloat = 17
        }

        enum TitleOnly {
            static let cornerRadius: CGFloat = 7

            enum Width {
                static let small: CGFloat = 45
                static let medium: CGFloat = 64
            }

            enum Height {
                static let small: CGFloat = 25
                static let medium: CGFloat = 32
            }
        }
    }
}
