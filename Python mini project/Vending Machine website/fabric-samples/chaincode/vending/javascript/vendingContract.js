'use strict';

const { Contract } = require('fabric-contract-api');

class VendingContract extends Contract {

  // Initialize ledger with optional seed data
  async InitLedger(ctx) {
    console.info('Ledger initialized');
  }

  // Check if product exists
  async ProductExists(ctx, id) {
    const buffer = await ctx.stub.getState(id);
    return (!!buffer && buffer.length > 0);
  }

  // Add new product (Admin)
  async AddProduct(ctx, id, name, price, quantity) {
    const exists = await this.ProductExists(ctx, id);
    if (exists) {
      throw new Error(`Product ${id} already exists`);
    }

    const product = {
      id,
      name,
      price: parseFloat(price),
      quantity: parseInt(quantity),
    };

    await ctx.stub.putState(id, Buffer.from(JSON.stringify(product)));
    return JSON.stringify(product);
  }

  // Update existing product (Admin)
  async UpdateProduct(ctx, id, name, price, quantity) {
    const exists = await this.ProductExists(ctx, id);
    if (!exists) {
      throw new Error(`Product ${id} does not exist`);
    }

    const updatedProduct = {
      id,
      name,
      price: parseFloat(price),
      quantity: parseInt(quantity),
    };

    await ctx.stub.putState(id, Buffer.from(JSON.stringify(updatedProduct)));
    return JSON.stringify(updatedProduct);
  }

  // Delete product (Admin)
  async DeleteProduct(ctx, id) {
    const exists = await this.ProductExists(ctx, id);
    if (!exists) {
      throw new Error(`Product ${id} does not exist`);
    }

    await ctx.stub.deleteState(id);
  }

  // Get all products (Admin and Student)
  async GetAllProducts(ctx) {
    const allResults = [];
    const iterator = await ctx.stub.getStateByRange('', '');

    for await (const res of iterator) {
      if (res.value && res.value.length > 0) {
        const product = JSON.parse(res.value.toString());
        allResults.push(product);
      }
    }

    return JSON.stringify(allResults);
  }

  // Get single product by ID (Student page)
  async GetProduct(ctx, id) {
    const exists = await this.ProductExists(ctx, id);
    if (!exists) {
      throw new Error(`Product ${id} does not exist`);
    }
    const productJSON = await ctx.stub.getState(id);
    return productJSON.toString();
  }

  // Buy product: decrease quantity (Student page)
  async BuyProduct(ctx, id, quantity) {
    const exists = await this.ProductExists(ctx, id);
    if (!exists) {
      throw new Error(`Product ${id} does not exist`);
    }

    const productBuffer = await ctx.stub.getState(id);
    const product = JSON.parse(productBuffer.toString());

    const qtyToBuy = parseInt(quantity);
    if (product.quantity < qtyToBuy) {
      throw new Error(`Insufficient quantity. Only ${product.quantity} left.`);
    }

    product.quantity -= qtyToBuy;

    await ctx.stub.putState(id, Buffer.from(JSON.stringify(product)));
    return JSON.stringify(product);
  }
}

module.exports = VendingContract;
