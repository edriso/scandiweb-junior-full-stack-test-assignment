# Scandiweb's junior Fullstack test assignment

### Learnings

- DOMPurify package used to sanitize HTML content of product description and prevent XSS attacks.
- html-react-parser package used to parse the sanitized HTML content into React elements. It takes raw HTML content as input and outputs React elements that can be rendered within a React component.

  #### Importance of Sanitizing HTML Content:

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
