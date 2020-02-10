### Create base docker image
```
docker build -t loris .
```

### Run tests
From project directory:
```
docker run --mount type=bind,source="$(pwd)",target=/opt/app-root/src --rm  -ti loris bash -l -c "pytest tests/*"
```
