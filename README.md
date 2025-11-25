# Imapsync with WebUI
(forked from [mrickl/ImapsyncWebUI](https://github.com/mrickl/ImapsyncWebUI))

## German
Dies ist das Repostiory für das Docker Container "Imapsyncwithwebui"

Imapsync with WebUI ist eine Kombination aus dem Imapsync von https://imapsync.lamiral.info/ und seiner WebUI.

Da es bisher nur das Imapsync als Docker gab, aber bisher nicht in Kombination mit der WebUI habe ich dieses Docker Container gebaut.

Der Webserver Port innerhalb des Containers ist Port 80. 

Installtion des Containers: 

## English
This is the repostiory for the Docker container "Imapsyncwithwebui".

Imapsync with WebUI is a combination of the Imapsync from https://imapsync.lamiral.info/ and his WebUI.

Since so far there was only the Imapsync as Docker, but so far not in combination with the WebUI .

The web server port inside the container is port 80. 

Installtion of the container: 

## Installation
### Build
> docker build --tag 'deadmanIsARabbit/imapsyncwithwebui' . 
### Run
> docker run -d --name imapsync -p 80:80 deadmanIsARabbit/imapsyncwithwebui

## Information

Der "Abort" Button hat im Docker Container keine Funktion, aufgrund der im Docker befindlichen /.dockerenv Datei. Hierfür gibt es allerdings einen Workaround, wodurch das Abbrechen der Sync Jobs möglich ist. Ich bin bereits an einer Lösung dran damit der Workaround nicht benötigt wird

The "Abort" button has no function in the Docker container, because of the /.dockerenv file located in Docker. However, there is a workaround for this, which makes it possible to abort the sync jobs. I am already working on a solution so that the workaround is not needed.

> docker exec imapsync rm ./dockerenv