@echo off

REM Create directories
mkdir tempdir
mkdir tempdir\templates
mkdir tempdir\static

REM Copy files
copy sample_app.py tempdir\
xcopy templates\* tempdir\templates\ /E /I /Y
xcopy static\* tempdir\static\ /E /I /Y

REM Create Dockerfile
echo FROM python> tempdir\Dockerfile
echo RUN pip install flask>> tempdir\Dockerfile
echo COPY ./static /home/myapp/static/>> tempdir\Dockerfile
echo COPY ./templates /home/myapp/templates/>> tempdir\Dockerfile
echo COPY sample_app.py /home/myapp/>> tempdir\Dockerfile
echo EXPOSE 5050>> tempdir\Dockerfile
echo CMD python /home/myapp/sample_app.py>> tempdir\Dockerfile

REM Build Docker image
cd tempdir
docker build -t sampleapp .

REM Run container
docker run -t -d -p 5050:5050 --name samplerunning sampleapp

REM Show containers
docker ps -a