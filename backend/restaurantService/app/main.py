import os
from fastapi import FastAPI
from typing import Optional, List

from fastapi import FastAPI, Body, HTTPException, status
from fastapi.responses import Response
from pydantic import BaseModel, Field, EmailStr, validator
from pymongo import MongoClient, ReturnDocument
from pymongo.mongo_client import MongoClient
from pymongo.server_api import ServerApi
from bson import ObjectId, Regex

from typing_extensions import Annotated

MONGO_HOST = "mongo"
MONGO_PORT = 27017

client = MongoClient(MONGO_HOST, MONGO_PORT)

db = client["ByteDriver"]
collection = db["restaurants"]

PyObjectId = Annotated[str, Field(alias="_id", default=None)]

class MenuItem(BaseModel):
    id: Optional[int] = None
    name: str
    description: str
    price: float

class RestaurantModel(BaseModel):
    #id: Optional[PyObjectId] = Field(alias="_id", default=None)
    name: str
    hours: Optional[str]
    location: Optional[str]
    menu: Optional[List[MenuItem]]

    @classmethod
    def parse_obj(cls, obj):
        obj["id"] = str(obj["_id"])
        return super().model_validate(obj)

    @validator("menu", each_item=True)
    def check_menu(cls, v):
        if not isinstance(v, MenuItem):
            raise ValueError("Each item in menu must be a MenuItem")
        return v

app = FastAPI()

@app.get("/")
async def root():
    return {"message": "Hello World"}

@app.get("/restaurant/test")
async def get_restaurant():
    return {"restaurant": "McDonalds"}

@app.get("/restaurant", response_model=List[RestaurantModel])
async def get_restaurants():
    print("Getting restaurants")
    restaurants = list(collection.find({}))
    return restaurants

@app.post("/restaurant")
async def post_restaurant(restaurant: RestaurantModel):
    if restaurant.menu:
        for idx, menu_item in enumerate(restaurant.menu, start=1):
            menu_item.id = idx

    result = collection.insert_one(restaurant.dict(by_alias=True))

    if result.inserted_id:
        return {"message": "Restaurant added successfully"}
    else:
        return {"message": "Failed to add restaurant"}


@app.delete("/restaurant/{restaurant_id}")
async def delete_restaurant(restaurant_id: str):
    result = collection.delete_one({"_id": ObjectId(restaurant_id)})

    if result.deleted_count:
        return {"message": "Restaurant deleted successfully"}
    else:
        return {"message": "Failed to delete restaurant"}
    

@app.put("/restaurant/{restaurant_id}", response_model=List[RestaurantModel])
async def update_restaurant(restaurant_id: str, restaurant_data: dict):
    restaurant_data = {k: v for k, v in restaurant_data.items() if v is not None} 
    if not restaurant_data:
        raise HTTPException(status_code=400, detail="No valid fields provided for update")
    
    result = collection.find_one_and_update(
        {"_id": ObjectId(restaurant_id)},
        {"$set": restaurant_data},
        return_document=ReturnDocument.AFTER
    )

    if result:
        return [result]
    else:
        raise HTTPException(status_code=404, detail="Restaurant not found")

@app.get("/restaurant/{restaurant_name}", response_model=List[RestaurantModel])
async def get_restaurant_by_name(restaurant_name: str):
    regex_pattern = f".*{restaurant_name}.*"
    regex_query = Regex(regex_pattern, "i")
    restaurants = collection.find({"name": regex_query})

    return list(restaurants)

@app.get("/restaurant/{restaurant_id}/menu")
async def get_menu(restaurant_id: str):
    restaurant = collection.find_one({"_id": ObjectId(restaurant_id)})
    return restaurant["menu"]

@app.post("/restaurant/{restaurant_id}/menu")
async def add_menu_item(restaurant_id: str, menu_item: MenuItem):
    # Find the restaurant
    restaurant = collection.find_one({"_id": ObjectId(restaurant_id)})
    if restaurant is None:
        raise HTTPException(status_code=404, detail="Restaurant not found")

    if 'menu' not in restaurant:
        restaurant['menu'] = []

    menu_item_id = len(restaurant['menu']) + 1

    menu_item.id = menu_item_id

    restaurant['menu'].append(menu_item.dict())

    result = collection.update_one(
        {"_id": ObjectId(restaurant_id)},
        {"$set": {"menu": restaurant['menu']}}
    )

    if result.modified_count:
        return {"message": "Menu item added successfully"}
    else:
        return {"message": "Failed to add menu item"}

    
@app.delete("/restaurant/{restaurant_id}/menu/{menu_item_id}")
async def delete_menu_item(restaurant_id: str, menu_item_id: int):
    restaurant = collection.find_one({"_id": ObjectId(restaurant_id)})
    if restaurant is None:
        raise HTTPException(status_code=404, detail="Restaurant not found")

    if 'menu' not in restaurant:
        raise HTTPException(status_code=404, detail="Menu not found")

    menu_item = next((item for item in restaurant['menu'] if item['id'] == menu_item_id), None)
    if menu_item is None:
        raise HTTPException(status_code=404, detail="Menu item not found")

    restaurant['menu'] = [item for item in restaurant['menu'] if item['id'] != menu_item_id]

    result = collection.update_one(
        {"_id": ObjectId(restaurant_id)},
        {"$set": {"menu": restaurant['menu']}}
    )

    if result.modified_count:
        return {"message": "Menu item deleted successfully"}
    else:
        return {"message": "Failed to delete menu item"}
    
@app.put("/restaurant/{restaurant_id}/menu/{menu_item_id}")
async def update_menu_item(restaurant_id: str, menu_item_id: int, menu_item_data: dict):
    restaurant = collection.find_one({"_id": ObjectId(restaurant_id)})
    if restaurant is None:
        raise HTTPException(status_code=404, detail="Restaurant not found")

    if 'menu' not in restaurant:
        raise HTTPException(status_code=404, detail="Menu not found")

    menu_item = next((item for item in restaurant['menu'] if item['id'] == menu_item_id), None)
    if menu_item is None:
        raise HTTPException(status_code=404, detail="Menu item not found")

    menu_item_data = {k: v for k, v in menu_item_data.items() if v is not None} 
    if not menu_item_data:
        raise HTTPException(status_code=400, detail="No valid fields provided for update")

    for key, value in menu_item_data.items():
        menu_item[key] = value

    result = collection.update_one(
        {"_id": ObjectId(restaurant_id)},
        {"$set": {"menu": restaurant['menu']}}
    )

    if result.modified_count:
        return {"message": "Menu item updated successfully"}
    else:
        return {"message": "Failed to update menu item"}

# TODO: Make sure to put main.py back into /restaurantService/app before running docker-compose up