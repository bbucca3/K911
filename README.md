# K911

iOS Application to access [Petfinder.com](https://www.petfinder.com/) Pets and Shelters Search

## Team

  - Benjamin Bucca

## Table of Contents

1. [Usage](#Usage)
1. [Development](#Development)
1. [Pods](#Pods)
1. [Concept Screenshots](#concept-screenshots)

## Usage

- Search for pets and pet shelters via any 5 digit US zip code (search results are from [Petfinder.com API](https://www.petfinder.com/developers/api-docs)).

## Development

From within the root directory:

```sh
pod install
```

In order to use search functionality:

- Register for a Petfinder.com (free) API key [here](https://www.petfinder.com/developers/api-key).
- Create a new Swift file called `Petfinder.swift` under the API folder.
- Paste in your API key to `Petfinder.swift` (see `Example.swift` under API folder for format).

## Pods

- Alamofire
- SwiftyJSON

## Concept Screenshots

<img src="https://github.com/bbucca3/Canine11/blob/master/screenshots/HomeScreen1.png" width="150" height="300" alt="Home Screen"><img src="https://github.com/bbucca3/Canine11/blob/master/screenshots/SheltersScreen1.png" width="150" height="300" alt="Shelters Search Results Screen"><img src="https://github.com/bbucca3/Canine11/blob/master/screenshots/PetsScreen1.png" width="150" height="300" alt="Pets Screen"><img src="https://github.com/bbucca3/Canine11/blob/master/screenshots/PetDetailScreen1.png" width="150" height="300" alt="Pet Details Screen">
