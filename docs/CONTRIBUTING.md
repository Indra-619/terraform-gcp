# 🤝 Contributing Guide

![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=for-the-badge)

Thank you for your interest in contributing! We love seeing the community get involved.

## 📐 Code Standards

*   **Formatter**: We use `terraform fmt` to keep code clean.
    ```bash
    cd infrastructure
    terraform fmt -recursive
    ```
*   **Naming**: Use `snake_case` for all resources.
*   **Variables**: Always include a `description`.

## 🔄 Workflow

1.  **Fork** the repository.
2.  **Clone** your fork locally.
3.  **Branch** out for your feature:
    ```bash
    git checkout -b feature/amazing-feature
    ```
4.  **Commit** your changes with clear messages.
5.  **Push** to your fork and submit a **Pull Request**.

## 🛠️ Recommended Tools

| Tool | Description |
| :--- | :--- |
| **TFLint** | Find possible errors and best practices. |
| **tfsec** | Security scanner for your infrastructure. |
| **VS Code** | With the official Terraform extension. |

---

<p align="center">Happy Coding! 🚀</p>
