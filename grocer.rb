require "pry"

def consolidate_cart(cart)
  # code here
  cart_hash = {}
  cart.each do |item|
    item.each do |product, features|
      if cart_hash.has_key?(product)
        cart_hash[product][:count] += 1
      else
        cart_hash[product] = features
        cart_hash[product][:count] = 1
      end
    end
  end
  cart_hash
end

def apply_coupons(cart, coupons)
  # code here
  #binding.pry
  coupons.each do |coupon|
    if cart.has_key?(coupon[:item])
      if cart[coupon[:item]][:count] >= coupon[:num]
        cart["#{coupon[:item]} W/COUPON"] = {}
        cart["#{coupon[:item]} W/COUPON"][:price] = coupon[:cost]
        cart["#{coupon[:item]} W/COUPON"][:clearance] = cart[coupon[:item]][:clearance]
        cart["#{coupon[:item]} W/COUPON"][:count] = cart[coupon[:item]][:count] / coupon[:num]
        cart[coupon[:item]][:count] = cart[coupon[:item]][:count] % coupon[:num]
      end
    end
  end
  cart
end

def apply_clearance(cart)
  # code here
  cart.collect do |product, feat|
    if feat[:clearance] == true
      feat[:price] = (feat[:price].to_f * 0.8).round(1)
    end
  end
  cart
end

def checkout(cart, coupons)
  # code here
  total = 0
  cart_hash = consolidate_cart(cart)
  cart_hash = apply_coupons(cart_hash, coupons)
  cart_hash = apply_clearance(cart_hash)
  cart_hash.each do |products, info|
    total += info[:count]*info[:price]
  end
  if total > 100
    total = total * 0.9
  end
  total
end
