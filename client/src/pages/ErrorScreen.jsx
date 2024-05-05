import { Link, useRouteError } from 'react-router-dom';
import notFound from '../assets/not-found.svg';

function ErrorScreen() {
  const error = useRouteError();

  return (
    <main className="flex flex-col items-center justify-center h-screen">
      <img src={notFound} alt="not found" className="w-64 mb-6" />

      <h1 className="heading-h1">
        {error.status === 404 ? 'Page not found' : 'Something went wrong'}
      </h1>

      <Link to="/" className="btn-cta">
        Back home
      </Link>
    </main>
  );
}

export default ErrorScreen;
