

# what is REST API and what are the common HTTP methods?
A REST API (Representational State Transfer) is an architectural style used to build web services that allow different computer systems to communicate over the internet.

In a RESTful architecture, every piece of data (like a user, a product, or an image) is treated as a resource. 
Each resource is assigned a unique web address called a URI or Endpoint (e.g., https://example.com), and clients interact with these endpoints using specific HTTP methods. 

The data exchanged is typically formatted in JSON, which is easily readable by both humans and machines.

# The Common HTTP Methods
standard CRUD database operations (Create, Read, Update, Delete).


HTTP MethodCRUD ActionDescriptionExample Endpoint / ActionGETReadRetrieves data from the server. It is safe and idempotent, meaning it only reads data and will not change the server's state no matter how many times you call it.GET /users(Fetches a list of all users)POSTCreateSubmits data to the server to create a new resource. It is not idempotent, as sending the same request twice usually creates two separate entries.POST /users(Creates a new user profile)