//
//  AppFactory.swift
//  Movies
//
//  Created by Ivan Semenov on 26.10.2023.
//

import Foundation

final class AppFactory {
    private lazy var secureStorage = SecureStorage()
    private lazy var networkService = NetworkService()
    private lazy var authRepository = AuthRepository(networkService: networkService)
    private lazy var movieRepository = MovieRepository(networkService: networkService)
    private lazy var profileRepository = ProfileRepository(networkService: networkService)
}

extension AppFactory {

    func makeValidateEmailUseCase() -> ValidateEmailUseCase {
        ValidateEmailUseCase()
    }

    func makeValidateUsernameUseCase() -> ValidateUsernameUseCase {
        ValidateUsernameUseCase()
    }

    func makeValidatePasswordUseCase() -> ValidatePasswordUseCase {
        ValidatePasswordUseCase()
    }

    func makeGetProfileUseCase() -> GetProfileUseCase {
        GetProfileUseCase(profileRepository: profileRepository)
    }

    func makeUpdateProfileUseCase() -> UpdateProfileUseCase {
        UpdateProfileUseCase(
            secureStorage: secureStorage,
            profileRepository: profileRepository
        )
    }

    func makeLoginUseCase() -> LoginUseCase {
        LoginUseCase(
            secureStorage: secureStorage,
            authRepository: authRepository,
            profileRepository: profileRepository
        )
    }

    func makeRegisterUserUseCase() -> RegisterUserUseCase {
        RegisterUserUseCase(
            secureStorage: secureStorage,
            authRepository: authRepository,
            profileRepository: profileRepository
        )
    }

    func makeGetDetailsFromMoviesUseCase() -> GetDetailsFromMoviesUseCase {
        GetDetailsFromMoviesUseCase(
            movieRepository: movieRepository,
            profileRepository: profileRepository
        )
    }

    func makeAddFavouriteMovieUseCase() -> AddFavouriteMovieUseCase {
        AddFavouriteMovieUseCase(
            movieRepository: movieRepository,
            secureStorage: secureStorage
        )
    }

    func makeFetchMoviesUseCase() -> FetchMoviesUseCase {
        FetchMoviesUseCase(
            movieRepository: movieRepository,
            getDetailsFromMovies: makeGetDetailsFromMoviesUseCase()
        )
    }

    func makeFetchFavoriteMoviesUseCase() -> FetchFavoriteMoviesUseCase {
        FetchFavoriteMoviesUseCase(
            secureStorage: secureStorage,
            movieRepository: movieRepository,
            getDetailsFromMoviesUseCase: makeGetDetailsFromMoviesUseCase()
        )
    }
}
