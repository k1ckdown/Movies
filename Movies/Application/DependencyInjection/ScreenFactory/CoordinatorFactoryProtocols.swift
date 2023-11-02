//
//  SceneScreenFactoryProtocols.swift
//  Movies
//
//  Created by Ivan Semenov on 26.10.2023.
//

import Foundation

@MainActor
protocol ProfileCoordinatorFactory: ProfileViewFactory {}

@MainActor
protocol AuthCoordinatorFactory: LoginViewFactory,
                                 WelcomeViewFactory,
                                 PasswordRegistrationViewFactory,
                                 PersonalInfoRegistrationViewFactory {}
