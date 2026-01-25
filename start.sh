docker build -t bios992 .

docker run -d \
	--name bios992 \
	-p 8787:8787 \
	-e PASSWORD=password \
	-v "$HOME/bios992/:/home/rstudio/project" \
	bios992
