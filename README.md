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

- [Flutter](https://docs.flutter.dev/get-started/install) and [Dart](https://dart.dev/get-dart) SDK
- [Android Studio](https://developer.android.com/studio) or [Visual Studio Code](https://code.visualstudio.com/) with Flutter and Dart plugins
- [Docker](https://www.docker.com/) (for [Hasura](https://hasura.io/) and [PostgreSQL](https://www.postgresql.org/) setup)

## Installation

1. Clone the repository:

```bash
git clone https://codeberg.org/betazetadev/graphql-flutter-client.git
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

5. Import and create the database information using [this](https://github.com/morenoh149/postgresDBSamples/tree/master/pagila-0.10.1) files connecting to the virtualized database

6. Add a `code` column to the `language` table with the default value set to `gb` (they are used to show a flag next to the film information): 

| Language | Code |
| --- | --- |
| English | gb |
| Japanese | ja |
| Mandarin | ma |
| French | fr |
| German | ge |
| Italian | it |

## License

This project is licensed under the MIT License. See the LICENSE file for more information.