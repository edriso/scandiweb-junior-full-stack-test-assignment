import { Component } from 'react';
import { Outlet } from 'react-router-dom';
import { Navbar } from '../components';

class HomeLayout extends Component {
  render() {
    return (
      <>
        <Navbar />
        <Outlet />
      </>
    );
  }
}

export default HomeLayout;
