# json_search

**json_search** is a command-line Ruby gem that allows the user to search through a specified JSON dataset and detect duplicate email entries. It defaults to using `data/client.json` if no file is specified.

The gem is designed using clean, DRY, and object-oriented principles, and its modular structure makes it easy to extend—for example, to support dynamic search fields or a REST API in the future.

## Design Notes

- **Abstraction with `Record`:**
  The gem uses a generic `Record` class to wrap JSON objects. This abstraction decouples the code from any specific domain (such as "Client"), allowing the tool to work with any JSON file containing an array of objects.

- **Search Performance:**
  The current search functionality of this gem has a time complexity of `O(n)` (n = number of records), which is efficient for simple, one-off searches.

  For frequent prefix searches on large datasets, a **trie (prefix tree)** could reduce the time complexity to `O(m)` (m = length of the prefix) combined with a caching solution like **Redis** (`o(1)` for cached results) but at the cost of additional complexity which is not required by the project.

## Features

- **Search Records:** Filter records by a partial match on the `full_name` field.
- **Find Duplicates:** Detect duplicate `email` entries among the records.
- **Default File:** If no file is specified, the CLI defaults to `data/client.json`.

## Requirements

- Ruby (tested on Ruby 3.3.5, but should work with Ruby 2.7+)
- Bundler

## Installation

1. Clone the repository and install dependencies:
   ```bash
   git clone git@github.com:jibril-tapiador/json_search.git
   cd json_search
   bundle install
   ```

2. Build the gem:
   ```bash
   gem build json_search.gemspec
   ```

3. Install the gem locally:
   ```bash
   gem install ./json_search-1.0.0.gem
   ```

## Usage

Once installed, you can use the gem’s CLI as follows:

```
Usage: json_search [options]

    -f, --file FILE                  Path to the JSON file (default: data/clients.json)
    -s, --search QUERY               Search records by full_name
    -d, --duplicates                 Find records with duplicate emails
    -h, --help                       Show help message
```

### Search Mode

Search for records where the `full_name` field contains a specific query:

```bash
json_search -s "John"
```

To specify a custom JSON file, use the `-f` flag:

```bash
json_search -f path/to/yourfile.json -s "John"
```

### Duplicate Mode

Find duplicate email entries:

```bash
json_search -d
```

Or specify a file:

```bash
json_search -f path/to/yourfile.json -d
```

### Help

Display the help message with:

```bash
json_search -h
```

## Development and Testing

During development, you can run the test suite using RSpec:

```bash
bundle exec rspec
```

## Assumptions

- **Search Field:**
  For now, the search function looks only at the `"full_name"` field, as specified by the project requirements. This can easily be extended to let users choose which field to search.

- **Duplicate Detection:**
  The app identifies duplicates solely by the `"email"` field. This meets the current requirements, though later we could extend this to include other fields if needed.

- **Dataset Size and Performance:**
  We assume the JSON file will be of a size where a simple linear search (`O(n)`) is sufficient. If the data grows much larger or searches become more  frequent, we might need a more efficient data structure—like a **trie** for prefix searches combined with a caching solution like **Redis**.

  Alternatively and ideally, integrating an RDBMS like PostgreSQL can offer a strong, scalable solution for managing and querying large data.

- **Extensibility:**
  The design is modular and loosely coupled, making it easy to extend with new features.

## Contact

If you have any questions or need further clarification about this project, please feel free to reach out.

**Email:** [tapiador@jib.is](mailto:tapiador@jib.is)
