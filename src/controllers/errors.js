// Import any needed model functions (none are needed for the error pages, so this is empty)

// Define any controller functions

// Test route for 500 errors
const testErrorPage = (req, res, next) => {
  const err = new Error('This is a test error');
  err.status = 500;
  next(err);
};

const notFoundHandler = (req, res, next) => {
  const err = new Error('Page Not Found');
  err.status = 404;
  next(err);
};

const errorHandler = (err, req, res, next) => {
  console.error('Error occurred:', err.message);
  console.error('Stack trace:', err.stack);

  const status = err.status || 500;
  const template = status === 404 ? '404' : '500';

  const context = {
    title: status === 404 ? 'Page Not Found' : 'Server Error',
    error: err.message,
    stack: err.stack,
  };

  res.status(status).render(`errors/${template}`, context);
};

// Export any controller functions
export { testErrorPage, notFoundHandler, errorHandler };
