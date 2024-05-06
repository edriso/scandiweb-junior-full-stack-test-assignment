import { Component } from 'react';
import PropTypes from 'prop-types';
import CartModalItem from './CartModalItem';

class CartModal extends Component {
  render() {
    const { products = [] } = this.props;

    const totalPrice = products.reduce(
      (total, product) => total + product.prices[0]?.amount * product.quantity,
      0
    );

    const totalItems = products.reduce(
      (total, product) => total + product.quantity,
      0
    );

    return (
      <section className="absolute z-50 bg-white shadow-lg -right-3.5 top-full w-80 py-6 px-4">
        <h2 className="mb-6">
          <span className="font-bold">My Bag</span>
          {!!totalItems && `, ${totalItems} item${totalItems === 1 ? '' : 's'}`}
        </h2>

        {totalItems === 0 ? (
          <p className="mt-2 text-gray-500">Your bag is empty.</p>
        ) : (
          <>
            <div className="space-y-8 overflow-y-auto max-h-80">
              {products.map((product) => (
                <CartModalItem key={product.id} product={product} />
              ))}
            </div>

            <div className="pt-4 mt-4">
              <div className="flex items-center justify-between">
                <h3 className="font-semibold font-roboto">Total</h3>
                <div className="font-bold">{totalPrice.toFixed(2)}</div>
              </div>

              <button type="button" className="w-full mt-8 btn-cta">
                Place Order
              </button>
            </div>
          </>
        )}
      </section>
    );
  }
}

CartModal.propTypes = {
  products: PropTypes.arrayOf(PropTypes.object),
};

export default CartModal;
