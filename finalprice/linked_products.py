def link_products(products):
    linked_products = {}
    for store, products_list in products.items():
        for product in products_list:
            title = product['title']
            if title not in linked_products:
                linked_products[title] = []
            linked_products[title].append({store: product})
    
    # Link products with the same title across stores
    for title, products_list in linked_products.items():
        if len(products_list) > 1:
            for product_entry in products_list:
                product_entry[store]['linked_products'] = [
                    p for p in products_list if p != product_entry
                ]
    
    return linked_products
