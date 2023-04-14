# Flutter GraphQL App with Hasura Tutorial

This project is a step-by-step tutorial on how to build a Flutter application that consumes a GraphQL API using Hasura. The application demonstrates how to fetch, insert, update, and delete data from the API in a clean and efficient way.

## Table of Contents

- [Overview](#overview)
- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)

## Overview

The tutorial covers the following topics:

- Setting up Hasura and configuring a PostgreSQL database
- Creating GraphQL queries, mutations, and subscriptions
- Integrating GraphQL in a Flutter application using `graphql_flutter`
- Building a simple CRUD application that interacts with the API
- Implementing real-time updates with GraphQL subscriptions

## Requirements

- Flutter SDK (v2.5.0 or later)
- Android Studio or Visual Studio Code with Flutter and Dart plugins
- Hasura CLI (v2.0.0 or later)
- Docker Desktop (for Hasura and PostgreSQL setup)
- A code editor, such as VSCode or Android Studio
- An internet connection to access the Hasura Console

## Installation

1. Clone the repository:

```bash
git clone https://github.com/yourusername/flutter-graphql-hasura-tutorial.git
```

2. Change into the project directory:

> cd flutter-graphql-hasura-tutorial

3. Install the dependencies:

> flutter pub get

4. Run the Docker container with Hasura and the PostgreSQL database:

> docker-compose up -d

## License

This project is licensed under the MIT License. See the LICENSE file for more information.