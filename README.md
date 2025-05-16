# 🤖 Robot Full Stack Test Framework

This repository contains a **modular, full-stack test automation framework** built using [Robot Framework](https://robotframework.org/) and integrated with:

- ✅ **Selenium** for UI testing
- 🔍 **Applitools Eyes** for visual (UX) testing
- 🔌 **Requests Library** for API testing
- 🧪 **JMeter** for performance testing
- 🗄️ **PostgreSQL** for backend DB validation
- ⚙️ **GitHub Actions** for CI/CD pipeline execution
- 🧹 **Robocop** for static code analysis of Robot Framework files
- 📝 **Robotframework-tidy** for reformatting `.robot` files
- 🐍 **Pylint** for Python custom library code linting

---

## 🎯 Objective

The goal of this project is to enable **end-to-end automated testing** across all application layers — **API, UI, DB, UX, and performance** — using Robot Framework in a scalable and CI-friendly structure.

Additionally, it enforces **code quality checks** using **Robocop**, **robotframework-tidy**, and **Pylint** to ensure that the codebase remains clean, consistent, and easily maintainable.

---

### 1. ✅ Install Dependencies
###### pip install -r requirements.txt

### 2. 🧪 Run Tests Locally
#### UI tests
###### robot ui/tests/

#### API tests
###### robot api/tests/

#### DB tests
###### robot db/tests/

#### UX tests (Applitools)
###### robot ux/tests/

#### 3. 📊 Run Performance Tests
###### cd performance
###### jmeter -n -t jmeter/login_test.jmx -l results/report.jtl

## 🗂️ Folder Structure Overview

```text
.
├── .github/workflows/          # GitHub Actions workflows for CI/CD
│   └── ci.yml                  # CI pipeline configuration
├── api/                        # API testing with RequestsLibrary
│   ├── tests/                  # Test cases for REST APIs
│   ├── keywords/               # Custom API-related keywords
│   └── resources/              # Headers, endpoints, and variables
├── db/                         # Database validation using PostgreSQL
│   ├── tests/                  # DB test cases (e.g., data verification)
│   ├── keywords/               # Connection/query logic
│   └── resources/              # DB configs (host, port, creds)
├── performance/                # Performance testing layer
│   ├── jmeter/                 # JMeter test plans (.jmx)
│   └── run_tests.bat           # Script to execute JMeter tests
├── ui/                         # UI test automation using SeleniumLibrary
│   ├── tests/                  # UI test cases
│   ├── keywords/               # Custom actions (click, input, verify)
│   └── resources/              # Element locators (XPath, CSS)
├── ux/                         # Visual/UX testing using Applitools Eyes
│   ├── tests/                  # Visual test cases
│   ├── keywords/               # Applitools integration keywords
│   └── resources/              # Visual test configs/baselines
├── config/                     # Test environment and global configs
│   ├── environments/           # Environment-specific variables (dev, prod)
│   └── global_variables.robot  # Shared variables (timeouts, base URLs)
├── libs/                       # Python custom libraries (if needed)
│   └── db_library.py           # Custom library for DB connection
├── resources/                  # Common/shared Robot Framework keywords
│   └── common_keywords.robot  # Common reusable keywords
├── results/                    # Output logs, reports, screenshots
├── requirements.txt            # Python dependencies
├── .gitignore                  # Git ignored files (logs, venv, etc.)
└── README.md                   # Project overview and usage guide

---

