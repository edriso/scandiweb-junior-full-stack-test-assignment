import PropTypes from 'prop-types';
import { toast } from 'react-toastify';
import { useMutation } from '@apollo/client';
import { PLACE_ORDER } from '../../graphql/mutations';
import { Spinner } from '../';

function PlaceOrderBtn({ className }) {
  const [placeOrder, { loading }] = useMutation(PLACE_ORDER);

  const handlePlaceOrder = async () => {
    const cartItems = JSON.parse(localStorage.getItem('cartItems')) || [];

    if (!cartItems.length) {
      return toast.error('Cart is empty! 🛒');
    }

    const orderInput = {
      items: cartItems.map((item) => {
        return {
          productId: item.product.id,
          quantity: item.quantity,
          attributeValues: item.selectedAttributes.map((attr) => ({
            id: attr.id,
            value: attr.value,
          })),
        };
      }),
    };

    try {
      const { data } = await placeOrder({
        variables: { orderInput: orderInput },
      });

      console.log(data);
      // toast.success(`Order placed successfully! Order ID: ${data.placeOrder.id}`);
      // localStorage.removeItem('cartItems');
    } catch (err) {
      console.error('Error placing order:', err);
    }
  };

  return (
    <button
      type="button"
      className={`btn-cta flex items-center justify-center disabled:opacity-70${
        className ? ' ' + className : ''
      }`}
      onClick={handlePlaceOrder}
      disabled={loading}
    >
      {loading && <Spinner className="w-4 h-4 mr-2" />}
      Place Order
    </button>
  );
}

PlaceOrderBtn.propTypes = {
  className: PropTypes.string,
};

export default PlaceOrderBtn;
