# Shakespearean Pokemon

## Description

This is a proposed solution for a Code Challenge about make a simple search app, that given a Pokemon name, returns its Shakespearean description. In addition to that, the user should be able to add individual Pokemons to a "Your Favourites" basket. If the user reopen the app, this information have to be still be present.
In order to reuse the core features of this application, The main business logic have to be extracted in an easily  integrable SDK.

## Features

The app consists in two main component, each one linked in a separated project, under same workspace. 
#### ShakespeareanPokemonSDK: 
represent the SDK with the core functionalities:
- an api that deliver a sprite representation of a given Pokemon
- an api that deliver the Shakespearean description of a given Pokemon
- a UI component with built-in label and UIImageView for render the two previous data

#### ShakespeareanPokemonApp
represent the sample App for show the SDK functionalities. The app itself its really simple: 
- the first screen (SearchVC) for show an input search and a button, necessary to perform a Pokemon name search
- the second screen (DetailVC) delivers the informations described before, and a switch allows to understand if the actual Pokemon searched its already inside "Your Favourites" basket or not.
The api functionality are provided by using:
- PokéAPI: https://pokeapi.co/
- Shakespeare translator: https://funtranslations.com/api/shakespeare

## Code Architecture

This app architecture its developed around MVVM + Coordinator pattern, with a dependency injections between all major components: 
- NetworkService, PokemonApiService, TranslationApiService, ShakespeareanTranslatorService and PokemonComponent for UI provided by SDK
- BookmarkService and the whole UI provided by the app.
Both Screens have a ViewController + ViewModel, with a shared Coordinator that manage the very basic workflow.
All the mains Unit Tests are already implemented, plus a series of Snapshot Testing for check the PokemonComponent UI.
There are no 3rd party libraries other than the one used for Snapshot Testing: https://github.com/pointfreeco/swift-snapshot-testing. The library is integrated using the Swift Package Manager

## Requirements

minimum ios version is 14.4 (default). Developed and tested using Xcode 12.4.

## Installation

Clone the repository, move to project directory and sync all dependencies.
For integrate SDK in another project simply move the ShakespeareanPokemonSDK project inside another workspace, and link framework generated in his Build phases/Link Binary.
You are free to put the SDK inside your favorite package manager, like Carthage, Cocoapods or Swift Package Manager. The only direct dependenjcy is the SnapshotTesting library.

## Author
Daniele99999999

## License

Shakespearean Pokemon is available under the MIT license. See the LICENSE file for more info.
