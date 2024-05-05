import { Link, useRouteError } from 'react-router-dom';
import notFound from '../assets/not-found.svg';

function ErrorScreen() {
  const error = useRouteError();

  return (
    <main className="flex flex-col items-center justify-center h-screen">
      <img src={notFound} alt="not found" className="w-64 mb-6" />

      <h2 className="text-heading">
        {error.status === 404 ? 'Page not found' : 'Something went wrong'}
      </h2>

      <Link to="/" className="cta">
        Back home
      </Link>
    </main>
  );
}

export default ErrorScreen;
