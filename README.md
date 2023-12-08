# The Universities API (On development project)
Welcome to the Universities API project! This API is designed to facilitate the retrieval and addition of university data through a web crawler and API integration. The project consists of two main parts: the Web Crawler and the API.

## Web Crawler
The Web Crawler is responsible for searching and collecting data about universities from the web. It gathers information and metadata about universities, which is later used to populate the database through the API.

## API
The API exposes GET and POST endpoints, allowing users to retrieve existing university data and add new information to the database.

## Endpoints
GET /colleges: Retrieve a list of universities from the database.
POST /colleges: Add new university data to the database.
These endpoints work seamlessly with the data collected by the Web Crawler, enabling a comprehensive search-and-add functionality for university information.

## Tooling
To streamline the process of sending data from the Web Crawler to the API, we have integrated the [PokeGelo-CLI](https://github.com/Gabriel-Spinola/PokeGelo-CLI) tool. It simplifies the HTTP request process by constructing requests using metadata obtained from the Web Crawler. This allows for efficient and automated communication between the crawler and the Uni-API.

## How it Works
The Web Crawler searches for university data on the web and outputs metadata.
PokeGelo-CLI reads the metadata and constructs an HTTP request body.
The constructed request is sent to the Uni-API's POST endpoint, adding the university data to the database.

### TODO: 
- [X] Postgres Database (Notes: on docker)
- [X] Get colleges endpoint
- [X] Basics search spiders
- [X] Post endpoint
- [ ] Better spiders implementation
- [ ] Store colleges data into database
- [ ] Deploy
- [ ] Descripte process with poke-cli
