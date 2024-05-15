from fastapi import APIRouter,FastAPI

router = APIRouter(prefix="/post_data", tags=["post"])
app = FastAPI()

@router.get("/test")
def get():
    print("hello")