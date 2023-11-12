//
//  ReviewDialog.swift
//  Movies
//
//  Created by Ivan Semenov on 12.11.2023.
//

import SwiftUI

struct ReviewDialog: View {

    let saveTappedHandler: (ReviewDialogViewModel) -> Void
    let cancelTappedHandler: () -> Void

    @State private var viewModel: ReviewDialogViewModel

    init(
        viewModel: ReviewDialogViewModel,
        saveTappedHandler: @escaping (ReviewDialogViewModel) -> Void,
        cancelTappedHandler: @escaping () -> Void
    ) {
        _viewModel = .init(initialValue: viewModel)
        self.saveTappedHandler = saveTappedHandler
        self.cancelTappedHandler = cancelTappedHandler
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text(LocalizedKey.Review.leave)
                .font(.title2.bold())

            Spacer()

            VStack(alignment: .leading, spacing: Constants.TextEditor.spacing) {
                HStack(spacing: Constants.StarRating.spacing) {
                    ForEach(1...Constants.StarRating.max, id: \.self) { value in
                        let isSelected = value <= viewModel.rating

                        Button {
                            withAnimation(.interpolatingSpring) {
                                viewModel.rating = value
                            }
                        } label: {
                            Image(
                                systemName: isSelected
                                ? Constants.StarRating.starFill
                                : Constants.StarRating.star
                            )
                            .foregroundStyle(isSelected ? .yellow : .appGray)
                        }
                    }
                    .imageScale(.large)
                }

                TextEditor(text: $viewModel.text)
                    .tint(.appAccent)
                    .frame(height: Constants.TextEditor.height)
                    .clipShape(.rect(cornerRadius: Constants.TextEditor.cornerRadius))
                    .padding(.horizontal, Constants.TextEditor.horizontalInsets)
                    .scrollContentBackground(.hidden)
                    .overlay {
                        RoundedRectangle(cornerRadius: Constants.TextEditor.cornerRadius)
                            .stroke(Color.appGray)
                    }

                HStack {
                    Button {
                        viewModel.isAnonymous.toggle()
                    } label: {
                        Image(systemName: Constants.Content.checkmarkName)
                            .foregroundStyle(.white, viewModel.isAnonymous ? .appAccent : .white)
                            .imageScale(.large)
                            .bold()
                    }

                    Text(LocalizedKey.Review.anonymous)
                        .font(.callout.weight(.medium))
                }
            }
            .padding(.bottom)

            Spacer()

            VStack {
                Button(LocalizedKey.Profile.save) {
                    saveTappedHandler(viewModel)
                }
                .baseButtonStyle()
                .disabled(viewModel.text.isEmpty)

                Button(LocalizedKey.Profile.cancel) {
                    cancelTappedHandler()
                }
                .baseButtonStyle(isProminent: false)
            }
        }
        .padding()
        .appBackground()
        .frame(height: Constants.Content.height)
        .clipShape(.rect(cornerRadius: Constants.Content.cornerRadius))
    }

//    private var reviewText: Binding<String> {
//        Binding(
//            get: { viewModel.text },
//            set: { viewModel.text = $0 }
//        )
//    }

    private enum Constants {
        enum StarRating {
            static let max = 10
            static let star = "star"
            static let starFill = "star.fill"
            static let spacing: CGFloat = 5
        }

        enum TextEditor {
            static let spacing: CGFloat = 12
            static let height: CGFloat = 110
            static let cornerRadius: CGFloat = 5
            static let horizontalInsets: CGFloat = 6
        }

        enum Content {
            static let height: CGFloat = 380
            static let cornerRadius: CGFloat = 10
            static let checkmarkName = "checkmark.square.fill"
        }
    }
}
