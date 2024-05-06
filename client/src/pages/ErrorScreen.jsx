import { Component } from 'react';
import PropTypes from 'prop-types';
import { Link, useRouteError } from 'react-router-dom';
import notFound from '../assets/not-found.svg';

function withRouter(Component) {
  function ComponentWithRouterProp(props) {
    const error = useRouteError();

    return <Component {...props} error={error} />;
  }

  return ComponentWithRouterProp;
}

class ErrorScreen extends Component {
  render() {
    const { error } = this.props;

    return (
      <main className="flex flex-col items-center justify-center h-screen">
        <img src={notFound} alt="not found" className="w-64 mb-6" />

        <h1 className="heading-h1">
          {error?.status === 404 ? 'Page not found' : 'Something went wrong'}
        </h1>

        <Link to="/" className="btn-cta">
          Back home
        </Link>
      </main>
    );
  }
}

ErrorScreen.propTypes = {
  error: PropTypes.shape({
    status: PropTypes.number.isRequired,
  }),
};

export default withRouter(ErrorScreen);
