function calculation() {

  const itemPrice = document.getElementById("item-price")
  const addTaxPrice = document.getElementById("add-tax-price")
  const Profit = document.getElementById("profit")

  itemPrice.getAttribute("price")
  
  itemPrice.addEventListener('input', function(){
    value = itemPrice.value
    addTaxPrice.innerHTML = Math.floor(value * 0.1).toLocaleString()
    Profit.innerHTML = Math.floor(value * 0.9).toLocaleString()
  })
}

window.addEventListener('load', calculation)

