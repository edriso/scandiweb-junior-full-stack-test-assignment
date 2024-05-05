function ProductDetail() {
  // Define sizes and colors arrays
  const sizes = ['XS', 'S', 'M', 'L'];
  const colors = ['#FF0000', '#0000FF', '#00FF00'];

  return (
    <main className="flex flex-col md:flex-row items-start">
      <div className="md:w-2/3">
        <img
          src="https://images.canadagoose.com/image/upload/w_1333,c_scale,f_auto,q_auto:best/v1634058169/product-image/2409L_61_o.png"
          alt="Product"
          className="w-full"
        />
      </div>

      <aside className="md:w-1/3 md:pl-4">
        <h2 className="heading-h1">Product Name</h2>

        <div className="mb-4">
          <h3 className="heading-h3">Sizes:</h3>
          <div className="flex space-x-3">
            {sizes.map((size) => (
              <button
                key={size}
                className="w-20 h-10 bg-white border border-gray-800 flex items-center justify-center transition duration-300 hover:bg-gray-800 hover:text-white"
              >
                {size}
              </button>
            ))}
          </div>
        </div>

        <div className="mb-4">
          <h3 className="heading-h3">Colors:</h3>
          <div className="flex space-x-3">
            {colors.map((color) => (
              <div
                key={color}
                className="w-8 h-8"
                style={{ backgroundColor: color }}
              ></div>
            ))}
          </div>
        </div>

        <h3 className="heading-h3">Price:</h3>
        <div className="heading-h2">$50.00</div>

        <button className="btn-cta w-full mb-8">Add to Cart</button>

        <p className="font-roboto text-sm">
          Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus nec
          metus non justo malesuada volutpat. Integer et justo id felis blandit
          lacinia.
        </p>
      </aside>
    </main>
  );
}

export default ProductDetail;
