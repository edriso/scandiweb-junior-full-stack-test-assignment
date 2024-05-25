# Scandiweb Assignment

Welcome to my repository for the Scandiweb Junior Fullstack Test Assignment. This web application is built using the following technologies:

- **Backend**: PHP, MySQL, GraphQL
- **Frontend**: React.js, Apollo Client, TailwindCSS
- **Utilities**: phpdotenv, react-toastify, dompurify, html-react-parser

## Table of Contents

- [Scandiweb Assignment](#scandiweb-assignment)
  - [Table of Contents](#table-of-contents)
  - [Overview](#overview)
  - [Prerequisites](#prerequisites)
  - [Getting Started](#getting-started)
  - [Project Structure](#project-structure)
  - [Learnings](#learnings)
    - [Importance of Sanitizing HTML Content:](#importance-of-sanitizing-html-content)

## Overview

This application provides a simple eCommerce platform featuring product listings and cart functionality. It includes two main pages:

1. **Product Listing Pages (Categories)**

   - Displays a list of products within a selected category.
   - Serves as the default view of the website, showcasing the first category upon initial load.

2. **Product Details Page (PDP)**
   - Shows detailed information about a selected product, including images and descriptions.
   - Allows users to configure their product options before adding the item to the cart.
   - Features an "Add to Cart" button for seamless shopping.

[Preview the app in 70 seconds!](https://youtu.be/TffBoZ-2fek)

<!-- **[Task Details](https://scandiweb.notion.site/Junior-Full-Stack-Developer-test-task-3833494124714845b71bf46096b6eeb9)** -->

## Prerequisites

Before you begin, ensure you have the following software installed on your system to run the project successfully:

- [PHP](https://www.php.net/) (Hypertext Preprocessor)
- [MySQL](https://www.mysql.com/) (or any other compatible relational database)
- [Composer](https://getcomposer.org/) (Dependency Manager for PHP)
- [NPM](https://nodejs.org/en/download) (Node Package Manager needed for Reactjs)

## Getting Started

To get started, follow these steps:

1. **Clone the Repository:**

   ```bash
   git clone https://github.com/edriso/scandiweb-junior-full-stack-test-assignment.git
   ```

2. **Navigate to the Project Directory:**

   ```bash
   cd scandiweb-junior-full-stack-test-assignment
   ```

3. **Install Dependencies:**

   ```bash
   composer install
   cd client && npm install
   ```

4. **Configure Environment:**

   - Rename the `.env.example` file in the root directory to `.env` and update the necessary variables.

   ```bash
    mv .env.example .env
   ```

5. **Database Setup:**

   - Create a database with the same name specified in `.env` (default is `scandiweb_ecommerce_task`).
   - Run the SQL script found in `schema.sql` file in the root directory to create the required tables with appropriate schema and relations.

6. **Serve or Build the Frontend:**

   ```bash
   cd client/

   # For development:
   npm run dev

   # For production:
   npm run build
   ```

7. **Run the Start Script with No Timeout:**
   ```bash
   composer run-script start --timeout=0
   ```

## Project Structure

The project structure is designed to maintain clarity and organization. Here's a brief overview of the key directories:

- **client/**: This directory houses the ReactJS frontend, where the user interface is developed and managed. All frontend-related assets and components are neatly organized within this section.

  - **assets/**: Contains static assets like styles and images, ensuring that all visual elements are easily accessible and well-organized.

  - **components/**: Contains reusable React components that form the building blocks of the user interface. These components are designed to be modular and reusable across different parts of the application.

  - **pages/**: Houses different page components that represent various views of the application (e.g., product listing, product details).

  - **graphql/**: Manages the Apollo Client setup for handling GraphQL queries and mutations. This includes configuration files and query/mutation definitions to interact with the backend efficiently.

  - **DataContext.jsx**: Defines the data context for the application. This context is used to share data and state across different components without prop drilling, making state management more efficient.

  - **router.jsx**: Contains the app routes and routing logic. This file defines how different URLs map to specific components, enabling smooth navigation throughout the application.

- **src/**: Houses the PHP backend code, containing the essential server-side logic that powers the application. It's further structured for improved organization:

  - **config/**: Contains configuration files that return the configuration settings necessary for the application.

  - **GraphQL/**: Manages the GraphQL setup.

  - **Models/**: Contains the models associated with the application. These models represent the underlying data structures and business logic.

  - **Database.php**: Class responsible for managing the database connection, providing methods to connect and interact with the database.

  - **helpers.php**: A file for simple helper functions.

- **public/**: Serves as the hosting location for index.php and the compiled front end, ensuring accessibility for users.

- **.env.example**: Example environment configuration file. Copy this to `.env` and update with your specific configuration settings.

- **schema.sql**: SQL script for setting up the database schema. It includes the necessary table definitions and relations required by the application.

## Learnings

- DOMPurify package used to sanitize HTML content of product description and prevent XSS attacks.
- html-react-parser package used to parse the sanitized HTML content into React elements. It takes raw HTML content as input and outputs React elements that can be rendered within a React component.

### Importance of Sanitizing HTML Content:

(Credits: [HTML React Parser Issue #94](https://github.com/remarkablemark/html-react-parser/issues/94#issuecomment-472423965))

```javascript
// Example HTML content susceptible to XSS attacks
const html = 'hey<iframe src=javascript:alert("xss")></iframe>';

// Parse HTML content without sanitization (unsafe)
const element = parse(html);

// Parse sanitized HTML content using DOMPurify
const element = parse(DOMPurify.sanitize(html));

// Render parsed React elements: {element}
```
