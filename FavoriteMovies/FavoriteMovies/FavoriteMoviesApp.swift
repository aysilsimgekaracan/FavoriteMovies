//
//  FavoriteMoviesApp.swift
//  FavoriteMovies
//
//  Created by Ayşıl Simge Karacan on 23.12.2025.
//

import SwiftUI

@main
struct FavoriteMoviesApp: App {

  init() {
    let appearance = UINavigationBarAppearance()
    appearance.configureWithOpaqueBackground()
    appearance.backgroundColor = UIColor(named: "background")
    appearance.titleTextAttributes = [.foregroundColor: UIColor.red]
    appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.red]

    UINavigationBar.appearance().standardAppearance = appearance
    UINavigationBar.appearance().scrollEdgeAppearance = appearance

    let toolbarAppearance = UIToolbarAppearance()
    toolbarAppearance.configureWithOpaqueBackground()
    toolbarAppearance.backgroundColor = UIColor.systemBackground

    UIToolbar.appearance().standardAppearance = toolbarAppearance

    if #available(iOS 15.0, *) {
        UIToolbar.appearance().scrollEdgeAppearance = toolbarAppearance
    }

    let scrollEdgeAppearance = UINavigationBarAppearance()
    scrollEdgeAppearance.configureWithTransparentBackground()
    scrollEdgeAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.red]

    UINavigationBar.appearance().scrollEdgeAppearance = scrollEdgeAppearance
  }

  var body: some Scene {
    WindowGroup {
      ContentView()
    }
  }
}
