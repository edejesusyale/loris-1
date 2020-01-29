### Create base docker image
```
docker build -t loris .
```

### Run tests
From project directory:
```
docker run --mount type=bind,source="$(pwd)",target=/opt/app-root/src --rm  -ti loris bash -l -c "pytest tests/*"
```

### Run the webapp
From project directory:

First edit loris/webapp.py so that the first argument to run_simple is "0.0.0.0" so that the webapp binds to all interefaces.

```
docker run --mount type=bind,source="$(pwd)",target=/opt/app-root/src --mount type=bind,source=$(pwd)/tests/img,target=/usr/local/share/images -p 5004:5004 --name loris_webapp --rm  -ti loris bash -l -c "python3.6 loris/webapp.py"
```
^C to exit container
```
http://localhost:5004/grid_ptiff.tiff/full/full/0/default.jpg
http://localhost:5004/grid_ptiff.tiff/full/50,/0/default.jpg
http://localhost:5004/grid_ptiff.tiff/info.json
http://localhost:5004/color_coded_ptiff.tif/info.json
http://localhost:5004/color_coded_ptiff.tif/full/150,/0/default.jpg
http://localhost:5004/color_coded_ptiff.tif/full/50,/0/default.jpg
http://localhost:5004/color_coded_ptiff.tif/full/full/0/default.jpg
```


### Connect to running vm
```
docker exec -ti loris_webapp bash 
```
