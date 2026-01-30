# Contributing Guide

Thank you for contributing to this project! Please follow these guidelines to ensure consistency and quality.

## Code Standards

- **Formatting**: All Terraform files must be formatted using `terraform fmt`.
    ```bash
    cd infrastructure
    terraform fmt -recursive
    ```
- **Naming Conventions**: Use `snake_case` for all resource names and variables.
- **Descriptions**: All variables and outputs must have a `description` field.
- **Version Pinning**: Providers should have version constraints in `provider.tf`.

## Development Workflow

1.  **Branching**: Create a new branch for each feature or fix.
    ```bash
    git checkout -b feature/my-new-feature
    ```
2.  **Commit Messages**: Write clear, descriptive commit messages.
3.  **Pull Requests**: detailed description of changes and verification steps.

## Tools

Recommended tools for local development:
- **TFLint**: A Pluggable Terraform Linter.
- **tfsec**: Static analysis security scanner.
- **VS Code Terraform Extension**: For syntax highlighting and autocomplete.
