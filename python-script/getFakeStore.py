import requests
import json

# url = "https://api.escuelajs.co/api/v1/products?offset=0&limit=5"
# response = requests.get(url)
# json_obj = response.json()

# Below list is a small part of the above API call. Currently building and testing a ETL pipeline to extract data from an API.
lst = {"id": 4, "title": "Classic Grey Hooded Sweatshirt", "slug": "classic-grey-hooded-sweatshirt", "price": 90, "description": "Elevate your casual wear with our Classic Grey Hooded Sweatshirt. Made from a soft cotton blend, this hoodie features a front kangaroo pocket, an adjustable drawstring hood, and ribbed cuffs for a snug fit. Perfect for those chilly evenings or lazy weekends, it pairs effortlessly with your favorite jeans or joggers.", "category": {"id": 1, "name": "Clothes", "slug": "clothes", "image": "https://i.imgur.com/QkIa5tT.jpeg", "creationAt": "2025-02-25T08:40:18.000Z", "updatedAt": "2025-02-25T10:13:18.000Z"}, "images": ["https://i.imgur.com/R2PN9Wq.jpeg", "https://i.imgur.com/IvxMPFr.jpeg", "https://i.imgur.com/7eW9nXP.jpeg"], "creationAt": "2025-02-25T08:40:18.000Z", "updatedAt": "2025-02-25T08:40:18.000Z"}

lst_keys = lst.keys()
    
for key_loop in lst_keys:
    print(f'key:{key_loop} with value: {lst[key_loop]}')