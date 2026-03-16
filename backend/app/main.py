from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from pymongo import MongoClient
from datetime import datetime

app = FastAPI(title="Le Cri du Soir API")

# CORS for Flutter web
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# MongoDB connection
client = MongoClient(
    "mongodb://admindb:Frogd%40nce2024@10.0.0.14:27017/whatsapp_bot_db?authSource=admin"
)

db = client["whatsapp_bot_db"]

prayer_collection = db["prayers"]

@app.get("/")
def home():
    return {"message": "Le Cri du Soir API running"}

# ----------------------------------
# Events API
# ----------------------------------

@app.get("/events")
def events():
    return [
        {
            "title": "Conference Spirituelle",
            "speaker": "Frere Antoine"
        }
    ]

# ----------------------------------
# Service Schedule
# ----------------------------------

@app.get("/schedule")
def schedule():
    return [
        {"event": "Morning Prayer", "time": "06:00"},
        {"event": "Evening Prayer", "time": "21:00"}
    ]

# ----------------------------------
# Prayer Wall
# ----------------------------------

@app.get("/prayers")
def get_prayers():

    prayers = list(
        prayer_collection.find({}, {"_id": 0})
    )

    return prayers


@app.post("/prayers")
async def add_prayer(prayer: dict):

    prayer["count"] = 0

    prayer["date"] = datetime.now().strftime("%Y-%m-%d")

    prayer_collection.insert_one(prayer)

    return {"status": "prayer added"}


@app.post("/pray/{name}")
async def pray_for_request(name: str):

    prayer_collection.update_one(
        {"name": name},
        {"$inc": {"count": 1}}
    )

    return {"status": "updated"}