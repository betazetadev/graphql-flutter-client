# Flutter GraphQL App with Hasura Tutorial

This project was created for a tutorial on how to build a Flutter application that consumes a GraphQL API using Hasura. The application demonstrates how to fetch, insert, update, and delete data from the API in a clean and efficient way.

## Table of Contents

- [Overview](#overview)
- [Requirements](#requirements)
- [Installation](#installation)
- [License](#license)

## Overview

This project covers the following topics:

- Setting up Hasura and configuring a PostgreSQL database
- Creating GraphQL queries, mutations, and subscriptions
- Integrating GraphQL in a Flutter application using `graphql_flutter`
- Building a simple CRUD application that interacts with the API

## Requirements

- Flutter SDK (v2.5.0 or later)
- Android Studio or Visual Studio Code with Flutter and Dart plugins
- Docker (for Hasura and PostgreSQL setup)
- A code editor, such as VSCode or Android Studio
- An internet connection to access the Hasura Console

## Installation

1. Clone the repository:

```bash
git clone https://github.com/yourusername/flutter-graphql-hasura-tutorial.git
```

2. Change into the project directory:

```bash
cd flutter-graphql-hasura-tutorial
```

3. Install the dependencies:

```bash
flutter pub get
```

4. Run the Docker container with Hasura and the PostgreSQL database:

```bash
docker-compose up -d
```

## License

This project is licensed under the MIT License. See the LICENSE file for more information.