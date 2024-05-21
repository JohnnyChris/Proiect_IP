from fastapi import FastAPI, Request, status
from fastapi.responses import RedirectResponse
import uvicorn
from fastapi.middleware.cors import CORSMiddleware
import Api.Get_data as get_data
import Api.Post_data as post_data  # Assuming this file exists for other POST operations
from uvicorn.config import LOGGING_CONFIG
import colorama

LOGGING_CONFIG["formatters"]["default"]["fmt"] = "%(asctime)s %(levelprefix)s %(message)s"
LOGGING_CONFIG["formatters"]["access"]["fmt"] = "%(asctime)s %(name)s %(levelprefix)s %(client_addr)s %(request_line)s %(status_code)s"

colorama.init()
app = FastAPI()

@app.route("/")
def index(request: Request):
    return RedirectResponse(f"{request.base_url}docs", status_code=status.HTTP_303_SEE_OTHER)

app.add_middleware(CORSMiddleware,
                   allow_origins=["*"],  # Adjust according to your needs
                   allow_methods=["*"],
                   allow_headers=["*"],
                   expose_headers=["*"],
                   )

app.include_router(get_data.router)
app.include_router(post_data.router)  # If you have this file

if __name__ == "__main__":
    uvicorn.run(app)
