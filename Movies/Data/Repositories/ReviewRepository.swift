//
//  ReviewRepository.swift
//  Movies
//
//  Created by Ivan Semenov on 12.11.2023.
//

import Foundation

final class ReviewRepository {

    private let remoteDataSource: ReviewRemoteDataSource

    init(remoteDataSource: ReviewRemoteDataSource) {
        self.remoteDataSource = remoteDataSource
    }
}

extension ReviewRepository: ReviewRepositoryProtocol {

    func deleteReview(reviewId: String, movieId: String, token: String) async throws {
        try await remoteDataSource.deleteReview(token: token, movieId: movieId, reviewId: reviewId)
    }
    
    func addReview(_ review: ReviewModify, movieId: String, token: String) async throws {
        try await remoteDataSource.addReview(token: token, movieId: movieId, review: review)
    }
    
    func updateReview(
        _ review: ReviewModify,
        reviewId: String,
        movieId: String,
        token: String
    ) async throws {
        try await remoteDataSource.updateReview(
            token: token,
            movieId: movieId,
            reviewId: reviewId,
            review: review
        )
    }
}
