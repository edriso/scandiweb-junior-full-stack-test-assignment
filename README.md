# scandiweb-junior-full-stack-test-assignment

### Learnings

- Utilized DOMPurify library to sanitize HTML content and prevent XSS attacks.
- Employed html-react-parser to parse the sanitized HTML content into React elements. It takes raw HTML content as input and outputs React elements that can be rendered within a React component.

#### Example:

Credits: [HTML React Parser Issue #94](https://github.com/remarkablemark/html-react-parser/issues/94#issuecomment-472423965)

```javascript
// Example HTML content susceptible to XSS attacks
const html = 'hey<iframe src=javascript:alert("xss")></iframe>';

// Parse HTML content without sanitization (unsafe)
const element = parse(html);

// Parse sanitized HTML content using DOMPurify
const element = parse(DOMPurify.sanitize(html));

// Render parsed React elements: {element}
```
